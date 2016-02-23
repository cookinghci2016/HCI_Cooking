//
//  CategoryRow.swift
//  HCI_recipe
//
//  Created by allen woo on 2/22/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//

import UIKit

class CategoryRow : UITableViewCell,UICollectionViewDelegate {
    var num_sec:Int = 0;
    var dic = [UIImage]()

    // Outlet of collectionView  very important!!!

    @IBOutlet weak var collectionView: UICollectionView!
}

extension CategoryRow : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return num_sec
    }
    
    // 用 "IngCell"标记某一个ingredient cell; 
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("IngCell", forIndexPath: indexPath) as! IngPhotoCell
        // Change image for imgView
        cell.Img_View.image = dic[indexPath.row]
//        print("Current Section = ")
//        print(indexPath.row)
        return cell
    }
    
    // 某个cell 被选中的事件处理
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}

// UICollection delegate protocol for behaviour of layout
extension CategoryRow : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}