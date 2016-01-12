//
//  ESMainHomeTopIconAnimatonView.h
//  Estate
//
//  Created by tikeyc on 16/1/12.
//  Copyright © 2016年 tikeyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ESMainHomeTopIconAnimatonViewDelegate <NSObject>

@optional
- (void)clickIconIndex:(int)index;

@end

@interface ESMainHomeTopIconAnimatonView : UIView

@property (nonatomic,weak)id <ESMainHomeTopIconAnimatonViewDelegate> delegate;


- (void)startAnimation;

@end
