//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Sayed Jahed Hussini on 10/9/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var noFollowersLabel: UILabel!
    @IBOutlet weak var noFollowingLabel: UILabel!
    @IBOutlet weak var noTweetsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = 10
        profileImage.layer.masksToBounds = false
        profileImage.clipsToBounds = true
        getProfileInfo()
        
    }
    
    func getProfileInfo(){
        let url = "https://api.twitter.com/1.1/account/verify_credentials.json"
        let tweetParams = ["include_email": false]
        
        TwitterAPICaller.client?.getDictionaryRequest(url: url, parameters: tweetParams, success: { inf in
//            print(inf)
            let followersCount = String(inf["followers_count"] as! Int)
            let followingCount = String(inf["friends_count"] as! Int)
            let totalNumTweets = String(inf["statuses_count"] as! Int)
            let profileImgUrl = URL(string: (inf["profile_image_url_https"] as! String))
            
            self.noFollowersLabel.text = followersCount
            self.noFollowingLabel.text = followingCount
            self.noTweetsLabel.text = totalNumTweets
            self.profileImage.af_setImage(withURL: profileImgUrl!)
            
            
        }, failure: { (error) in
            print("didn't get\(error)")
        })
        

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
