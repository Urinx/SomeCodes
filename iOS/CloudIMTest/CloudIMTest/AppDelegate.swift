//
//  AppDelegate.swift
//  CloudIMTest
//
//  Created by Eular on 10/7/15.
//  Copyright © 2015 Eular. All rights reserved.
//

import UIKit

let HaidaiWXCode = "wx6eada1db861b4651"
let HaidaiWXSecret = "9f0506b2c0ee777eff4532f316ffdf91"
let WeixinLoginNotification = "WeixinOauth2Back"
let hasLoginedNotification = "hasLoginedNotification"
let RCIMAppKey = "sfci50a7cbqqi"
let WeixinId = "oqMmfuEI0v4NmiWWU6xY0_O8DvaU"
let WeiToken = "5ugWRWL6hVQdQ+yTmm2Oaf6W8XsEudH5XSNDyXUWzKNwcvknSQ9tbzIN1v713ZAWdmQjVdN39/USN9+EEvrQNoT5WxhyKxQ5BgRK8L7/dHdFlIUO8v/8ezd1Rnlsg99d"
let TestId = "eular"
let TestToken = "cr1jvymRCcCRXP28lHt2bP6W8XsEudH5XSNDyXUWzKNwcvknSQ9tbydU/r8P9lhZgLsFoaWa+fEvnlZ0Jc0VOQ=="

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate, RCIMUserInfoDataSource {

    var window: UIWindow?

    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        let userInfo = RCUserInfo()
        userInfo.userId = userId
        
        let weixinUser = NSUserDefaults.standardUserDefaults().objectForKey("weixinUser")
        let id = weixinUser?.objectForKey("openid") as! String
        let name = weixinUser?.objectForKey("nickname") as! String
        let portrait = weixinUser?.objectForKey("headimgurl") as! String
        
        switch userId {
            case TestId:
                userInfo.name = (id == WeixinId) ? "测试帐号":name
                userInfo.portraitUri = (id == WeixinId) ? "http://v1.qzone.cc/avatar/201408/10/16/57/53e7340484f3a549.jpg%21200x200.jpg":portrait
            case WeixinId:
                userInfo.name = "Ai"
                userInfo.portraitUri = "http://wx.qlogo.cn/mmopen/icIGSwXPB3l5wYtJCmQHtN1spTXRZ0rib5TQV2iciciaNAmkn176s64XBYM9GQJo8kE7cvTUibaKKbqJtPbSaozmnnWYeib67V8sGQv/0"
            default:
                break
        }

        return completion(userInfo)
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UITabBar.appearance().tintColor = UIColor(red:0.03, green:0.73, blue:0.03, alpha:1)
        RCIM.sharedRCIM().userInfoDataSource = self
        WXApi.registerApp(HaidaiWXCode)
        return true
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return WXApi.handleOpenURL(url, delegate: self)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return WXApi.handleOpenURL(url, delegate: self)
    }
    
    func onResp(resp: BaseResp!) {
        /*
        ErrCode  ERR_OK = 0(用户同意)
        ERR_AUTH_DENIED = -4（用户拒绝授权）
        ERR_USER_CANCEL = -2（用户取消）
        */
        
        if resp.isKindOfClass(SendMessageToWXResp) {
            // ...
        } else if resp.errCode == 0 {
            if let code = resp.valueForKey("code") as? String {
                // 通过code获取access_token
                let url = NSURL(string: "https://api.weixin.qq.com/sns/oauth2/access_token?appid=\(HaidaiWXCode)&secret=\(HaidaiWXSecret)&code=\(code)&grant_type=authorization_code")
                let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
                    if error == nil {
                        do {
                            let value = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                            if value.objectForKey("errcode") == nil {
                                let accessToken = value.objectForKey("access_token") as! String
                                let openid = value.objectForKey("openid") as! String
                                self.getUserInfo(accessToken, openid: openid)
                            }
                        } catch {}
                    }
                }
                task.resume()
            }
        }
    }
    
    func getUserInfo(accessToken: String, openid: String) {
        let url = NSURL(string: "https://api.weixin.qq.com/sns/userinfo?access_token=\(accessToken)&openid=\(openid)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            if error == nil {
                do {
                    let info = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    if info.objectForKey("errcode") == nil {
                        // print(info)
                        let openid = info.objectForKey("openid") as! String
                        let nickname = info.objectForKey("nickname") as! String
                        let headimgurl = info.objectForKey("headimgurl") as! String
                        let city = info.objectForKey("city") as! String
                        let province = info.objectForKey("province") as! String
                        let sex = info.objectForKey("sex") as! Int
                        
                        let center = NSNotificationCenter.defaultCenter()
                        center.postNotificationName(WeixinLoginNotification, object: nil, userInfo: ["openid": openid, "nickname": nickname, "headimgurl": headimgurl, "city": city, "province": province, "sex": sex])
                    }
                } catch {}
            }
        }
        task.resume()
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

