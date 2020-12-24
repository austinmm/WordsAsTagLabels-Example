//
//  ViewController.swift
//  WordsAsTagLabels
//
//  Created by Vivatum on 04/06/2020.
//  Modified by Austin Marino on 12/23/2020
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import UIKit

final class DemoTableViewController: UITableViewController {

    @IBOutlet weak var demoTagsCell: UITableViewCell!
    private let words = ["AAA", "bbb", "128736542376", "How are you?", "Some text", "Foo label", "Give me a star 😁", "One more label"]
    private var builder: ScrollViewBuilderProtocol?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.builder = ScrollViewBuilder();
        self.createTagsView(for: words);
        self.tableView.tableFooterView = UIView(frame: .zero);
    }
    
    func createTagsView(for stringArray: [String]) {
        let builder = ScrollViewBuilder();
        //Must be wrapped in `DispatchQueue.main.async` for the UITableViewCell frame width and height values to be accurate
        DispatchQueue.main.async {
            let textViewParams = TextViewParameters(
                words: stringArray,
                space: " ",
                font: UIFont(name: "Menlo", size: 16)!,
                textColor: .black,
                backgroundColor: .clear,
                borderWidth: 0.3,
                borderColor: UIColor.black.cgColor,
                viewWidth: self.demoTagsCell.frame.width * 0.9,
                viewHeight: self.demoTagsCell.frame.height * 0.9,
                offsetWidth: 20.0,
                offsetHeight: 10.0,
                cornerRadius: 6.0
            );
            
            builder.getAttributedScrollView(with: textViewParams) { result in
                switch result {
                    case .success(let scrollView):
                        self.addScrollView(scrollView);
                    case .failure(let error):
                        print("Can't create ScrollView with error: \(error.localizedDescription)");
                }
            }
        }
    }
    
    private func addScrollView(_ scrollView: UIScrollView) {
        //Prevents UIScrollViews from overlaying
        if let view = self.demoTagsCell.subviews.last as? UIScrollView {
            view.removeFromSuperview();
        }
        self.demoTagsCell.addSubview(scrollView);
        self.demoTagsCell.sizeToFit();
        //Centers ScrollViewUI in UITableViewCell
        scrollView.center = CGPoint(x: self.demoTagsCell.frame.width/2, y: self.demoTagsCell.frame.size.height/2);
    }

}

