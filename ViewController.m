//
//  ViewController.m
//  THomeIconAnimation
//
//  Created by tikeyc on 16/1/12.
//  Copyright © 2016年 tikeyc. All rights reserved.
//

#import "ViewController.h"

#import "ESMainHomeTopIconAnimatonView.h"

@interface ViewController ()<ESMainHomeTopIconAnimatonViewDelegate>

@property (nonatomic, strong) ESMainHomeTopIconAnimatonView *homeTopIconAnimatonView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initHomeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)initHomeView{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 346/2)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];

    //中间圆圈 正在找店
    UIImageView *topBigCircleBGView = [[[NSBundle mainBundle]loadNibNamed:@"ESMainHomeTopCircleView" owner:nil options:nil] lastObject];
    topBigCircleBGView.left = (self.view.width - topBigCircleBGView.width)/2;
    topBigCircleBGView.top = - 11;
    [topView addSubview:topBigCircleBGView];
    //
    //icon
    _homeTopIconAnimatonView = [[ESMainHomeTopIconAnimatonView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, topView.height)];
    _homeTopIconAnimatonView.backgroundColor = [UIColor clearColor];
    _homeTopIconAnimatonView.delegate = self;
    [topView addSubview:_homeTopIconAnimatonView];
}

#pragma mark - ESMainHomeTopIconAnimatonViewDelegate
- (void)clickIconIndex:(int)index{
    NSLog(@"选中%d",index);

    switch (index) {
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
            
        default:
            break;
    }
    
}

@end
