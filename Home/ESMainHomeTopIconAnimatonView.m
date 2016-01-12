//
//  ESMainHomeTopIconAnimatonView.m
//  Estate
//
//  Created by tikeyc on 16/1/12.
//  Copyright © 2016年 tikeyc. All rights reserved.
//

#import "ESMainHomeTopIconAnimatonView.h"
#import "ESPathIcon.h"

@interface ESMainHomeTopIconAnimatonView ()

{
    ESPathIcon *_pathIcon1;
    ESPathIcon *_pathIcon2;
    ESPathIcon *_pathIcon3;
    ESPathIcon *_pathIcon4;
    ESPathIcon *_pathIcon5;
    
    NSMutableArray *_pathIcons;
}

@end

#define radus 140
#define radusTop 30

@implementation ESMainHomeTopIconAnimatonView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView{
    NSArray *iconImgName = @[@"main_home_icon_rent.png",@"main_home_icon_qiuzu.png",@"main_home_icon_business.png",@"main_home_icon_buy.png",@"main_home_icon_sell.png"];
    NSArray *iconSelectedImgNames = @[@"main_home_icon_rent_selected.png",@"main_home_icon_qiuzu_selected.png",@"main_home_icon_business_selected.png",@"main_home_icon_buy_selected.png",@"main_home_icon_sell_selected.png"];
    NSArray *iconTitles = @[@"出租",@"求租",@"转让",@"求购",@"出售"];
    _pathIcons = [NSMutableArray array];
    NSInteger count = iconImgName.count + 1;
    for (int i = 0; i < iconImgName.count; i++) {
        ESPathIcon *pathIcon = [[ESPathIcon alloc] initWithNormalImageName:iconImgName[i] withSelectedImageName:iconSelectedImgNames[i]  withLabelTitle:iconTitles[i]];
        pathIcon.tag = i + 1;
        float offx = [THelper cos:(180/count)*(i + 1)];
        float offy = [THelper sin:(180/count)*(i + 1)];
        if (i == 0) {//
            _pathIcon1 = pathIcon;
        }else if (i == 1){//


            _pathIcon2 = pathIcon;
        }else if (i == 2){//

            _pathIcon3 = pathIcon;
        }else if (i == 3){//

            _pathIcon4 = pathIcon;
        }else if (i == 4){//
            _pathIcon5 = pathIcon;
        }
        pathIcon.center = CGPointMake(self.width/2 - radus*offx, radus*offy - radusTop);
        pathIcon.endPoint = pathIcon.center;
        __weak typeof(ESPathIcon) *weekPathIcon = pathIcon;
        __weak ESMainHomeTopIconAnimatonView *this = self;
        pathIcon.block = ^(id result){
            [this iconClickResult:weekPathIcon];
        };
        [self addSubview:pathIcon];
        //
        pathIcon.hidden = YES;
        [_pathIcons addObject:pathIcon];
    }
    
    [self startAnimation];
}


- (void)iconClickResult:(ESPathIcon *)pathIcon{
    if ([_delegate respondsToSelector:@selector(clickIconIndex:)]) {
        [_delegate clickIconIndex:pathIcon.tag];
    }
}

- (void)startAnimation{
    
    [NSThread detachNewThreadSelector:@selector(thread) toTarget:self withObject:nil];
//    [self thread];
    
}

- (void)thread{
    
    //1 (M_PI*5)/6
    //2 (M_PI*4)/6
    //3 (M_PI*3)/6
    //4 (M_PI*2)/6
    //5 (M_PI*1)/6
    for (int i= 0; i < _pathIcons.count; i++) {
        
        double duration = 0.6;
        ESPathIcon *pathIcon = _pathIcons[i];
        pathIcon.hidden = YES;
        if (pathIcon.animation == nil) {
            CGPoint center = CGPointMake(self.width/2, -radusTop);
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radus startAngle:-M_PI/6 endAngle:(M_PI*(_pathIcons.count - i))/6 clockwise:YES];
            //创建 实例
            CAKeyframeAnimation *animationOpen = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            animationOpen.delegate = self;
            //设置path属性
            animationOpen.fillMode = kCAFillModeForwards;
            animationOpen.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
            
            animationOpen.duration = duration;
            animationOpen.path = path.CGPath;
            //
            pathIcon.animation = animationOpen;
        }
        double delayTime = 0;
        if (i == 2) {
            delayTime = duration*i*0.3;
        }else if (i == 3){
            delayTime = duration*i*0.3 + 0.1;
        }else{
            delayTime = i == _pathIcons.count - 1 ? duration*i*0.25 : duration*i*0.3 + 0.1;
        }
        [self performSelector:@selector(performSelectorAnimation:) withObject:pathIcon afterDelay:delayTime];
    }

    [[NSRunLoop currentRunLoop] run];
}

- (void)performSelectorAnimation:(ESPathIcon *)pathIcon{
    pathIcon.hidden = NO;
    //    [NSThread detachNewThreadSelector:@selector(thread:) toTarget:self withObject:pathIcon];
    [pathIcon.layer addAnimation:pathIcon.animation forKey:nil];
}

@end






