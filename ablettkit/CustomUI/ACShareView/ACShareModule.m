//
//  ACShareModule.m
//  YiRong
//
//  Created by ablett on 16/5/12.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "ACShareModule.h"


@interface ACShareModule ()
{
    UIView *_hLine;
    UIView *_vLine;
}
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation ACShareModule


- (instancetype)init {
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {

    CGFloat fontSize = 12.f;
    
    self.iconImageView = [[UIImageView alloc] init];
    
    self.titleLabel = [UILabel labelWithText:@"--"
                                textColor:UIColorHex(@"#999999")
                            textAlignment:NSTextAlignmentCenter
                                     font:[UIFont systemFontOfSize:fontSize]];
    
    self.iconImageView.backgroundColor = kBgColor;
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapGr];
    
    
    _hLine = [[UIView alloc] init];
    _vLine = [[UIView alloc] init];
    
    [self addSubview:_hLine];
    [self addSubview:_vLine];
    
//    _hLine.backgroundColor = kColorViewBG;
//    _vLine.backgroundColor = kColorViewBG;
}

- (void)tapAction:(id)sender {
    if (self.action) {
        self.action();
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak typeof(&*self)weakSelf = self;
    
    [_hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf);
        make.height.equalTo(@1);
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
    
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@1);
        make.height.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
    }];
    
    CGFloat iconH = self.height*0.5;
    CGFloat titleH = self.height*0.25;
    self.iconImageView.layer.cornerRadius = iconH/2;
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(iconH);
        make.top.equalTo(weakSelf).offset(titleH*0.75);
        make.centerX.equalTo(weakSelf);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf);
        make.height.mas_equalTo(titleH);
        make.bottom.equalTo(weakSelf);
    }];
}

#pragma mark - Setter/Getter

- (void)setIcon:(NSString *)icon {
    _icon = icon;
    self.iconImageView.image = [UIImage imageNamed:icon];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

@end
