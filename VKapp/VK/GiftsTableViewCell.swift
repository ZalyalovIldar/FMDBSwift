//
//  GiftsTableViewCell.swift
//  VK
//
//  Created by Elina on 24/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class GiftsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
   
    @IBOutlet weak var giftsCountButton: UIButton!
    
    @IBOutlet weak var giftsCollectionView: UICollectionView!
    
    var gifts = [UIImage(assetName: .giftBoy), UIImage(assetName: .giftBaby), UIImage(assetName: .giftDog), UIImage(assetName: .giftCat), UIImage(assetName: .giftBoy), UIImage(assetName: .giftBaby), UIImage(assetName: .giftDog), UIImage(assetName: .giftCat)]
    
    override func awakeFromNib() {
        giftsCollectionView.dataSource = self
        giftsCollectionView.delegate = self
        
        let collectionGiftsNib = UINib(nibName: .giftsCellNibName)
        giftsCollectionView.register(collectionGiftsNib, forCellWithReuseIdentifier: Identifiers.giftsCellIdentifier.rawValue)
        
    }
    
    //MARK: UICollectionViewDelegate & Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifts.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.giftsCellIdentifier.rawValue, for: indexPath) as! GiftsCollectionViewCell
        
        if let image = gifts[indexPath.row] {
            cell.prepareCell(with: image)
        }
        
        return cell
    }
}
