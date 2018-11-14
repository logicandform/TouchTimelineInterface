//  Copyright © 2018 JABT. All rights reserved.

import Foundation
import MapKit
import MONode
import PromiseKit
import AppKit


final class TimelineDataSource: NSObject, NSCollectionViewDataSource {

    var selectedIndexes = Set<Int>()
    var highlightedIndexes = Set<Int>()
    private(set) var events = [TimelineEvent]()
    private(set) var eventsForYear = [Int: [TimelineEvent]]()
    private(set) var firstYear: Int!
    private(set) var lastYear: Int!
    private(set) var years = [Int]()
    private var uniqueEvents = 0

    private struct Constants {
        static let defaultFirstYear = 1850
        static let defaultLastYear = 2030
    }


    // MARK: API

    func setup(with records: [Record]) {
        events = records.compactMap { record in
            let startMonth = Int.random(in: 0...11)
            let startYear = Int.random(in: 1850...1970)
            let endMonth = Int.random(in: 0...11)
            let endYear = startYear + Int.random(in: 5...60)
            let dates = DateRange(start: RecordDate(day: nil, month: startMonth, year: startYear), end: RecordDate(day: nil, month: endMonth, year: endYear))
            return TimelineEvent(id: record.id, type: record.type, title: record.title, dates: dates, thumbnail: nil, localThumbnail: nil)
        }

        events = events.sorted { lhs, rhs in
            if lhs.dates.startDate == rhs.dates.startDate {
                if lhs.type.sortOrder == rhs.type.sortOrder {
                    return lhs.id < rhs.id
                }
                return lhs.type.sortOrder < rhs.type.sortOrder
            }
            return lhs.dates.startDate < rhs.dates.startDate
        }

        uniqueEvents = events.count
        let minYear = events.map { $0.dates.startDate.year }.min() ?? Constants.defaultFirstYear
        let maxYear = events.compactMap { $0.dates.endDate?.year }.max() ?? Constants.defaultLastYear
        firstYear = (minYear / 10) * 10 - 10
        lastYear = (maxYear / 10) * 10 + 10
        years = Array(firstYear...lastYear)

        for event in events {
            if event.dates.startDate.year < firstYear + TimelineDecadeFlagLayout.infiniteScrollBuffer {
                let infiniteBufferEvent = TimelineEvent(id: event.id, type: event.type, title: event.title, dates: event.dates, thumbnail: event.thumbnail, localThumbnail: event.localThumbnail)
                infiniteBufferEvent.dates.startDate.year += years.count
                infiniteBufferEvent.dates.endDate?.year += years.count
                events.append(infiniteBufferEvent)
            }
        }

        // Add to year dictionary
        for event in events {
            if eventsForYear[event.dates.startDate.year] != nil {
                eventsForYear[event.dates.startDate.year]!.append(event)
            } else {
                eventsForYear[event.dates.startDate.year] = [event]
            }
        }
    }

    func set(index: Int, selected: Bool) {
        if selected {
            selectedIndexes.insert(index)
            if let duplicateIndex = getDuplicateIndex(original: index) {
                selectedIndexes.insert(duplicateIndex)
            }
        } else {
            selectedIndexes.remove(index)
            if let duplicateIndex = getDuplicateIndex(original: index) {
                selectedIndexes.remove(duplicateIndex)
            }
        }
    }

    func set(index: Int, highlighted: Bool) {
        if highlighted {
            highlightedIndexes.insert(index)
            if let duplicateIndex = getDuplicateIndex(original: index) {
                highlightedIndexes.insert(duplicateIndex)
            }
        } else {
            highlightedIndexes.remove(index)
            if let duplicateIndex = getDuplicateIndex(original: index) {
                highlightedIndexes.remove(duplicateIndex)
            }
        }
    }

    func getDuplicateIndex(original index: Int) -> Int? {
        if index + uniqueEvents < events.count {
            return index + uniqueEvents
        } else if index - uniqueEvents >= 0 {
            return index - uniqueEvents
        } else {
            return nil
        }
    }


    // MARK: NSCollectionViewDataSource

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let timelineFlag = collectionView.makeItem(withIdentifier: TimelineFlagView.identifier, for: indexPath) as? TimelineFlagView else {
            return NSCollectionViewItem()
        }

        let constrainedIndex = indexPath.item % uniqueEvents
        let event = events[constrainedIndex]
        timelineFlag.event = event
        timelineFlag.set(highlighted: selectedIndexes.contains(constrainedIndex), animated: false)
        return timelineFlag
    }

    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
        switch kind {
        case TimelineHeaderView.supplementaryKind:
            if let headerView = collectionView.makeSupplementaryView(ofKind: kind, withIdentifier: TimelineHeaderView.identifier, for: indexPath) as? TimelineHeaderView {
                let year = firstYear + (indexPath.item % years.count)
                headerView.set(text: year.description)
                return headerView
            }
        case TimelineBorderView.supplementaryKind:
            if let borderView = collectionView.makeSupplementaryView(ofKind: kind, withIdentifier: TimelineBorderView.identifier, for: indexPath) as? TimelineBorderView {
                return borderView
            }
        case TimelineTailView.supplementaryKind:
            if let tailView = collectionView.makeSupplementaryView(ofKind: kind, withIdentifier: TimelineTailView.identifier, for: indexPath) as? TimelineTailView, let layout = collectionView.collectionViewLayout as? TimelineDecadeFlagLayout {
                let year = indexPath.item
                let layers = layout.layersForYear[year] ?? []
                tailView.set(layers)
                return tailView
            }
        default:
            return NSView()
        }

        return NSView()
    }


    // MARK: Helpers

    private func yearInRange(for year: Int) -> Int {
        if year > lastYear {
            return (year - firstYear) % years.count + firstYear
        } else {
            return year
        }
    }
}
