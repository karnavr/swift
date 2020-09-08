//
//  DiningHallTableViewCell.swift
//  L4Starter
//
//  Created by Karnav Raval on 2020-08-27.
//  Copyright © 2020 Yana Sang. All rights reserved.
//

import UIKit

class DiningHallTableViewCell: UITableViewCell {

    var nameLabel: UILabel!
    var ratingLabel: UILabel!
    var heartImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        ratingLabel = UILabel()
        ratingLabel.font = UIFont.systemFont(ofSize: 12)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ratingLabel)
        
        heartImageView = UIImageView()
        heartImageView.image = UIImage(named: "heart")
        heartImageView.contentMode = .scaleAspectFit
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(heartImageView)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        
        let padding: CGFloat = 8
        let labelHeight: CGFloat = 16
        let heartImageLength: CGFloat = 25
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            ratingLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ratingLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            heartImageView.heightAnchor.constraint(equalToConstant: heartImageLength),
            heartImageView.widthAnchor.constraint(equalToConstant: heartImageLength),
            heartImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            heartImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
        
    }
    
    func configure(for diningHall: DiningHall) {
        nameLabel.text = diningHall.name
        ratingLabel.text = "Rating: \(diningHall.getRatingString())"
        heartImageView.isHidden = !diningHall.isFavorite
    }
    
    func toggleImageView() {
        heartImageView.isHidden.toggle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
