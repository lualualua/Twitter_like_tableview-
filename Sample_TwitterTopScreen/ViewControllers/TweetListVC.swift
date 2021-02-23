//
//  ViewController.swift
//  Sample_TwitterTopScreen
//
//  Created by LylaArakawa on 05/02/21.
//

import UIKit

class TweetListVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!

    
    var tweets: [Tweet] = []
    
    let nameData = ["Tanaka", "Atarashi", "Futago", "Kani"]
    let images = ["car", "cat", "first", "fruit"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        tableView.register(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")


        
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 600

        
//        //ダミーデータの生成
//        let user = User(id: "1", screenName: "tikitiki", name: "Tanaka", profileImage: )
//        let tweet = Tweet(id: "01", text: "Have a good day!", user: user)
//
//        let tweets = [tweet]
//        self.tweets = tweets

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        tweets.append(textField.text!)
        textField.text = ""
        tableView.reloadData()
        return true
    }

    //キーボード外をクリックするとキーボードが閉じる？？？？？？？？？
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    

}

extension TweetListVC: UITableViewDelegate {
    //
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //Cellの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        tableView.estimatedRowHeight = 60
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = (storyboard?.instantiateViewController(identifier: "next"))! as NextVC
        navigationController?.pushViewController(nextVC, animated: true)
//        nextVC.todoString = tweetArray[indexPath.row]
    }
}


extension TweetListVC: UITableViewDataSource{
    //Cellの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tweetArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TweetTableViewCell
        let tweet = self.tweets[indexPath.row]
        cell.profileImageView.image = tweet.icon
        cell.nameLabel.text = tweet.name
        cell.timeLabel.text = tweet.time
        cell.textContentLabel.text = tweet.text
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
