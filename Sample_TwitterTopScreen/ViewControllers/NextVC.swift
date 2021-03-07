//
//  NextVC.swift
//  Sample_TwitterTopScreen
//
//  Created by LylaArakawa on 22/02/21.
//

import UIKit

class NextVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweet:Tweet!
    var tableviewCell = TableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    //Tableviewの設定
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        //make one tableviewCell
        tableView.rowHeight = CGFloat(view.frame.height)
        
        //make a tableviewCell not selectable
        tableView.allowsSelection = false
    }
}


extension NextVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.setupCell(tweet: tweet)
        cell.textContentLabel.font = UIFont.systemFont(ofSize: 23.0)
        
        return cell
    }

}
