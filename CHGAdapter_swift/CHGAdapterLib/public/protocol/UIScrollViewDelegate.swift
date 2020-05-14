//
//  UIScrollViewDelegate.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/5/13.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit


/// 封装UIScrollViewDelegate
public protocol CHGScrollViewDelegate {
    
    
    func chg_scrollViewDidScroll(scrollView:UIScrollView) -> Void
    
    func chg_scrollViewDidZoom(scrollView:UIScrollView) -> Void

    func chg_scrollViewWillBeginDragging(scrollView:UIScrollView) -> Void

    func chg_scrollViewWillEndDragging(scrollView:UIScrollView, with velocity:CGPoint, targetContentOffset:UnsafeMutablePointer<CGPoint>) -> Void

    func chg_scrollViewDidEndDragging(scrollView:UIScrollView, will decelerate:Bool) -> Void
    
    func chg_scrollViewWillBeginDecelerating(scrollView:UIScrollView) -> Void

    func chg_scrollViewDidEndDecelerating(scrollView:UIScrollView) -> Void
    
    func chg_scrollViewDidEndScrollingAnimation(scrollView:UIScrollView) -> Void
    
    func chg_viewForZoomingInScrollView(scrollView:UIScrollView) -> UIView?
    
    func chg_scrollViewWillBeginZooming(scrollView:UIScrollView, with view:UIView?) -> Void
    
    func chg_scrollViewDidEndZooming(scrollView:UIScrollView,with view:UIView?, at scale:CGFloat) -> Void

    func chg_scrollViewShouldScrollToTop(scrollView:UIScrollView) -> Bool

    func chg_scrollViewDidScrollToTop(scrollView:UIScrollView) -> Void
    
    func chg_scrollViewDidChangeAdjustedContentInset(scrollView:UIScrollView) -> Void
    
}

public extension CHGScrollViewDelegate {
    func chg_scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    func chg_scrollViewDidZoom(scrollView: UIScrollView) {
        
    }
    
    func chg_scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    
    func chg_scrollViewWillEndDragging(scrollView: UIScrollView, with velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    
    func chg_scrollViewDidEndDragging(scrollView: UIScrollView, will decelerate: Bool) {
        
    }
    
    func chg_scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        
    }
    
    func chg_scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
    }
    
    func chg_scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
    }
    
    func chg_viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return nil
    }
    
    func chg_scrollViewWillBeginZooming(scrollView: UIScrollView, with view: UIView?) {
        
    }
    
    func chg_scrollViewDidEndZooming(scrollView: UIScrollView, with view: UIView?, at scale: CGFloat) {
        
    }
    
    func chg_scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func chg_scrollViewDidScrollToTop(scrollView: UIScrollView) {
        
    }
    
    func chg_scrollViewDidChangeAdjustedContentInset(scrollView: UIScrollView) {
        
    }
}


