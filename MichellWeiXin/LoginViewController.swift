//
//  LoginViewController.swift
//  MichellWeiXin
//
//  Created by MENGCHEN on 15-5-12.
//  Copyright (c) 2015年 Mcking. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var doneBtn: UIBarButtonItem!
    @IBOutlet var userTf: UITextField!
    @IBOutlet var passwordTf: UITextField!
    @IBOutlet var serverTf: UITextField!
    @IBOutlet var autoLogin: UISwitch!
    
    
    //需要登录
    var requireLogin = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender  as NSObject == self.doneBtn{
            
            
            
            NSUserDefaults.standardUserDefaults().setObject(userTf.text, forKey: "userID")
            NSUserDefaults.standardUserDefaults().setObject(passwordTf.text, forKey: "password")
            NSUserDefaults.standardUserDefaults().setObject(serverTf.text, forKey: "server")
            //配置自动登录
            NSUserDefaults.standardUserDefaults().setBool(self.autoLogin.on, forKey: "wxautologin")
            
            
            //同步用户配置
            NSUserDefaults.standardUserDefaults().synchronize()
            
            //需要登录
            requireLogin = true
            
            
            
        }
        
    }

}
