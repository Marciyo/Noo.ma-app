//
//  ExtendedButton.swift
//  Eracoin App
//
//  Created by Maciej Matuszewski on 10.02.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import UIKit

class ExtendedButton: UIButton {

    var color: UIColor?
    
    init(title: String, color: UIColor){
        self.color = color
        super.init(frame: CGRect.zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        self.setTitle(title, for: UIControlState.normal)
        self.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        self.layer.cornerRadius = 6
        
        NSLayoutConstraint.activate(
            [
                self.heightAnchor.constraint(equalToConstant: 44),
                self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8)
            ]
        )
        
        self.addTarget(self, action: #selector(self.onClickFunction), for: UIControlEvents.touchUpInside)
        
    }
    
    func onClickFunction(){
//        self.onClick()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
