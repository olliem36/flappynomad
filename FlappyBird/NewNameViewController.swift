//
//  NewNameViewController.swift
//  FlappyBird
//
//  Created by Oliver Mahoney on 30/06/2014.
//  Copyright (c) 2014 Fullstack.io. All rights reserved.
//

import UIKit

class NewNameViewController: UIViewController {

    var score : Int!
    @IBOutlet var lblScore:UILabel



    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        var scoreString = String(self.score)
        lblScore.text = scoreString
        
    }
    
    
    @IBAction func btnEnterPressed(sender:UIButton) {
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:4567/login"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var params = ["username":"jameson", "password":"password"] as Dictionary
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
            
            if(err) {
                println(err!.localizedDescription)
            }
            else {
                var success = json["success"] as? Int
                println("Succes: \(success)")
            }
            })
        
        task.resume()
        
        
        self.dismissModalViewControllerAnimated(true);
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
