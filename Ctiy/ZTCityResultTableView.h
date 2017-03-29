//
//  ZTCityResultTableView.h
//  AddressList
//
//  Created by zt on 17/3/28.
//  Copyright © 2017年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTCityResultTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *array;

@property(nonatomic,copy)void (^resultCallBack)(NSString *cityName);

@end
