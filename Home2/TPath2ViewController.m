//
//  TPath2ViewController.m
//  THomeIconAnimation
//
//  Created by tikeyc on 16/1/12.
//  Copyright © 2016年 tikeyc. All rights reserved.
//

#import "TPath2ViewController.h"
#import "ESPathIcon.h"


@interface TPath2ViewController ()


{
    UIImageView *_bigCircleImgView;
    UIImageView *_middleCircleImgView;
    UIImageView *_currentCircleImgView;
    UIView *_animationIconCircleBGView;
    
    ////
    UIView *_contentBGView;
    //
    NSArray *_currentShowImgNames;
    UIImageView *_currentShowImgView;
    
    //
    NSArray *_currentShowTitles;
    NSArray *_currentShowMessageTitles;
    UILabel *_currentShowTitleLabel;
    UIImageView *_messageCircle1;
    UIImageView *_messageCircle2;
    UILabel *_messageLabel1;
    UILabel *_messageLabel2;
    
    //
    NSArray *_currentButtonBGImgNormalNames;
    NSArray *_currentButtonBGImgSelectNames;
    NSArray *_currentButtonTitles;
    NSArray *_currentMessageCirclesImgNames;
    UIButton *_currentButton;
    
    ESPathIcon *_turnPathIcon;
    UILabel *_turnStoreLabel;   //转店参考label 解决该label覆盖问题
    
    NSMutableArray *_phomeNums;
    NSString *_currentPhoneNum;
}

@property (nonatomic,strong)NSMutableArray *pathIcons;
@property (nonatomic,strong)ESPathIcon *lastSelectPathIcon;

#define durationTime 0.9
#define delayTime 0.3

@end

@implementation TPath2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _currentShowImgNames = @[@"main_judgeShop_icon1_show@2x.png",@"main_judgeShop_icon2_show@2x.png",@"main_judgeShop_icon3_show@2x.png",@"main_judgeShop_icon4_show@2x.png"];
    _currentShowTitles = @[@"转店参考",@"电话评估",@"到店评估",@"快转服务"];
    _currentShowMessageTitles = @[@[@"周边的店转了多少钱?\n转了多久?\n谁在找我的店?"],@[@"免费评估1次",@"专家告诉你怎么转得\n快、转得价高!"],@[@"50元/次",@"专家到店现场考察分\n析,定制转店攻略!"],@[@"500元起",@"服务到转出为止!海量找\n店客户!千人转店专家!"]];
    _currentButtonBGImgNormalNames = @[@"main_judgeShop_buttonBG1.png",@"main_judgeShop_buttonBG2.png",@"main_judgeShop_buttonBG3.png",@"main_judgeShop_buttonBG4.png"];
    _currentButtonTitles = @[@"马上参考",@"联系专家",@"预约专家",@"联系客服"];
    _currentMessageCirclesImgNames = @[@"main_judgeShop_dian1_show.png",@"main_judgeShop_dian2_show.png",@"main_judgeShop_dian3_show.png",@"main_judgeShop_dian4_show.png",];
    
    [self initSubViews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubViews{
    //
    [self initCircleImgViewIsAddCurrentCircle:NO];
    //
    [self addIconImgViewTopMiddleCircleImg];
    //
    [self initCurrentCircleImgViewSubViewsOrRefreshViewsWithIndex:1];
    //

    _turnStoreLabel = [THelper labelWithFrame:CGRectMake(_turnPathIcon.left+_animationIconCircleBGView.left, _turnPathIcon.bottom + 3+_animationIconCircleBGView.top-20, _turnPathIcon.width, 21) text:@"转店参考" textColor:RGBColor(51, 51, 51) textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:12.0f]];
    _turnStoreLabel.hidden = YES;
    [self.view addSubview:_turnStoreLabel];
    //////
    [self startAnimation];
}

