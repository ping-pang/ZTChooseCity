//
//  ZTIndexView.h
//  AddressList
//
//  Created by zt on 17/3/27.
//  Copyright © 2017年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^touchPointLocalCallBack)(NSInteger index);

@interface ZTIndexView : UIView

-(instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)array;

//字体大小、颜色、居中右左
-(void)setTitlefont:(NSInteger)titleFont andTitleColor:(UIColor *)color andTextAlignment:(NSTextAlignment)textAlignment;

@property(nonatomic,copy)touchPointLocalCallBack callBack;

//背景色
@property(nonatomic,assign)UIColor *indexViewBackColor;


@end
