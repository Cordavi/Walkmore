//
//  DirectionsView.swift
//  CarouselViewExample
//
//  Created by Matteo Tagliafico on 03/04/16.
//  Copyright © 2016 Matteo Tagliafico. All rights reserved.
//

import UIKit
import TGLParallaxCarousel

class DirectionView: TGLParallaxCarouselItem {
    
    @IBOutlet weak var currentLegLabel: UILabel!
    
    @IBOutlet weak var directionTextView: UITextView!
    
    private var containerView: UIView!
    private let customViewNibName = "DirectionsView"
    
    
    // MARK: init methods
    convenience init(frame: CGRect, leg: String, step:String) {
        self.init(frame: frame)
        self.directionTextView.text = step
        self.currentLegLabel.text = leg
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        setupUI()
    }
    
    func xibSetup() {
        containerView = loadViewFromNib()
        containerView.frame = bounds
        containerView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(containerView)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: customViewNibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    func setupUI() {
        layer.masksToBounds = true
        currentLegLabel.numberOfLines = 0

    }
}