- (void)initCircleImgViewIsAddCurrentCircle:(BOOL)isAddCurrentCircle{
    if (isAddCurrentCircle) {
        //当前显示的圆 在添加 icon后add
        UIImage *currentImg = [UIImage imageNamed:@"main_judgeShop_currentCircleBG.png"];
        _currentCircleImgView = [[UIImageView alloc] initWithImage:currentImg];
        _currentCircleImgView.userInteractionEnabled = YES;
        _currentCircleImgView.size = CGSizeMake(currentImg.size.width, currentImg.size.height);
        _currentCircleImgView.center = _bigCircleImgView.center;
        //        _currentCircleImgView.layer.borderWidth = 1;
        //        _currentCircleImgView.layer.borderColor = [UIColor blueColor].CGColor;
        [self.view addSubview:_currentCircleImgView];
    }else{
        //大圆
        UIImage *bigImg = [UIImage imageNamed:@"main_judgeShop_bigCircleBG.png"];
        _bigCircleImgView = [[UIImageView alloc] initWithImage:bigImg];
        _bigCircleImgView.userInteractionEnabled = YES;
        _bigCircleImgView.size = CGSizeMake(bigImg.size.width, bigImg.size.height);
        _bigCircleImgView.center = self.view.center;
        _bigCircleImgView.top -= 44;
        _bigCircleImgView.left += 108 + 200;
        //        _bigCircleImgView.layer.borderWidth = 1;
        //        _bigCircleImgView.layer.borderColor = [UIColor purpleColor].CGColor;
        [self.view addSubview:_bigCircleImgView];
        //中圆
        UIImage *middleImg = [UIImage imageNamed:@"main_judgeShop_middleCircleBG.png"];
        _middleCircleImgView = [[UIImageView alloc] initWithImage:middleImg];
        _middleCircleImgView.userInteractionEnabled = YES;
        _middleCircleImgView.size = CGSizeMake(middleImg.size.width, middleImg.size.height);
        _middleCircleImgView.center = _bigCircleImgView.center;
        [self.view addSubview:_middleCircleImgView];
        //        _middleCircleImgView.layer.borderWidth = 1;
        //        _middleCircleImgView.layer.borderColor = [UIColor redColor].CGColor;
        
    }
}


- (void)addIconImgViewTopMiddleCircleImg{
    _animationIconCircleBGView = [[UIView alloc] initWithFrame:_bigCircleImgView.frame];
    _animationIconCircleBGView.userInteractionEnabled = YES;
    //不知道为什么要这样
    _animationIconCircleBGView.top += 10;
    _animationIconCircleBGView.left -= 15;
    //    _animationIconCircleBGView.center = _bigCircleImgView.center;
    _animationIconCircleBGView.backgroundColor = [UIColor clearColor];
    //    _animationIconCircleBGView.layer.borderWidth = 1;
    [self.view addSubview:_animationIconCircleBGView];
    //
    UIView *centerView = [[UIView alloc] init];
    centerView.size = CGSizeMake(4, 4);
    centerView.center = _animationIconCircleBGView.center;
    centerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:centerView];
    /////
    NSArray *normals = @[@"main_judgeShop_icon1_n.png",@"main_judgeShop_icon2_n.png",@"main_judgeShop_icon3_n.png",@"main_judgeShop_icon4_n.png",];
    NSArray *disEnables = @[@"main_judgeShop_icon1_s.png",@"main_judgeShop_icon2_s.png",@"main_judgeShop_icon3_s.png",@"main_judgeShop_icon4_s.png",];
    NSArray *titles = @[@"转店参考",@"电话评估",@"到店评估",@"快转服务",];
    float count = normals.count + 1;
    float radius = _animationIconCircleBGView.width/2;
    _pathIcons = [NSMutableArray array];
    __weak TPath2ViewController *this = self;
    for (NSInteger i = normals.count - 1; i >= 0; i--) {
        float offx = [THelper sin:(180.0/count)*(i + 1)];
        float offy = [THelper cos:(180.0/count)*(i + 1)];
        ESPathIcon *pathIcon = [[ESPathIcon alloc] initWithNormalImageName:normals[i] withSelectedImageName:disEnables[i] withLabelTitle:titles[i]];
        pathIcon.tag = i;
        float x = radius*(1 - offx);
        float y = 0;
        if (offy < 0) {
            y = radius*(1 - offy) + pathIcon.titleLabel.height + 6;
        }else{
            y = radius*(1 - offy) - pathIcon.titleLabel.height - 6;
        }
        y = radius*(1 - offy);
        pathIcon.center = CGPointMake(x, y);
        [_animationIconCircleBGView addSubview:pathIcon];
        //
        pathIcon.hidden = YES;
        [_pathIcons addObject:pathIcon];
        pathIcon.block = ^(ESPathIcon *resultPathIcon){
            [this changeCurrentCirleContentViews:resultPathIcon];
        };
        //
        if (i == 0) {
            _turnPathIcon = pathIcon;
        }else if (i == 1){
            pathIcon.titleLabel.hidden = YES;
            pathIcon.iconButton.enabled = NO;
            self.lastSelectPathIcon = pathIcon;
        }
    }
    //
    [self initCircleImgViewIsAddCurrentCircle:YES];
    
}

