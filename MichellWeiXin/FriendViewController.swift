//
//  FriendViewController.swift
//  MichellWeiXin
//
//  Created by MENGCHEN on 15-5-12.
//  Copyright (c) 2015年 Mcking. All rights reserved.
//
import UIKit


class FriendViewController: UITableViewController,ZtDL,XxDL {
    @IBOutlet var mystate: UIBarButtonItem!
    
    
    @IBAction func log(sender: UIBarButtonItem) {
        if logged {
            logoff()
            sender.image = UIImage(named: "client_head")
            
            
        } else {
            login()
            sender.image = UIImage(named: "flightDynamic")
            
        }
    }
    
    
    
    var unreadlist = [WXMessage]()
    var ztlist = [Zhuangtai]()
    
    
    var logged = false
    
    var currentBuddyName = ""
    
    
    func meOff() {
        logoff()
    }
    
    func newMsg(aMsg: WXMessage) {
        if (aMsg.body != "") {
            
            unreadlist.append(aMsg)
            self.tableView.reloadData()
        }
        
        
        
    }
    
    
    
    
    func isOn(zt: Zhuangtai) {
        for (index,oldzt) in enumerate(ztlist) {
            if (zt.name == oldzt.name) {
                
                
                ztlist.removeAtIndex(index)
                
                
                
                break
            }
        }
        ztlist.append(zt)
        
        self.tableView.reloadData()
        
        
    }
    
    
    
    func isOff(zt: Zhuangtai) {
        for (index,oldzt) in enumerate(ztlist) {
            if (zt.name == oldzt.name) {
                
                
                
                ztlist[index].isOnline = false
                
                
                break
            }
        }
        
        self.tableView.reloadData()
    }
    
    
    
    func zdl() ->AppDelegate{
        return UIApplication.sharedApplication().delegate as AppDelegate
    }
    
    //登入
    func login() {
        unreadlist.removeAll(keepCapacity: false)
        ztlist.removeAll(keepCapacity: false)
        zdl().connect()
        mystate.image = UIImage(named: "client_head")
        logged = true
        
        let myID = NSUserDefaults.standardUserDefaults().stringForKey("userID")
        self.navigationItem.title = myID! + "的好友"

        self.tableView.reloadData()
    }
    
    //登出
    func logoff() {
        unreadlist.removeAll(keepCapacity: false)
        ztlist.removeAll(keepCapacity: false)
        zdl().disConnect()
        mystate.image = UIImage(named: "flightDynamic")
        logged = false
        self.tableView.reloadData()

    }
    
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        
        
    }
    override func viewDidLoad() {
        let myID = NSUserDefaults.standardUserDefaults().stringForKey("userID")
        let autoLogin = NSUserDefaults.standardUserDefaults().boolForKey("wxautologin")
        
        if (myID != nil && autoLogin) {
            
            self.login()
            
        } else {
            self.performSegueWithIdentifier("toLogin", sender: self)
        }
        
        zdl().xxdl = self
        zdl().ztdl = self
    }
    override func didReceiveMemoryWarning() {
        
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("buddyListCell", forIndexPath: indexPath) as UITableViewCell
        let onLine = ztlist[indexPath.row].isOnline
        
        
        
        
        let name = ztlist[indexPath.row].name
        
        var unreads = 0
        
        for msg in  unreadlist{
            if ( name == msg.from ) {
                unreads++
                
            }
        }
        
        
        
        
        cell.textLabel?.text = name + "\(unreads)"
        
        
        
        
        
        
        if onLine {
            cell.imageView?.image = UIImage(named: "client_head")
        }else{
            cell.imageView?.image = UIImage(named: "flightDynamic")

        }
        
        return cell
        
        
        
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ztlist.count
    }
    
    
    
    
    
    
    
    
    @IBAction func unwindToLost(segue: UIStoryboardSegue){
        //如果是登录界面的完成按钮点击,开始登陆
        let source = segue.sourceViewController as LoginViewController
        
        if source.requireLogin {
            //先将前一个用户注销
            self.logoff()
            
            //再登录现用户
            self.login()
        }
        
        
        
        
    }
    
    //选择单元格
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        //保存好友用户名
        currentBuddyName = ztlist[indexPath.row].name
        
        
        //跳转到聊天视图
        self.performSegueWithIdentifier("tochat", sender: self)
        
        
        
    }
    
    
    
    
    
    
}
