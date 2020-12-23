//
//  TextViewFactory.swift
//  WordsAsTagLabels
//
//  Created by Volodymyr Vozniak on 12/06/2020.
//  Modified by Austin Marino on 12/23/2020
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import UIKit

protocol TextViewFactoryProtocol: class {
    func createTextView(with attrText: NSMutableAttributedString) -> UITextView;
}

final class TextViewFactory: TextViewFactoryProtocol {
    func createTextView(with attrText: NSMutableAttributedString) -> UITextView
    {
        let attributedTextView = UITextView();
        attributedTextView.isEditable = false;
        attributedTextView.isSelectable = false;
        attributedTextView.isScrollEnabled = false;
        attributedTextView.isUserInteractionEnabled = false;
        attributedTextView.textContainer.maximumNumberOfLines = 1;
        attributedTextView.textContainer.lineFragmentPadding = 0;
        attributedTextView.textContainer.lineBreakMode = .byWordWrapping;
        attributedTextView.textContainerInset = UIEdgeInsets.zero;
        attributedTextView.textAlignment = .left;
        attributedTextView.attributedText = attrText;
        let contentSize: CGSize = attributedTextView.attributedText.size();
        let frame =  CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height);
        attributedTextView.frame = frame;
        attributedTextView.sizeToFit();
        return attributedTextView;
    }
}
