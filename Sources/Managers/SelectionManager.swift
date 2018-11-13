//  Copyright © 2018 JABT. All rights reserved.

import Foundation
import Cocoa


// Interface for the TimelineHandler to update it's views
protocol SelectionHandler: class {
    func handle(item: Int, selected: Bool)
    func replace(selection: Set<TimelineSelection>)
    func handle(items: Set<Int>, highlighted: Bool)
    func replace(highlighted: Set<Int>)
}


/// Handles notifications for Timeline selection and highlights
final class SelectionManager {
    static let instance = SelectionManager()

    weak var delegate: SelectionHandler?

    private var selection = Set<TimelineSelection>()

    /// Remaining duration of highlight for event supplied by it's id
    private var timeForHighlight = [Int: Int]()

    /// The current time of the system core video clock
    private var currentTime = UInt64.min

    /// The timer used to update the current time and decrement highlight times
    private weak var highlightTimer: Foundation.Timer?

    private struct Constants {
        static let highlightDuration = 25
        static let highlightTimerInterval = 0.1
    }


    // MARK: Init

    /// Use Singleton
    private init() {
        highlightTimer = Timer.scheduledTimer(withTimeInterval: Constants.highlightTimerInterval, repeats: true) { [weak self] _ in
            self?.highlightTimerFired()
        }
        highlightTimer?.tolerance = Constants.highlightTimerInterval / 10
    }


    // MARK: API

    func set(item: Int, selected: Bool) {
        delegate?.handle(item: item, selected: selected)
    }

    func highlight(item: Int) {
        delegate?.handle(items: [item], highlighted: true)
    }


    // MARK: Helpers

    private func highlightTimerFired() {
        let time = CVGetCurrentHostTime() / UInt64(CVGetHostClockFrequency())
        if time != currentTime {
            decrementHighlightDuration()
            currentTime = time
        }
    }

    private func decrementHighlightDuration() {
        var itemsToSet = Set<Int>()

        for (index, time) in timeForHighlight {
            let newTime = time - 1
            if newTime <= 0 {
                timeForHighlight.removeValue(forKey: index)
                itemsToSet.insert(index)
            } else {
                timeForHighlight[index] = newTime
            }
        }

        if !itemsToSet.isEmpty {
            delegate?.handle(items: itemsToSet, highlighted: false)
        }
    }
}
