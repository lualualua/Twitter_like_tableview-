//
//  ViewController.swift
//  Sample_TwitterTopScreen
//
//  Created by LylaArakawa on 05/02/21.
//

import UIKit

class TweetListVC: UIViewController, ModalViewControllerDelegate {
    
    let modalView = ModalViewController(nibName:"ModalViewController", bundle: nil)

    @IBOutlet weak private var addButton: UIButton!
    @IBOutlet var tableView: UITableView!

    var tweets = [Tweet]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        modalView.delegate = self
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        modalView.modalPresentationStyle = .fullScreen
        
        tableView.estimatedRowHeight = 200
        
        addNavBarImage()
        buttonLayout()
    }
    
    //NavigationBarにアイコンを配置
    func addNavBarImage() {
        //アイコンサイズを代入しておく
        let imageViewSize = 40
        //set the size of icon
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageViewSize, height: imageViewSize))
        imageView.contentMode = .scaleAspectFit
        
        //set the icon image
        let image = UIImage(systemName: "hare.fill")
        imageView.image = image
        navigationItem.titleView = imageView
        
    }
    
    //FloatingButtonのレイアウト
    func buttonLayout() {
        //Create a new layer
        let shadowLayer = CAShapeLayer()
        
        //set the cornerRadius
        addButton.imageView?.layer.cornerRadius = addButton.frame.height / 2

        //set the new layer's path to match the addButton
        shadowLayer.path = UIBezierPath(roundedRect: addButton.bounds, cornerRadius: addButton.frame.height / 2).cgPath
        shadowLayer.shadowPath = shadowLayer.path

        //set the layer's fill color and it's shadow color
        shadowLayer.fillColor = addButton.backgroundColor?.cgColor
        shadowLayer.shadowColor = UIColor.darkGray.cgColor

        shadowLayer.shadowOffset = CGSize(width: 0, height: 10)
        shadowLayer.shadowOpacity = 0.25
        shadowLayer.shadowRadius = 5
        
        addButton.imageView?.backgroundColor = .white

        addButton.layer.insertSublayer(shadowLayer, at: 0)
    }

    //When coming back from the modal view
    func modalDidFinish(comment: String, imageView: UIImage?) {
        tweets = updateTweets(comment: comment, pickedImage: imageView)
        tableView.reloadData()
        modalView.dismiss(animated: true, completion: nil)
    }

    //Action on pressing the FloatingButton
    @IBAction func addCommentButton(_ sender: Any) {
        // 作成したViewControllerをモーダル表示する
        self.present(modalView, animated: true)
    }
    

}

extension TweetListVC: UITableViewDelegate, UITableViewDataSource {
    //Cellの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    //Cellを選択したら遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = (storyboard?.instantiateViewController(identifier: "next"))! as NextVC
        nextVC.tweet = tweets[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
    //Cellの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
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
            cell.imageContent.contentMode = .scaleAspectFill
        }
        return cell
    }
    
}


