//
//  ESPathIconView.h
//  Estate
//
//  Created by tikeyc on 16/1/12.
//  Copyright © 2016年 tikeyc. All rights reserved.
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
