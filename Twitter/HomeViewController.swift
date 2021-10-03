//
//  HomeViewController.swift
//  Twitter
//
//  Created by Sayed Jahed Hussini on 9/30/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    
    var  tweetArray = [NSDictionary]()
    var numberOfTweets:  Int!
    
    let myUIRefreshControl = UIRefreshControl( )
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        loadTweets()
        super.viewDidLoad()
        
        myUIRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myUIRefreshControl
        
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableView.automaticDimension
        
    } 

    @objc func loadTweets(){
        
        numberOfTweets = 20
        let tweetURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let tweetParams = ["count": numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: tweetURL, parameters: tweetParams , success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            self.myUIRefreshControl.endRefreshing()
            
        }, failure: { (Error) in
            print("Tweets couldn't be retreieved")
        } )
    }
    
    
    func loadMoreTweets() {
        let tweetURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets += 20
        let tweetParams = ["count": numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: tweetURL, parameters: tweetParams , success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("Tweets couldn't be retreieved")
        } )
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath  ) as! TweetTableViewCell
        
        let userDetail = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.tweetLabel.text = tweetArray[indexPath.row]["text"] as? String
        cell.usernameLabel.text = userDetail["name"] as? String
        
        let imageURL = URL(string: (userDetail["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
//        let f = tweetArray[indexPath.row]["favorite"] as? Bool
//        if(f != nil){
//            cell.setFavorite(f!)
//        }
        if let f = tweetArray[indexPath.row]["favorite"] as? Bool {
            cell.setFavorite(f)
        }
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int 
        
        if let t = tweetArray[indexPath.row]["retweeted"] as? Bool {
            cell.setRetweeted(t)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets() 
        }
    }

}
