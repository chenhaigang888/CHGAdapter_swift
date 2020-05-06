//
//  ScrollListener.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/9/6.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

public typealias ScrollViewDidScrollBlock = (_ scrollView: UIScrollView)->Void

public typealias ScrollViewDidZoomBlock = (_ scrollView: UIScrollView)->Void

public typealias ScrollViewWillBeginDraggingBlock = (_ scrollView: UIScrollView)->Void

public typealias ScrollViewWillEndDraggingBlock = (_ scrollView: UIScrollView,  _ velocity: CGPoint, _ targetContentOffset: UnsafeMutablePointer<CGPoint>)->Void

public typealias ScrollViewDidEndDraggingBlock = (_ scrollView: UIScrollView, _ decelerate: Bool)->Void

public typealias ScrollViewWillBeginDeceleratingBlock = (_ scrollView: UIScrollView)->Void

public typealias ScrollViewDidEndDeceleratingBlock = (_ scrollView: UIScrollView)->Void

public typealias ScrollViewDidEndScrollingAnimationBlock = (_ scrollView: UIScrollView)->Void

public typealias ViewForZoomingBlock = (_ scrollView: UIScrollView)->UIView?

public typealias ScrollViewWillBeginZoomingBlock = (_ scrollView: UIScrollView, _ view: UIView?)->Void

public typealias ScrollViewDidEndZoomingBlock = (_ scrollView: UIScrollView, _ view: UIView?, _ scale: CGFloat)->Void

public typealias ScrollViewShouldScrollToTopBlock = (_ scrollView: UIScrollView)->Bool

public typealias ScrollViewDidScrollToTopBlock = (_ scrollView: UIScrollView)->Void

public typealias ScrollViewDidChangeAdjustedContentInsetBlock = (_ scrollView: UIScrollView)->Void

/// UIScrollView delegate block
open class ScrollListener: NSObject {
    
    open var scrollViewDidScrollBlock:ScrollViewDidScrollBlock?
    open var scrollViewDidZoomBlock:ScrollViewDidZoomBlock?
    open var scrollViewWillBeginDraggingBlock:ScrollViewWillBeginDraggingBlock?
    open var scrollViewWillEndDraggingBlock:ScrollViewWillEndDraggingBlock?
    open var scrollViewDidEndDraggingBlock:ScrollViewDidEndDraggingBlock?
    open var scrollViewWillBeginDeceleratingBlock:ScrollViewWillBeginDeceleratingBlock?
    open var scrollViewDidEndDeceleratingBlock:ScrollViewDidEndDeceleratingBlock?
    open var scrollViewDidEndScrollingAnimationBlock:ScrollViewDidEndScrollingAnimationBlock?
    open var viewForZoomingBlock:ViewForZoomingBlock?
    open var scrollViewWillBeginZoomingBlock:ScrollViewWillBeginZoomingBlock?
    open var scrollViewDidEndZoomingBlock:ScrollViewDidEndZoomingBlock?
    open var scrollViewShouldScrollToTopBlock:ScrollViewShouldScrollToTopBlock?
    open var scrollViewDidScrollToTopBlock:ScrollViewDidScrollToTopBlock?
    open var scrollViewDidChangeAdjustedContentInsetBlock:ScrollViewDidChangeAdjustedContentInsetBlock?
    
}

