//
//  TextViewFactory.swift
//  WordsAsTagLabels
//
//  Created by Volodymyr Vozniak on 12/06/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import UIKit

protocol ScrollViewFactoryProtocol: class {
    func createScrollView(with attrText: NSMutableAttributedString, params: TextViewParameters) -> UIScrollView;
}

final class ScrollViewFactory: ScrollViewFactoryProtocol {
   
    private func createTextView(with attrText: NSMutableAttributedString, params: TextViewParameters)  -> UITextView {
        let attributedTextView = UITextView();
        attributedTextView.textAlignment = .left;
        attributedTextView.isEditable = false;
        attributedTextView.isSelectable = false;
        attributedTextView.isScrollEnabled = false;
        attributedTextView.isUserInteractionEnabled = false;
        attributedTextView.textContainer.maximumNumberOfLines = 1;
        attributedTextView.textContainer.lineBreakMode = .byWordWrapping;
        attributedTextView.textContainerInset = UIEdgeInsets.zero;
        attributedTextView.textContainer.lineFragmentPadding = 0;
        attributedTextView.attributedText = attrText;
        attributedTextView.autoresizesSubviews = false;
        let contentSize: CGSize = attributedTextView.attributedText.size();
        let frame =  CGRect(x: 0, y: 0, width: contentSize.width, height: max(contentSize.height, params.viewHeight));
        attributedTextView.frame = frame;
        attributedTextView.sizeToFit();
        return attributedTextView;
    }
    
    func createScrollView(with attrText: NSMutableAttributedString, params: TextViewParameters) -> UIScrollView {
        let attributedTextView = self.createTextView(with: attrText, params: params);
        let frame = CGRect(x: 0, y: 0, width: params.viewWidth, height: attributedTextView.frame.height);
        let attributedScrollView = UIScrollView(frame: frame);
        attributedScrollView.isScrollEnabled = true;
        attributedScrollView.showsVerticalScrollIndicator = false;
        attributedScrollView.showsHorizontalScrollIndicator = true;
        attributedScrollView.alwaysBounceVertical = false;
        attributedScrollView.alwaysBounceHorizontal = true;
        attributedScrollView.isUserInteractionEnabled = true;
        attributedScrollView.addSubview(attributedTextView);
        attributedScrollView.contentSize = attributedTextView.frame.size;
        if attributedScrollView.contentSize.width > attributedScrollView.frame.width{
            let contentInset: CGFloat = attributedTextView.center.x - (attributedScrollView.frame.width/2);
            attributedScrollView.contentInset = UIEdgeInsets(top: 0, left: contentInset, bottom: 0, right: -contentInset);
        }
        attributedScrollView.sizeToFit();
        attributedTextView.center = CGPoint(x: attributedScrollView.frame.width/2, y: attributedScrollView.frame.height/2);
        return attributedScrollView;
    }
}
