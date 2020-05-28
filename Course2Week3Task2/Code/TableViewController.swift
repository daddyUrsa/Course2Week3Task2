//
//  TableViewController.swift
//  Course2Week3Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    let photos = PhotoProvider().photos()

    @objc private func cellTap() {
        print("Row selected")
    }
    @IBAction func detailButton(_ sender: UIButton) {
        print("Accessory selected")
    }

//    @IBAction func detailButton(_ sender: UIButton) {
//        print("Accessory selected")
//    }
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath)

        cell.imageView?.image = photos[indexPath.row].image
        cell.textLabel?.text = photos[indexPath.row].name

        let gestureCellTap = UITapGestureRecognizer(target: self, action: #selector(cellTap))
        cell.addGestureRecognizer(gestureCellTap)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
