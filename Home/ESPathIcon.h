//
//  ESPathIconView.h
//  Estate
//
//  Created by tikeyc on 14/11/5.
//  Copyright (c) 2014年 Andy li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CliciIconBlock) (id result);

@interface ESPathIcon : UIView

{
    CGPoint _startPoint;
    CGPoint _nearbyPoint;
    CGPoint _farPoint;
    CGPoint _endPoint;
    CAKeyframeAnimation *_animation;
}
@property (nonatomic,assign)CGPoint startPoint;
@property (nonatomic,assign)CGPoint nearbyPoint;
@property (nonatomic,assign)CGPoint farPoint;
@property (nonatomic,assign)CGPoint endPoint;
@property (nonatomic,strong)CAKeyframeAnimation *animation;
@property (nonatomic,copy)CliciIconBlock block;

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *iconButton;

- (id)initWithNormalImageName:(NSString *)imageName withSelectedImageName:(NSString *)imageName  withLabelTitle:(NSString *)title;

@end
