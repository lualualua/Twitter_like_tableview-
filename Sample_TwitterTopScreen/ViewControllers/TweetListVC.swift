//
//  ViewController.swift
//  Sample_TwitterTopScreen
//
//  Created by LylaArakawa on 05/02/21.
//

import UIKit

class TweetListVC: UIViewController {
    
    let modalView = ModalViewController(nibName:"ModalViewController", bundle: nil)

    @IBOutlet weak private var addButton: UIButton!
    @IBOutlet var tableView: UITableView!

    var tweets = [Tweet]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupModalView()
        addNavBarImage()
        buttonLayout()
    }
    
    //TableViewの設定
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    //ModalViewの設定
    func setupModalView() {
        modalView.delegate = self
        modalView.modalPresentationStyle = .fullScreen
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

    //Action on pressing the FloatingButton
    @IBAction func addCommentButton(_ sender: Any) {
        // 作成したViewControllerをモーダル表示する
        self.present(modalView, animated: true)
    }
}

//ModalViewControllerDelegateのProtocolに準拠させる
extension TweetListVC: ModalViewControllerDelegate {
    
    //When coming back from the modal view
    func modalDidFinish(comment: String, imageView: UIImage?) {
        tweets = updateTweets(comment: comment, pickedImage: imageView)
        tableView.reloadData()
        modalView.dismiss(animated: true, completion: nil)
    }
}


extension TweetListVC: UITableViewDelegate, UITableViewDataSource {
    //Cellの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        200
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
        cell.setupCell(tweet: tweets[indexPath.row])
        return cell
    }
    
}


