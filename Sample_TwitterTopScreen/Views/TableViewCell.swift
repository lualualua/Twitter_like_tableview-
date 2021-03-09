//
//  TableViewCell.swift
//  Sample_TwitterTopScreen
//
//  Created by LylaArakawa on 24/02/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textContentLabel: UILabel!
    @IBOutlet weak var imageContent: UIImageView!

    //ラベル・Imageviewにデータをセットする
    func setupCell(tweet: Tweet) {
        profileImageView.image = tweet.icon
        nameLabel.text = tweet.name
        timeLabel.text = tweet.time
        textContentLabel.text = tweet.text
        //デフォルトは写真の表示をオフにしておく
        imageContent.isHidden = true
        //写真が選択された際は写真を表示する
        if let image = tweet.tweetImage {
            imageContent.isHidden = false
            imageContent.image = image
            imageContent.contentMode = .scaleAspectFill
        }
    }
}
