//
//  PresentTableViewCell.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 23.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class PresentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var presentsCountLabel: UILabel!
    @IBOutlet weak var presentsCollectionView: UICollectionView!
    
    var presents: [Present]!
    var accessoryButton: UIButton!
    let presentImageIdentifier = "presentImageIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareCollectionView()
        self.accessoryType = .disclosureIndicator
        accessoryButton = self.subviews.flatMap { $0 as? UIButton }.first
    }
    
    private func prepareCollectionView() {
        presentsCollectionView.delegate = self
        presentsCollectionView.dataSource = self
        
        let nib = UINib(nibName: "PresentCollectionViewCell", bundle: nil)
        presentsCollectionView.register(nib, forCellWithReuseIdentifier: presentImageIdentifier)
        
        if let presentFlowLayout = presentsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            presentFlowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    override func layoutSubviews() {
        let arrowPosition: CGFloat = 8
        
        super.layoutSubviews()
        accessoryButton.frame.origin.y = arrowPosition
    }
    
}

extension PresentTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: presentImageIdentifier, for: indexPath) as! PresentCollectionViewCell
        
        print("I am work!!!111!!")
        cell.presentImageView.image = presents[indexPath.row].image
        
        return cell
    }
}
