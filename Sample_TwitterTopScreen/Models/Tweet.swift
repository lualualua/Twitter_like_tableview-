//
//  Tweet.swift
//  Sample_TwitterTopScreen
//
//  Created by LylaArakawa on 22/02/21.
//

import UIKit

class Tweet: NSObject {
    var name: String
    var text: String
    var time: String
    var icon: UIImage
    var tweetImage: UIImage?
    
    init(name: String, text: String, time: String, icon: UIImage, tweetImage: UIImage?) {
        self.name = name
        self.text = text
        self.time = time
        self.icon = icon
        self.tweetImage = tweetImage
    }
}
