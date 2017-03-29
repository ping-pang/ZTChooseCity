//
//  ZTIndexView.m
//  AddressList
//
//  Created by zt on 17/3/27.
//  Copyright © 2017年 zt. All rights reserved.
//

#import "ZTIndexView.h"

@implementation ZTIndexView
static CGFloat itemH;

-(instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)array{
    if (self) {
        self = [super initWithFrame:frame];
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        
        itemH = frame.size.height/array.count;
        
        for (int i = 0; i<array.count; i++) {
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, itemH*i, frame.size.width, itemH)];
            lab.textAlignment = NSTextAlignmentRight;
            
            lab.text = array[i];
            [self addSubview:lab];
        }

    }
    
    return self;
}


-(void)tap:(UITapGestureRecognizer *)tap{
    CGPoint point = [tap locationInView:self];
    CGFloat pointH = point.y;
    
    NSInteger touchP = (NSInteger)pointH/itemH;
    self.callBack(touchP);
}

-(void)setIndexViewBackColor:(UIColor *)indexViewBackColor{
    self.backgroundColor = indexViewBackColor;
}

-(void)setTitlefont:(NSInteger)titleFont andTitleColor:(UIColor *)color andTextAlignment:(NSTextAlignment)textAlignment{
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UILabel class]]) {
                UILabel *lab = (UILabel *)view;
                if (titleFont) {
                    lab.font = [UIFont systemFontOfSize:titleFont];
                }
                if (color) {
                    lab.textColor = color;
                }
                if (textAlignment) {
                    lab.textAlignment = textAlignment;
                }
            }
        }
}



@end
