//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Sayed Jahed Hussini on 9/30/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

 
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var favButon: UIButton!
    
    var favorited: Bool = false

    var tweetId: Int = -1
    
    @IBAction func retweet(_ sender: Any) {

        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("couldn't retweet! \(error)")
        })
        
    }
    
    @IBAction func favTweet(_ sender: Any) {
        if(!favorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("couldn't set favorite tweet \(error)")
            })
        }else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("couldn't unfavorite tweet \(error) ")
            })
        }
        
    }
    //    var tweet: [String: Any] = [String:Any]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setFavorite(_ isFavorited: Bool){
        favorited = isFavorited
        if(favorited){
            favButon.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }else {
            favButon.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted: Bool){
//        tweeted = isRetweeted
        if(isRetweeted){
            tweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            tweetButton.isEnabled = false
        }else {
            tweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            tweetButton.isEnabled = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
