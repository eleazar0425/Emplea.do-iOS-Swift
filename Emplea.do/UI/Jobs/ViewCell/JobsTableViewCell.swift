//
//  JobsTableViewCell.swift
//  Emplea.do
//
//  Created by Eleazar Estrella GB on 5/21/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import UIKit

class JobsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var publicationDateLabel: UILabel!
    @IBOutlet weak var remoteBadge: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addLabelImages()

        remoteBadge.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func addLabelImages() {
        locationLabel.addImageWith(name: "locationIcon")
        companyLabel.addImageWith(name: "domainIcon")
        categoryLabel.addImageWith(name: "labelIcon")
        publicationDateLabel.addImageWith(name: "calendarIcon")
    }
    
    func bind(job: Job){
        self.titleLabel.text = job.title
        self.locationLabel.text = job.location
        self.companyLabel.text = job.company
        self.categoryLabel.text = job.category
        self.publicationDateLabel.text = job.date
        
        self.remoteBadge.isHidden = job.type == "N/A"
        
        addLabelImages()
    }
}
