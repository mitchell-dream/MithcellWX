//
//  WXMessage.swift
//  MichellWeiXin
//
//  Created by MENGCHEN on 15-5-12.
//  Copyright (c) 2015年 Mcking. All rights reserved.
//

import Foundation

//好友结构
struct WXMessage {
    var body = ""           //正文
    var from = ""           //来源
    var isComposing  = false//对方是否正在输入
    var isDelay = false     //是否是离线的
    var isMe = false        //消息是否是我自己发出来的
}

//状态结构
struct Zhuangtai{
    var name = ""
    var isOnline = false
}