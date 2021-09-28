//
//  TweetViewController.swift
//  Twitter
//
//  Created by Sam Busane on 9/27/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetText.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetText.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { Error in
                print(Error)
                self.dismiss(animated: true, completion: nil)

            })
        } else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBOutlet weak var tweetText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetText.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
//https://api.twitter.com/1.1/statuses/update.json
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
