//
//  MovieTableViewCell.swift
//  TestOnseo
//
//  Created by Дмитро Мостовий on 04.07.2020.
//  Copyright © 2020 Дмитро Мостовий. All rights reserved.
//

import UIKit
import SDWebImage

protocol MovieTableViewCellProtocol {
    func display(title: String?)
    func display(posterImageUrl: String?)
    func display(date: String?)
    func display(description: String?)
    func display(rating: String?)
}

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetContent()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetContent()
    }
     
    private func resetContent() {
        titleLabel.text = nil
        posterImageView.image = nil
        dateLabel.text = nil
        descriptionLabel.text = nil
    }
    
    private func setupView() {
        
    }
    
}

extension MovieTableViewCell: MovieTableViewCellProtocol {
    
    func display(title: String?) {
        titleLabel.text = title
    }
    
    func display(date: String?) {
        dateLabel.text = date
    }
    
    func display(description: String?) {
        descriptionLabel.text = description
    }
    
    func display(rating: String?) {
        ratingLabel.text = rating
    }
    
    func display(posterImageUrl: String?) {
        if let stringUrl = posterImageUrl, let url = URL(string: stringUrl) {
            posterImageView.sd_setImage(with: url, completed: nil)
        }
    }
}
