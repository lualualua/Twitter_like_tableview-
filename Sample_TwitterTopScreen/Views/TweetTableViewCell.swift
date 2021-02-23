//
//  TweetTableViewCell.swift
//  Sample_TwitterTopScreen
//
//  Created by LylaArakawa on 11/02/21.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textContentLabel: UILabel!
    @IBOutlet weak var imageContent: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @IBAction func byNavicationPush(_ sender: Any) {
//         let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "navigationPushView") as! NavigationPushViewController
//         nextVC.text = "fromViewController"
//         self.navigationController?.pushViewController(nextVC, animated: true)
//   }

}
