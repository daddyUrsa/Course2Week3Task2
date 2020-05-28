//
//  CollectionViewController.swift
//  Course2Week3Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    let photos = PhotoProvider().photos()

     override func viewDidLoad() {
        super.viewDidLoad()
      
        if let layout = collectionView?.collectionViewLayout as? CustomFlowLayout {
            layout.delegate = self
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
    }

}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! PhotoCollectionViewCell
        cell.configure(with: photos[indexPath.item])
        return cell
    }
}

extension CollectionViewController: PhotoLayoutDelegate {
  var rootView: UIView {
    return view
  }
}



