//
//  LabelFactory.swift
//  WordsAsTagLabels
//
//  Created by Volodymyr Vozniak on 12/06/2020.
//  Modified by Austin Marino on 12/23/2020
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import UIKit

protocol LabelFactoryProtocol: class {
    func getLabelArray(with params: TextViewParameters) -> [UILabel];
    func createLabel(for word: String, with params: TextViewParameters) -> UILabel;
}

final class LabelFactory: LabelFactoryProtocol {
    
    func getLabelArray(with params: TextViewParameters) -> [UILabel] {
        var labels = [UILabel]();
        for (_, word) in params.words.enumerated() {
            let label = createLabel(
                for: word,
                with: params
            );
            labels.append(label);
        }
        return labels;
    }
    
    func createLabel(for word: String, with params: TextViewParameters) -> UILabel {
        let label = UILabel();
        label.text = word;
        label.font = params.font;
        label.textAlignment = .center;
        label.backgroundColor = params.backgroundColor;
        label.layer.borderWidth = params.borderWidth;
        label.layer.borderColor = params.borderColor;
        label.textColor = params.textColor;
        label.sizeToFit();
        
        let frame = label.frame;
        let newWidth = frame.width + params.offsetWidth;
        let newHeight = frame.height + params.offsetHeight;
        
        label.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight);
        label.clipsToBounds = true;
        label.layer.cornerRadius = params.cornerRadius;
        
        return label;
    }
}
