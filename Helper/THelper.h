//
//  THelper.h
//  THomeIconAnimation
//
//  Created by tikeyc on 16/1/12.
//  Copyright © 2016年 tikeyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THelper : NSObject


+ (UIButton *)buttonsetIamgeWithFrame:(CGRect)frame
                                nfile:(NSString *)nfileName
                                sfile:(NSString *)sfileName
                                  tag:(NSInteger)buttonTag
                               action:(SEL)action;


+ (float)huDuFromdu:(float)du;
+ (float)sin:(float)du;
+ (float)cos:(float)du;

@end
