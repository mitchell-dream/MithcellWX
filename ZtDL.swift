//
//  ZtDL.swift
//  MichellWeiXin
//
//  Created by MENGCHEN on 15-5-12.
//  Copyright (c) 2015年 Mcking. All rights reserved.
//

import Foundation

//状态协议
protocol ZtDL{
    func isOn(zt:Zhuangtai)
    func isOff(zt:Zhuangtai)
    func meOff()
}