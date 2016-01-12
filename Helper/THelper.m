//
//  THelper.m
//  THomeIconAnimation
//
//  Created by tikeyc on 16/1/12.
//  Copyright © 2016年 tikeyc. All rights reserved.
//

#import "THelper.h"

@implementation THelper


+ (UIButton *)buttonsetIamgeWithFrame:(CGRect)frame
                                nfile:(NSString *)nfileName
                                sfile:(NSString *)sfileName
                                  tag:(NSInteger)buttonTag
                               action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setImage:[UIImage imageNamed:nfileName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:sfileName] forState:UIControlStateHighlighted];
    [button setTag:buttonTag];
    [button addTarget:nil action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


#pragma mark 度转弧度
+ (float)huDuFromdu:(float)du
{
    return M_PI/(180/du);
}

#pragma mark 计算sin
+ (float)sin:(float)du
{
    return sinf(M_PI/(180/du));
}

#pragma mark 计算cos
+ (float)cos:(float)du
{
    return cosf(M_PI/(180/du));
}

@end
