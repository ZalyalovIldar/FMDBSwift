//
//  PresentsTableViewCell.swift
//  MyVK
//
//  Created by Дамир Зарипов on 24.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class PresentsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var presentsCollectionView: UICollectionView!
    @IBOutlet weak var numberOfPresentsLabel: UILabel!
    let presentCellIdentifier = "presentCollectionCellIdentifier"
    var presents: [UIImage]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registrCells()
        setDelegateAndDataSource()
    }
    

    func registrCells() {
        let presentsCellNib = UINib(nibName: "PresentCollectionViewCell", bundle: nil)
        presentsCollectionView.register(presentsCellNib, forCellWithReuseIdentifier: presentCellIdentifier)
    }
    
    func setDelegateAndDataSource() {
        presentsCollectionView.delegate = self
        presentsCollectionView.dataSource = self
    }

    func prepareCell(with item: InfoViewModelPresentsItem) {
        numberOfPresentsLabel.text = item.presentsNumbers
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: presentCellIdentifier, for: indexPath) as! PresentCollectionViewCell
        cell.prepareCell(with: presents[Int(arc4random_uniform(UInt32(presents.count)))] )
        return cell
    }
}
