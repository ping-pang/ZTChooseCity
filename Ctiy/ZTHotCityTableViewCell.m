//
//  ZTHotCityTableViewCell.m
//  EasyBuy
//
//  Created by zt on 17/3/28.
//  Copyright © 2017年 晴天微笑. All rights reserved.
//

#import "ZTHotCityTableViewCell.h"

@implementation ZTHotCityTableViewCell
#define BtnW 60
#define BtnH 30
#define middle 10
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self) {
//        self = [super initWithFrame:frame];
//    }
//}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self) {
        self = [super initWithFrame:frame];
        _array = [NSArray arrayWithObjects:@"北京",@"上海",@"武汉",@"沈阳",@"南京",@"广州",@"天津",@"济南", nil];
        CGFloat screenW = frame.size.width;
        
        int vertical = 0;  //竖
        int horizontal = 0; //横
        
        NSInteger horizontalNum = screenW/(BtnW+20);
        
        for (int i = 0; i<_array.count; i++) {
            
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(middle*(horizontal+1)+horizontal*BtnW, middle*(vertical+1)+vertical*BtnH, BtnW, BtnH)];
            [btn setTag:i];
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor grayColor].CGColor;
            [btn setTitle:_array[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [self addSubview:btn];
                horizontal++;
            
            if (horizontal>horizontalNum) {
                horizontal = 0;
                vertical ++;
            }
            
        }
        
        CGRect rect = CGRectMake(0, 0, frame.size.width, middle*(vertical+1)+vertical*BtnH +BtnH+middle);
        self.frame = rect;
        
//      NSInteger horizontalNum
    }
    return self;
}

-(void)click:(UIButton *)sender{
    self.hotCityCallBack(_array[sender.tag]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
