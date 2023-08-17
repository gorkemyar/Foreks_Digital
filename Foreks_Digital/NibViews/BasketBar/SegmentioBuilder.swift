import Segmentio
import UIKit

struct SegmentioBuilder {
    
    static func setupBadgeCountForIndex(_ segmentioView: Segmentio, index: Int) {
        segmentioView.addBadge(
            at: index,
            count: 3,
            color: Constants.colors.yellow
        )
    }
    
    static func buildSegmentioView(segmentioView: Segmentio, segmentioStyle: SegmentioStyle, segments: [SegmentioItem], segmentioPosition: SegmentioPosition = .fixed(maxVisibleItems: 3)) {
        segmentioView.setup(
            content: segments,
            style: segmentioStyle,
            options: segmentioOptions(segmentioStyle: segmentioStyle, segmentioPosition: segmentioPosition)
        )
    }
    

    
    private static func segmentioOptions(segmentioStyle: SegmentioStyle, segmentioPosition: SegmentioPosition = .fixed(maxVisibleItems: 3)) -> SegmentioOptions {
        var imageContentMode = UIView.ContentMode.center
        switch segmentioStyle {
        case .imageBeforeLabel, .imageAfterLabel:
            imageContentMode = .scaleAspectFit
        default:
            break
        }
        
        return SegmentioOptions(
            backgroundColor: Constants.colors.bg,
            segmentPosition: segmentioPosition,
            scrollEnabled: true,
            indicatorOptions: segmentioIndicatorOptions(),
            horizontalSeparatorOptions: segmentioHorizontalSeparatorOptions(),
            verticalSeparatorOptions: segmentioVerticalSeparatorOptions(),
            imageContentMode: imageContentMode,
            labelTextAlignment: .center,
            labelTextNumberOfLines: 1,
            segmentStates: segmentioStates(),
            animationDuration: 0.3
        )
    }
    
    private static func segmentioStates() -> SegmentioStates {
        let font = UIFont.systemFont(ofSize: 13)
        return SegmentioStates(
            defaultState: segmentioState(
                backgroundColor: Constants.colors.bg,
                titleFont: font,
                titleTextColor: UIColor.white
            ),
            selectedState: segmentioState(
                backgroundColor: Constants.colors.bg,
                titleFont: font,
                titleTextColor: Constants.colors.yellow
            ),
            highlightedState: segmentioState(
                backgroundColor: Constants.colors.bg,
                titleFont: font,
                titleTextColor: UIColor.lightGray
            )
        )
    }
    
    private static func segmentioState(backgroundColor: UIColor, titleFont: UIFont, titleTextColor: UIColor) -> SegmentioState {
        return SegmentioState(
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            titleTextColor: titleTextColor
        )
    }
    
    private static func segmentioIndicatorOptions() -> SegmentioIndicatorOptions {
        return SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 2,
            color: Constants.colors.yellow
        )
    }
    
    private static func segmentioHorizontalSeparatorOptions() -> SegmentioHorizontalSeparatorOptions {
        return SegmentioHorizontalSeparatorOptions(
            type: .topAndBottom,
            height: 1,
            color: Constants.colors.lineGray
        )
    }
    
    private static func segmentioVerticalSeparatorOptions() -> SegmentioVerticalSeparatorOptions {
        return SegmentioVerticalSeparatorOptions(
            ratio: 0.9,
            color: Constants.colors.lineGray
        )
    }
}
