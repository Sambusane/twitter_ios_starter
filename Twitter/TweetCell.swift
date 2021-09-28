//
//  TweetCell.swift
//  Twitter
//
//  Created by Sam Busane on 9/21/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    // Wiring up Buttons
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    var favorited:Bool = true
    var tweetId:Int = -1
    var retweet:Bool = false
    @IBAction func retweetButtonAction(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweet(true)
        }, failure: { Error in
            print(Error)
        })
    }
    
    @IBAction func favoriteButtonAct(_ sender: Any) {
        let toBeFavorited = !favorited
        if toBeFavorited {
            TwitterAPICaller.client?.favoriteTwwet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { Error in
                print(Error)
            })
        } else{
            TwitterAPICaller.client?.unfavoriteTwwet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { Error in
                print(Error)
            })
        }
    }

    
    func setFavorite(_ isFavorited:Bool)  {
        favorited = isFavorited
        if favorited {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    func setRetweet(_ isRetweeted:Bool) {
        if isRetweeted {
            retweetButton.setImage(UIImage(named: "retwwet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retwwet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
