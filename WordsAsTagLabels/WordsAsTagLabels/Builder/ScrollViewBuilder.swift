//
//  ScrollViewBuilder.swift
//  WordsAsTagLabels
//
//  Created by Volodymyr Vozniak on 12/06/2020.
//  Modified by Austin Marino on 12/23/2020
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import UIKit

protocol ScrollViewBuilderProtocol: class {
    func getAttributedScrollView(with params: TextViewParameters, completion: @escaping (Result<UIScrollView, BuilderError>) -> Void);
    var scrollViewFactory: ScrollViewFactoryProtocol? { get set };
    var textViewFactory: TextViewFactoryProtocol? { get set };
    var labelFactory: LabelFactoryProtocol? { get set };
    var imagesFactory: ImagesFactoryProtocol? { get set };
    var attrTextFactory: AttributedTextFactoryProtocol? { get set };
}

enum BuilderError: Error {
    case labelError;
    case imagesError;
    case attrTextError;
    case textViewError;
    case scrollViewError;
}

final class ScrollViewBuilder: ScrollViewBuilderProtocol {
    
    var scrollViewFactory: ScrollViewFactoryProtocol?;
    var textViewFactory: TextViewFactoryProtocol?;
    var labelFactory: LabelFactoryProtocol?;
    var imagesFactory: ImagesFactoryProtocol?;
    var attrTextFactory: AttributedTextFactoryProtocol?;
    
    init(
        scrollViewFactory: ScrollViewFactoryProtocol = ScrollViewFactory(),
        textViewFactory: TextViewFactoryProtocol = TextViewFactory(),
        labelFactory: LabelFactoryProtocol = LabelFactory(),
        imagesFactory: ImagesFactoryProtocol = ImagesFactory(),
        attrTextFactory: AttributedTextFactoryProtocol = AttributedTextFactory()
    ) {
        self.scrollViewFactory = scrollViewFactory;
        self.textViewFactory = textViewFactory;
        self.labelFactory = labelFactory;
        self.imagesFactory = imagesFactory;
        self.attrTextFactory = attrTextFactory;
    }
    
    func getAttributedScrollView(with params: TextViewParameters, completion: @escaping (Result<UIScrollView, BuilderError>) -> Void) {
        guard let labels = self.labelFactory?.getLabelArray(with: params) else {
            completion(.failure(.labelError));
            return;
        }
        guard let images = self.imagesFactory?.createImagesArray(labelArray: labels) else {
            completion(.failure(.imagesError));
            return;
        }
        guard let attrText = self.attrTextFactory?.createAttributedTextForImages(imageArray: images, space: params.space) else {
            completion(.failure(.attrTextError));
            return;
        }
        guard let textView = self.textViewFactory?.createTextView(with: attrText) else {
            completion(.failure(.textViewError));
            return;
        }
        guard let scrollView = self.scrollViewFactory?.createScrollView(with: textView, width: params.viewWidth, height: params.viewHeight) else {
            completion(.failure(.scrollViewError));
            return;
        }
        completion(.success(scrollView));
    }
    
}