- (void)initCurrentCircleImgViewSubViewsOrRefreshViewsWithIndex:(NSInteger)index{
    
    switch (index) {
        case 0:

            break;
        case 1:

            break;
        case 2:
            break;
        case 3:

            break;
            
        default:
            break;
    }
    
    //内容
    if (_contentBGView == nil) {
        _contentBGView = [[UIView alloc] initWithFrame:_currentCircleImgView.frame];
        _contentBGView.backgroundColor = [UIColor clearColor];
        //        _contentBGView.layer.borderWidth = 1;
        [self.view addSubview:_contentBGView];
        //图片
        UIImage *showImg = [UIImage imageNamed:@"main_judgeShop_icon1_show.png"];
        _currentShowImgView = [[UIImageView alloc] initWithImage:showImg];
        _currentShowImgView.size = CGSizeMake(showImg.size.width, showImg.size.height);
        _currentShowImgView.top = 40;
        _currentShowImgView.left = 60;
        [_contentBGView addSubview:_currentShowImgView];
        //标题
        _currentShowTitleLabel = [THelper labelWithFrame:CGRectMake(_currentShowImgView.left, _currentShowImgView.bottom + 5, 120, 21) text:@"转店参考" textColor:RGBColor(51, 51, 51) textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:18.0f]];
        [_contentBGView addSubview:_currentShowTitleLabel];
        //介绍文字
        
        for (int i = 0; i < 2; i++) {
            UIImageView *circle = [[UIImageView alloc] initWithFrame:CGRectMake(_currentShowTitleLabel.left, _currentShowTitleLabel.bottom + 15 + _messageLabel1.height, 6, 6)];
            circle.image = [UIImage imageNamed:_currentMessageCirclesImgNames[index]];
            [_contentBGView addSubview:circle];
            //
            UILabel *textLabel = [THelper labelWithFrame:CGRectMake(circle.right + 5, circle.top - 4, 150, 21) text:nil textColor:RGBColor(51,51,51) textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:12.0f]];
            textLabel.numberOfLines = 0;
            [textLabel sizeToFit];
            [_contentBGView addSubview:textLabel];
            if (i == 0) {
                _messageCircle1 = circle;
                _messageLabel1 = textLabel;
            }else{
                _messageCircle2 = circle;
                _messageLabel2 = textLabel;
            }
        }
        ////按钮
        _currentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _currentButton.frame = CGRectMake(_currentShowTitleLabel.left, _currentCircleImgView.height - 70, 100, 30);
        [_currentButton addTarget:self action:@selector(currentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_contentBGView addSubview:_currentButton];
        
    }
    //刷新
    _currentShowImgView.image = [UIImage imageNamed:_currentShowImgNames[index]];
    _currentShowTitleLabel.text = _currentShowTitles[index];
    //
    _currentButton.tag = index;
    [_currentButton setTitle:_currentButtonTitles[index] forState:UIControlStateNormal];
    UIImage *normal = [UIImage imageNamed:_currentButtonBGImgNormalNames[index]];
    normal = [normal stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    [_currentButton setBackgroundImage:normal forState:UIControlStateNormal];
    //
    _messageCircle1.image = [UIImage imageNamed:_currentMessageCirclesImgNames[index]];
    _messageCircle2.image = [UIImage imageNamed:_currentMessageCirclesImgNames[index]];
    //
    _messageLabel1.width = 150;
    _messageLabel2.width = 150;
    if (index == 0){
        _messageCircle1.hidden = NO;
        _messageCircle2.hidden = YES;
        _messageLabel1.hidden = NO;
        _messageLabel2.hidden = YES;
        _messageLabel1.text = _currentShowMessageTitles[index][0];
        [_messageLabel1 sizeToFit];
        
    }else{
        _messageCircle1.hidden = NO;
        _messageCircle2.hidden = NO;
        _messageLabel1.hidden = NO;
        _messageLabel2.hidden = NO;
        _messageLabel1.text = _currentShowMessageTitles[index][0];
        [_messageLabel1 sizeToFit];
        _messageLabel2.top = _messageLabel1.bottom + 5;
        _messageLabel2.text = _currentShowMessageTitles[index][1];
        [_messageLabel2 sizeToFit];
        //
        _messageCircle2.top = _messageLabel2.top + 5;
    }
    
}

#pragma mark - ESPathIcon Block

