//
//  LoginViewController.swift
//  CloudIMTest
//
//  Created by Eular on 10/8/15.
//  Copyright © 2015 Eular. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, JSAnimatedImagesViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登陆"
        
        let width = view.bounds.width
        let height = view.bounds.height
        
        let wallpaper = JSAnimatedImagesView()
        wallpaper.frame = CGRectMake(0, 0, width, height)
        wallpaper.dataSource = self
        view.addSubview(wallpaper)
        
        let title = UILabel()
        title.text = "薇信"
        title.frame = CGRectMake((width - 110)/2, height/2 - 120, 110, 56)
        title.textColor = UIColor.whiteColor()
        title.font = UIFont(name: title.font.fontName, size: 46)
        view.addSubview(title)
        
        let subTitle = UILabel()
        subTitle.text = "让沟通更轻松"
        subTitle.frame = CGRectMake((width - 125)/2, height/2 - 20, 125, 21)
        subTitle.textColor = UIColor.whiteColor()
        subTitle.font = UIFont(name: subTitle.font.fontName, size: 20)
        view.addSubview(subTitle)
        
        let button = UIButton()
        button.frame = CGRectMake((width - 40)/2, height/2 + 100, 40, 40)
        button.setImage(UIImage(named: "wechat"), forState: UIControlState.Normal)
        button.addTarget(self, action: "weixinLogin", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)

        NSNotificationCenter.defaultCenter().addObserver(self, selector:"weixinLogined:", name: WeixinLoginNotification, object: nil)
    }
    
    func weixinLogined(notification: NSNotification) {
        let info = notification.userInfo as! Dictionary<String, AnyObject>
        NSUserDefaults.standardUserDefaults().setObject(info, forKey: "weixinUser")
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isLogined")
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName(hasLoginedNotification, object: nil)
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    func animatedImagesNumberOfImages(animatedImagesView: JSAnimatedImagesView!) -> UInt {
        return 2
    }
    
    func animatedImagesView(animatedImagesView: JSAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        return UIImage(named: "bg\(index)")
    }

    func weixinLogin() {
        let req: SendAuthReq = SendAuthReq()
        req.scope = "snsapi_userinfo,snsapi_base"
        WXApi.sendReq(req)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
