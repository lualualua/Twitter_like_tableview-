//
//  Tweet.swift
//  Sample_TwitterTopScreen
//
//  Created by LylaArakawa on 22/02/21.
//

import UIKit

struct Tweet {
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

var tweets: [Tweet] = []

func updateTweets(comment: String, pickedImage: UIImage?) -> [Tweet] {
        let name = "OSAKANA"
        let text = "\(comment)"
        let time = "3min"
        let icon = UIImage(systemName: "figure.walk.circle")
        if  pickedImage == nil {
            let tweetImage = UIImage(named: "")
        }
        let tweetImage = pickedImage

        let tweet = Tweet(name: name, text: text, time: time, icon: icon!, tweetImage: tweetImage)
        tweets.append(tweet)
        return tweets
    }


