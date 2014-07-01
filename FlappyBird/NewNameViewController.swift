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
    @IBOutlet var lblScore:UILabel!
    @IBOutlet var lblTitle:UILabel!
    
    @IBOutlet var tfPhoneNumber:UITextField!
    @IBOutlet var tfName:UITextField!
    @IBOutlet var tfemail:UITextField!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var scoreString = String(self.score)
        lblScore.text = scoreString
        
        if(score  < 2) {
            lblTitle.text = "Oh Dear!";
        }else if(score  < 5){
            lblTitle.text = "Oops!";
        }else if(score  < 10){
            lblTitle.text = "Not bad!";
        }else if(score  < 20){
            lblTitle.text = "Pretty good!";
        }else if(score  < 30){
            lblTitle.text = "WOW!";
        }else{
            lblTitle.text = "Powerful!"
        }
        
    }
    
    @IBAction func btnCancelPressed(sender:UIButton) {
        self.dismissModalViewControllerAnimated(true);
    }
    
    @IBAction func btnEnterPressed(sender:AnyObject) {
        
        var email = tfemail.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        var fullname = tfName.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        var phone = tfPhoneNumber.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if(fullname.isEmpty || phone.isEmpty) {
            var alert = UIAlertController(title: "Incompelte details", message: "Please enter your details", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        
        var loadingSize:Float = 200;
        
        var loadingView: OJMLoadingView = OJMLoadingView(frame: CGRect(x: ((self.view.frame.width/2) - (loadingSize/2)), y: (self.view.frame.height/2)-(loadingSize/2), width: loadingSize, height: loadingSize), message: "Uploading...")
        
        self.view.addSubview(loadingView);
        
        var request = NSMutableURLRequest(URL: NSURL(string: "https://www2.onefile.co.uk/webservices/ignite.asmx/Process"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        
        var xmlParameters = "<Parameters><Signups><Signup MAC=\"10:DD:B1:F2:D3:B6\" Name=\"Flappy Nomad Score\" SignupID=\"0\" ID=\"3\" Lat=\"0\" Long=\"0\" Altitude=\"0\" SignupStatusID=\"2\"><Form FormID=\"5158\" TypeID=\"4\"><Sections><Section ID=\"9672\"><Fields><Field ID=\"40577\" DataID=\"0\"><Data>Oliver Mahoney</Data></Field><Field ID=\"40578\" DataID=\"0\"><Data>Phone:\(phone) Email: \(email)</Data></Field><Field ID=\"40579\" DataID=\"0\"><Data>\(score)</Data></Field></Fields></Section></Sections><Signatures/><Data/></Form></Signup></Signups></Parameters>";
        
        
        var err: NSError?
        
        var postString = "Command=TabletUploadSignups&AccessToken=AccessToken&Username=JDEPP&Password=test123&Parameters=" + xmlParameters;
        
        let postData = postString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)

        request.HTTPBody = postData
        
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            
            loadingView.removeFromSuperview()
            
            // Result="Successful"
            var myRange: NSRange = strData.rangeOfString("Result=\"Successful\"")

            if(myRange.location != NSNotFound) {
                self.dismissModalViewControllerAnimated(true);
            }else {
                // ask if they want to try again:
                
                let alert = UIAlertController(title: "Try Again?", message: "There was an arror uploading your score", preferredStyle: UIAlertControllerStyle.Alert)

                alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.Cancel, handler: {alertAction in
                    alert.dismissModalViewControllerAnimated(true);
                    self.btnEnterPressed(alertAction);
                    }))
                
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
            })
        
        task.resume()
        

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
