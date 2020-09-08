//
//  ViewController.swift
//  L4Starter
//
//  Created by Yana Sang on 3/12/20.
//  Copyright © 2020 Yana Sang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView: UITableView!

    let reuseIdentifier = "cafeteriaCellReuse"
    let cellHeight: CGFloat = 50
    var diningHalls: [DiningHall]!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Dining Halls"
        view.backgroundColor = .white
        
        let appel = DiningHall(name: "Appel", rating: .great, isFavorite: false)
        let rpcc = DiningHall(name: "RPCC", rating: .good, isFavorite: false)
        let rose = DiningHall(name: "Rose", rating: .great, isFavorite: false)
        let bethe = DiningHall(name: "Bethe", rating: .okay, isFavorite: false)
        let keeton = DiningHall(name: "Keeton", rating: .bad, isFavorite: false)
        diningHalls = [appel, rpcc, rose, bethe, keeton]

        // Initialize tableView!
        tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // tableView setup stuff
        tableView.register(DiningHallTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self 
        
        view.addSubview(tableView)

        setupConstraints()
    }

    func setupConstraints() {
//        Setup the constraints for our views
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diningHalls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DiningHallTableViewCell
        let diningHall = diningHalls[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(for: diningHall)
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let diningHall = diningHalls[indexPath.row]
        diningHall.isFavorite.toggle()
                
        let cell = tableView.cellForRow(at: indexPath) as! DiningHallTableViewCell
        cell.toggleImageView()
    }
    
}
