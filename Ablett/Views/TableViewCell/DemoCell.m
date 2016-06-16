//
//  DemoCell.m
//  Ablett
//
//  Created by ablett on 16/6/16.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "DemoCell.h"


@interface DemoCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@end
@implementation DemoCell

#pragma mark - Setter/Getter

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.titleLabel = [UILabel labelWithText:@"--"
                                   textColor:kTextColor
                               textAlignment:NSTextAlignmentLeft
                                        font:[UIFont systemFontOfSize:14.f]];
    [self addSubview:self.titleLabel];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat padding = 15.f;
    CGFloat margin = 10.f;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
        make.top.mas_equalTo(margin);
        make.bottom.mas_equalTo(-margin);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
