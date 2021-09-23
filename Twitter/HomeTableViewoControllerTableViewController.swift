//
//  HomeTableViewoControllerTableViewController.swift
//  Twitter
//
//  Created by Sam Busane on 9/21/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewoControllerTableViewController: UITableViewController {

    var tweetArray = [NSDictionary]()
    var numOfTweets: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    
    @objc func loadTweet(){
        
        numOfTweets = 20
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count":numOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams as [String : Any], success: {(tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
        }, failure: { Error in
            print("could not retieve tweets....")
        })
    }
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func loadMoreTweets() {
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numOfTweets = numOfTweets + 20
        let myParams = ["count":numOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams as [String : Any], success: {(tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
        }, failure: { Error in
            print("could not retieve tweets....")
        })
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet()
        myRefreshControl.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        tableView.refreshControl = myRefreshControl

        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        //setting code for image
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data:imageData)
        }
        
        
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

    
}
