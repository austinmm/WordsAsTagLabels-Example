//
//  ScrollViewFactory.swift
//  WordsAsTagLabels
//
//  Created by Austin Marino on 12/23/20.
//  Copyright © 2020 Austin Marino. All rights reserved.
//

import UIKit

protocol ScrollViewFactoryProtocol: class {
    func createScrollView(with textView: UITextView, width: CGFloat, height: CGFloat) -> UIScrollView;
}

final class ScrollViewFactory: ScrollViewFactoryProtocol {
   
    func createScrollView(with textView: UITextView, width: CGFloat, height: CGFloat) -> UIScrollView {
        let frame = CGRect(x: 0, y: 0, width: width, height: height);
        let attributedScrollView = UIScrollView(frame: frame);
        attributedScrollView.isScrollEnabled = true;
        attributedScrollView.showsVerticalScrollIndicator = false;
        attributedScrollView.showsHorizontalScrollIndicator = true;
        attributedScrollView.alwaysBounceVertical = false;
        attributedScrollView.alwaysBounceHorizontal = true;
        attributedScrollView.isUserInteractionEnabled = true;
        attributedScrollView.addSubview(textView);
        attributedScrollView.contentSize = textView.frame.size;
        if attributedScrollView.contentSize.width > attributedScrollView.frame.width{
            let contentInset: CGFloat = textView.center.x - (attributedScrollView.frame.width/2);
            attributedScrollView.contentInset = UIEdgeInsets(top: 0, left: contentInset, bottom: 0, right: -contentInset);
        }
        attributedScrollView.sizeToFit();
        textView.center = CGPoint(x: attributedScrollView.frame.width/2, y: attributedScrollView.frame.height/2);
        return attributedScrollView;
    }
}
