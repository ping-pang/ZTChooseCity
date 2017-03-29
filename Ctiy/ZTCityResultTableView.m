//
//  ZTCityResultTableView.m
//  AddressList
//
//  Created by zt on 17/3/28.
//  Copyright © 2017年 zt. All rights reserved.
//

#import "ZTCityResultTableView.h"

@implementation ZTCityResultTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self) {
        self = [super initWithFrame:frame style:style];
        
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array ? _array.count : 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _array ? 1 : 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _array[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.resultCallBack(_array[indexPath.row]);
}

-(void)setArray:(NSArray *)array{
    _array = array;
    [self reloadData];
}

@end
