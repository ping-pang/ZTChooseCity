//
//  ZTHotCityTableViewCell.h
//  EasyBuy
//
//  Created by zt on 17/3/28.
//  Copyright © 2017年 晴天微笑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTHotCityTableViewCell : UITableViewCell

@property(nonatomic,copy)void(^hotCityCallBack)(NSString *cityName);
@property(nonatomic,strong)NSArray *array;
@end
