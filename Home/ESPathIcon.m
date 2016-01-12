//
//  ESPathIconView.m
//  Estate
//
//  Created by tikeyc on 14/11/5.
//  Copyright (c) 2014年 Andy li. All rights reserved.
//

#import "ESPathIcon.h"

@implementation ESPathIcon

{
    UIImage *_image;
    UIImage *_selectedImg;
    NSString *_title;
}

- (id)initWithNormalImageName:(NSString *)imageName withSelectedImageName:(NSString *)selectedImg  withLabelTitle:(NSString *)title{
    self = [super init];
    if (self) {
        _image = [UIImage imageNamed:imageName];
        _selectedImg = [UIImage imageNamed:selectedImg];
        _title = title;
        self.bounds = CGRectMake(0, 0, _image.size.width, _image.size.height + 6 + 13);
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    //
    _iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconButton.frame = CGRectMake(0, 0, _image.size.width, _image.size.height);
    [_iconButton setImage:_image forState:UIControlStateNormal];
    [_iconButton setImage:_selectedImg forState:UIControlStateHighlighted];
    [_iconButton setImage:_selectedImg forState:UIControlStateDisabled];
    _iconButton.showsTouchWhenHighlighted = YES;
    [_iconButton addTarget:self action:@selector(clickIcon:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_iconButton];
    //
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _iconButton.bottom + 6, _iconButton.width, 13)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = Arial_12;
    _titleLabel.textColor = RGBColor(51, 51, 51);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = _title;
//    label.layer.shadowOffset = CGSizeMake(5, 5);
//    label.layer.shadowOpacity = 0.5;
    [self addSubview:_titleLabel];
}

#pragma mark - Actions method


- (void)clickIcon:(UIButton *)button{
    if (self.block) {
        self.block(self);
    }
}

@end
