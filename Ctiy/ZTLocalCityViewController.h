//
//  BFLocalCityViewController.h
//  EasyBuy
//
//  Created by zt on 17/3/28.
//  Copyright © 2017年 晴天微笑. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NOTIFY_CURRENTLOCAL @"notifyName"
#define LOCAL_ADDRESS @"cityName"
#define USERDEF_SET_OBJ(obj,key) [[NSUserDefaults standardUserDefaults]setObject:obj forKey:key]

typedef void (^cityCallback)(NSString *cityName);
@interface ZTLocalCityViewController : UIViewController

@property(nonatomic,strong,readonly)NSString *autoLocalCity;
@property(nonatomic,copy)cityCallback callBack;

@end
