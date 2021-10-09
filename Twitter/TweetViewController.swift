//
//  TweetViewController.swift
//  Twitter
//
//  Created by Sayed Jahed Hussini on 10/2/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit
//import RSKPlaceholderTextView

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var charLimitLabel: UILabel!
    
    let charLimit = 280
    
    @IBAction func cancelTweet(_ sender: Any) {
            dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if(!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Couldn't tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        tweetTextView.layer.borderWidth = 1
        tweetTextView.layer.borderColor = UIColor.lightGray.cgColor
        tweetTextView.layer.cornerRadius = 10
        tweetTextView.clipsToBounds = true
        tweetTextView.delegate = self
        
    

    }
    
    func textViewDidChange(_ textView: UITextView) {
        charLimitLabel.text = String(charLimit - tweetTextView.text.count)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count < charLimit
    }
    
    //    func setImage(){
//        let url = "https://api.twitter.com/1.1/account/verify_credentials.json"
//        let tweetParams = ["include_email": "true"]
//        TwitterAPICaller.client?.getDictionaryRequest(url: url, parameters:tweetParams , success: { resp in
//            let resp = 
//        }, failure: <#T##(Error) -> ()#>)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
