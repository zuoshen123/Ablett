//
//  ACShareView.h
//  YiRong
//
//  Created by ablett on 16/5/12.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Action)(NSInteger index);
typedef void(^CancelAction)(void);

@interface ACShareView : UIView

@property (strong, nonatomic) NSMutableArray        *items;
@property (assign, nonatomic, readonly) NSInteger   page;
@property (assign, nonatomic) NSInteger             column;
@property (copy, nonatomic) Action                  action;
@property (copy, nonatomic) CancelAction            cancelAction;

- (instancetype)initWithColumnNum:(NSInteger)columnNum items:(NSMutableArray *)items;

@end