- (void)changeCurrentCirleContentViews:(ESPathIcon *)pathIcon{
    if (self.lastSelectPathIcon == pathIcon) {
        return;
    }
    
    
    if (self.lastSelectPathIcon.tag != 0) {
        self.lastSelectPathIcon.titleLabel.hidden = NO;
    }
    self.lastSelectPathIcon.iconButton.enabled = YES;
    pathIcon.iconButton.enabled = NO;
    pathIcon.titleLabel.hidden = YES;
    pathIcon.iconButton.enabled = NO;
    self.lastSelectPathIcon = pathIcon;
    
    if (pathIcon.tag == 0) {
        _turnStoreLabel.hidden = YES;
    }else {
        _turnStoreLabel.hidden = NO;
    }
    
    //
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat angle = 0;
        if (pathIcon.tag == 0) {
            angle = (3 - pathIcon.tag)*M_PI/5 + 0.02;
        }else{
            angle = (3 - pathIcon.tag)*M_PI/5 ;
        }
        
        _currentCircleImgView.transform = CGAffineTransformMakeRotation(angle);
    }];
    [self initCurrentCircleImgViewSubViewsOrRefreshViewsWithIndex:pathIcon.tag];
}

//////////////
#pragma mark - Animation
- (void)startAnimation{
    
    //
    _bigCircleImgView.hidden = NO;
    _animationIconCircleBGView.hidden = NO;
    _middleCircleImgView.hidden = NO;
    _currentCircleImgView.hidden = NO;
    [UIView animateWithDuration:0.8 animations:^{
        _currentCircleImgView.transform = CGAffineTransformMakeRotation(2*M_PI/5 + 0.02);
        //
        _bigCircleImgView.left = 70;
        _animationIconCircleBGView.center = CGPointMake(_bigCircleImgView.center.x + 20, _bigCircleImgView.center.y);
        //不知道为什么要这样
        _animationIconCircleBGView.top += 10;
        _animationIconCircleBGView.left -= 15;
        //
        _middleCircleImgView.center = _bigCircleImgView.center;
        _currentCircleImgView.center = _bigCircleImgView.center;
        _contentBGView.center = _currentCircleImgView.center;
        
    } completion:^(BOOL finished) {
        _turnStoreLabel.left = _turnPathIcon.left+_animationIconCircleBGView.left;
    }];
    //
    [self performSelector:@selector(thread) withObject:nil afterDelay:0.4];
}

- (void)thread{
    /////circle Animation
    
    
    ////////////////icon Animation
    NSInteger count = _pathIcons.count;
    double duration = durationTime;
    for (int i = 0; i < _pathIcons.count; i++) {
        
        ESPathIcon *pathIcon = _pathIcons[i];
        //        pathIcon.hidden = YES;
        if (pathIcon.animation == nil) {
            CGPoint center = CGPointMake(_animationIconCircleBGView.width/2, _animationIconCircleBGView.height/2);
            float radius = _animationIconCircleBGView.width/2;
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-M_PI/6 endAngle:-(M_PI/(count + 1))*(count - i) - M_PI/2 clockwise:NO];
            //创建 实例
            CAKeyframeAnimation *animationOpen = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            animationOpen.delegate = self;
            //            animationOpen.repeatCount = MAX_INPUT;
            //设置path属性
            animationOpen.fillMode = kCAFillModeForwards;
            animationOpen.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
            
            animationOpen.duration = duration;
            animationOpen.path = path.CGPath;
            //
            pathIcon.animation = animationOpen;
        }
        
        [self performSelector:@selector(performSelectorAnimation:) withObject:pathIcon afterDelay:duration*i*delayTime];
        //        pathIcon.hidden = NO;
        //        [pathIcon.layer addAnimation:pathIcon.animation forKey:nil];
    }
    
}

- (void)performSelectorAnimation:(ESPathIcon *)pathIcon{
    pathIcon.hidden = NO;
    
    //    [NSThread detachNewThreadSelector:@selector(thread:) toTarget:self withObject:pathIcon];
    [pathIcon.layer addAnimation:pathIcon.animation forKey:nil];
    if (pathIcon == _turnPathIcon) {
        //        _turnStoreLabel.hidden = NO;
        [self performSelector:@selector(performHiddenTurnStoreLabel) withObject:nil afterDelay:0.1];
    }
}

- (void)performHiddenTurnStoreLabel{
    _turnPathIcon.titleLabel.hidden = YES;
    _turnStoreLabel.hidden = NO;
}

- (void)currentButtonClick:(UIButton *)button{
    

    NSInteger index = button.tag;
    
    switch (index) {
        case 1:
            
            break;
            
        default:
            break;
    }
}

@end




