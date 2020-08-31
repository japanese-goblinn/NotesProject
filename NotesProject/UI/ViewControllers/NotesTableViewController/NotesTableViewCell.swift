//
//  NotesTableViewCell.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 9/8/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let colorView = PaletteView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(colorView)
        
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = .boldSystemFont(ofSize: 18)
        
        contentLabel.numberOfLines = 3
        contentLabel.textColor = .darkGray
        
        
        NSLayoutConstraint.activate([
            colorView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            colorView.widthAnchor.constraint(equalTo: colorView.heightAnchor),
            
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            colorView.bottomAnchor.constraint(equalTo: contentLabel.topAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: colorView.topAnchor),
            titleLabel.firstBaselineAnchor.constraint(equalTo: colorView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            contentLabel.leadingAnchor.constraint(equalTo: colorView.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemeted")
    }
    
}
