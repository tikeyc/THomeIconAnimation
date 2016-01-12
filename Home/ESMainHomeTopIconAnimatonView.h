//
//  ESMainHomeTopIconAnimatonView.h
//  Estate
//
//  Created by tikeyc on 14/11/5.
//  Copyright (c) 2014年 Andy li. All rights reserved.
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
