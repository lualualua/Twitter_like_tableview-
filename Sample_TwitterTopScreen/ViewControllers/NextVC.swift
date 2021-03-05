//
//  NextVC.swift
//  Sample_TwitterTopScreen
//
//  Created by LylaArakawa on 22/02/21.
//

import UIKit

class NextVC: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var tweet:Tweet!
    var tableviewCell = TableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        //make one tableviewCell
        tableView.rowHeight = CGFloat(view.frame.height)
        
        //make a tableviewCell not selectable
        self.tableView.allowsSelection = false

        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.profileImageView.image = tweet.icon
        cell.nameLabel.text = tweet.name
        cell.timeLabel.text = tweet.time
        cell.textContentLabel.text = tweet.text
        cell.textContentLabel.font = UIFont.systemFont(ofSize: 23.0)
        //デフォルトは写真の表示をオフにしておく
        cell.imageContent.isHidden = true
        //写真が選択された際は写真を表示する
        if let image = tweet.tweetImage {
            cell.imageContent.isHidden = false
            cell.imageContent.image = image

        }
        return cell
    }

}
