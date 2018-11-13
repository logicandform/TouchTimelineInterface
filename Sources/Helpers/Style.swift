//  Copyright © 2018 slant. All rights reserved.

import Foundation
import AppKit


final class Style {


    // MARK: General Properties

    let darkBackground = NSColor(srgbRed: 30/255, green: 33/255, blue: 35/255, alpha: 0.98)
    let darkBackgroundOpaque = NSColor(srgbRed: 17/255, green: 17/255, blue: 17/255, alpha: 1)
    let dragAreaBackground = NSColor(srgbRed: 30/255, green: 33/255, blue: 35/255, alpha: 0.98)
    let menuTintColor = NSColor(calibratedRed: 0, green: 0.90, blue: 0.70, alpha: 1)
    let touchIndicatorColor = NSColor.gray
    let defaultBorderColor = NSColor(white: 0.5, alpha: 1)
    let defaultBorderWidth: CGFloat = 1
    let defaultBorderZPosition: CGFloat = 20
    let windowHighlightWidth: CGFloat = 3
    let windowHighlightZPosition: CGFloat = 10
    let windowBorderZPosition: CGFloat = 10


    // MARK: RecordType Colors

    let artifactColor = NSColor(srgbRed: 205/255, green: 33/255, blue: 54/255, alpha: 1)
    let schoolColor = NSColor(srgbRed: 7/255, green: 61/255, blue: 224/255, alpha: 1)
    let eventColor = NSColor(srgbRed: 228/255, green: 54/255, blue: 188/255, alpha: 1)
    let organizationColor = NSColor(srgbRed: 0/255, green: 159/255, blue: 75/255, alpha: 1)
    let collectionColor = NSColor(srgbRed: 229/255, green: 121/255, blue: 0/255, alpha: 1)
    let individualColor = NSColor.red
    let themeColor = NSColor(srgbRed: 0/255, green: 154/255, blue: 254/255, alpha: 1)


    // MARK: Window Levels

    let masterWindowLevel = NSWindow.Level.normal
    let nodeWindowLevel = NSWindow.Level(27)
    let mapWindowLevel = NSWindow.Level(28)
    let timelineWindowLevel = NSWindow.Level(29)
    let borderWindowLevel = NSWindow.Level(30)
    let recordWindowLevel = NSWindow.Level(31)
    let menuWindowLevel = NSWindow.Level(32)
    let touchIndicatorWindowLevel = NSWindow.Level(33)

    
    // MARK: Windows Properties

    let recordWindowSize = CGSize(width: 416, height: 650)
    let collectionRecordWindowSize = CGSize(width: 416, height: 650)
    let imageWindowSize = CGSize(width: 640, height: 410)
    let pdfWindowSize = CGSize(width: 600, height: 640)
    let playerWindowSize = CGSize(width: 1013, height: 650)
    let searchWindowFrame = CGSize(width: 300, height: 655)
    let menuWindowWidth: CGFloat = 700
    let borderWindowWidth: CGFloat = 4
    let infoWindowSize = CGSize(width: 500, height: 800)
    let masterWindowSize = CGSize(width: 740, height: 500)
    let minMediaWindowWidth: CGFloat = 416
    let maxMediaWindowWidth: CGFloat = 650
    let minMediaWindowHeight: CGFloat = 416
    let maxMediaWindowHeight: CGFloat = 650
    let windowMargins: CGFloat = 20
    let windowStackOffset = CGVector(dx: 25, dy: -40)


    // MARK: Timeline

    let timelineBackgroundColor = NSColor(white: 0.1, alpha: 0.95)
    let timelineBorderColor = NSColor.gray
    let timelineShadingColor = NSColor.black.withAlphaComponent(0.5)
    let timelineHeaderText = NSColor.gray
    let timelineBorderWidth: CGFloat = 2
    let timelineHeaderHeight: CGFloat = 30
    let timelineHeaderOffset: CGFloat = 18
    let timelineFlagBackgroundColor = NSColor.black.withAlphaComponent(0.8)
    let timelineItemWidth: CGFloat = 180
    let timelineFlagPoleWidth: CGFloat = 2
    let timelineTailColor = NSColor(white: 0.2, alpha: 1)
    let timelineTailWidth: CGFloat = 1
    let timelineTailMargin: CGFloat = 9
    lazy var timelineTailGap: CGFloat = timelineTailWidth + timelineTailMargin
    let timelineTailMarkerWidth: CGFloat = 1


    // MARK: Title Attributes

    var timelineTitleAttributes: [NSAttributedString.Key: Any] {
        let font = NSFont(name: "Soleil", size: 14) ?? NSFont.systemFont(ofSize: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping

        return [.paragraphStyle: paragraphStyle,
                .font: font,
                .foregroundColor: NSColor.white,
                .kern: 1]
    }

    var timelineDateAttributes: [NSAttributedString.Key: Any] {
        let font = NSFont(name: "Soleil", size: 9) ?? NSFont.systemFont(ofSize: 9)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail

        return [.paragraphStyle: paragraphStyle,
                .font: font,
                .foregroundColor: NSColor.white,
                .kern: 1]
    }

    var recordDateAttributes: [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.paragraphSpacingBefore = 0
        let font = NSFont(name: "SoleilLt", size: 14) ?? NSFont.systemFont(ofSize: 14)
        return [.paragraphStyle: paragraphStyle,
                .font: font,
                .foregroundColor: NSColor.white,
                .kern: 0.5
        ]
    }

    var recordDescriptionAttributes: [NSAttributedString.Key: Any] {
        let fontSize: CGFloat = 16
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.paragraphSpacing = 8
        paragraphStyle.maximumLineHeight = fontSize + 5
        paragraphStyle.lineBreakMode = .byWordWrapping
        let font = NSFont(name: "SoleilLt", size: fontSize) ?? NSFont.systemFont(ofSize: fontSize)
        return [.paragraphStyle: paragraphStyle,
                .font: font,
                .foregroundColor: NSColor.white,
                .kern: 0.5
        ]
    }

    var windowTitleAttributes: [NSAttributedString.Key: Any] {
        let font = NSFont(name: "SoleilLt", size: 16) ?? NSFont.systemFont(ofSize: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail

        return [.paragraphStyle: paragraphStyle,
                .font: font,
                .foregroundColor: NSColor.white,
                .kern: 1]
    }

    var recordSmallHeaderAttributes: [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.paragraphSpacing = 0
        paragraphStyle.paragraphSpacingBefore = 20
        let font = NSFont(name: "SoleilLt", size: 12) ?? NSFont.systemFont(ofSize: 12)
        return [.paragraphStyle: paragraphStyle,
                .font: font,
                .foregroundColor: NSColor.white,
                .kern: 0.5
        ]
    }
}
