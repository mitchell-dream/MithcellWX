//
//  AppDelegate.swift
//  MichellWeiXin
//
//  Created by MENGCHEN on 15-5-12.
//  Copyright (c) 2015年 Mcking. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,XMPPStreamDelegate{
    
    var window: UIWindow?
    //通道
    var xs : XMPPStream?
    //服务器是否开启
    var isOpen = false
    //密码
    var pwd = ""
    
    //状态代理
    var ztdl: ZtDL?
    
    //消息代理
    var xxdl:XxDL?
    
    func xmppStream(sender: XMPPStream!, didReceiveMessage message: XMPPMessage!) {
        println(message)
        
        
        //如果是chat
        if(message .isChatMessage()){
            var msg = WXMessage()
            //对方正在输入
            if message.elementForName("composing") != nil {
                msg.isComposing = true
            }
            
            //离线消息
            if message.elementForName("delay") != nil {
                msg.isDelay = true
                
            }
            
            //消息正文
            if let body = message.elementForName("body") {
                msg.body = body.stringValue()
            }
            
            //完整用户名
            msg.from = message.from().user + "@" + message.from().domain
            
            //添加到消息代理中
            xxdl?.newMsg(msg)
            
        }
    }
    
    
    func xmppStream(sender: XMPPStream!, didReceivePresence presence: XMPPPresence!) {
        //我自己的用户名
        let myUser = sender.myJID.user
        
        //好友的用户名
        let user = presence.from().user
        
        //用户所在的域
        let domain = presence.from().domain
        
        //状态类型
        let pType = presence.type()
        if(user != myUser){
            var zt = Zhuangtai()
            zt.name = user + "@" + domain
            
            //上线
            if (pType == "available"){
                zt.isOnline = true
                ztdl?.isOn(zt)

            }else if (pType == "unavailable"){
                ztdl?.isOn(zt)
            }
        }
    }
    
    
    
    //连接成功
    func xmppStreamDidConnect(sender: XMPPStream!) {
        isOpen = true
        //验证密码
        xs!.authenticateWithPassword(pwd, error: nil)
    }
    //验证成功
    func xmppStreamDidAuthenticate(sender: XMPPStream!) {
        //上线
        goOnline()
    }
    
    
    
    
    //建立通道
    func buildStream(){
        xs  = XMPPStream()//初始化
        xs?.addDelegate(self, delegateQueue: dispatch_get_main_queue())//加到主线程中
    }
    
    //发送上线状态
    func goOnline() {
        var p = XMPPPresence()
        xs!.sendElement(p)
        
    }
    
    
    //发送下线状态
    func goOffline() {
        var p = XMPPPresence(type: "unavailabe")
        
        xs!.sendElement(p)
    }
    
    //连接服务器（查看服务器是否可连接）
    func connect() ->Bool{
        buildStream()
        //通道已经连接
        if xs!.isConnected(){
            return true
        }
        
        let user = NSUserDefaults.standardUserDefaults().stringForKey("userID")
        let password = NSUserDefaults.standardUserDefaults().stringForKey("password")
        let server = NSUserDefaults.standardUserDefaults().stringForKey("server")
        
        if (user != nil && password != nil){
            
            //用户名
            xs!.myJID = XMPPJID.jidWithString(user!)
            xs!.hostName = server!
            //密码保存备用
            pwd = password!
            
            //连接方法
            xs!.connectWithTimeout(5000, error: nil)
        }
        
        
        
        
        
        
        
        return false
    }
    
    
    //断开连接
    func disConnect(){
        //此处对通道进行判断，是否有值，不然会crash
        if  xs != nil {
            //通道是否连接
            if  xs!.isAuthenticating() {
                goOffline()
                self.disConnect()
            }

        }
        

        
        
    }
    
    
    
    
    
    
    
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
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

