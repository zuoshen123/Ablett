//
//  ACShareView.m
//  YiRong
//
//  Created by ablett on 16/5/12.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "ACShareView.h"
#import "ACShareItem.h"
#import "ACShareModule.h"

static const NSInteger row = 2;//行数为2，不可修改
static const CGFloat pcH = 10.f;
static const CGFloat cancelH = 50.f;

@interface ACShareView ()<UIScrollViewDelegate>
{
    UIView *_sline;
}
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) NSMutableArray *moduleBtns;

@end

@implementation ACShareView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.980];
    _sline = [[UIView alloc] init];
    _sline.backgroundColor = kBgColor;
    [self.cancelBtn addSubview:_sline];
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self addSubview:self.cancelBtn];
    self.pageControl.hidden = YES;
    
    // set default values
    self.column = 5;
    self.moduleBtns = [NSMutableArray arrayWithCapacity:self.items.count];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak typeof(&*self)weakSelf = self;
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf);
        make.height.mas_equalTo(cancelH);
        make.bottom.equalTo(weakSelf);
    }];
    
    [_sline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.cancelBtn);
        make.height.equalTo(@1);
        make.centerX.equalTo(weakSelf.cancelBtn);
        make.top.equalTo(weakSelf.cancelBtn);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(pcH);
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.cancelBtn.mas_top);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(self.pageControl.mas_top);
    }];

    CGFloat moduleBtnW = self.width/self.column;
    CGFloat moduleBtnH = (self.height-cancelH-pcH)/row;
    
    self.scrollView.contentSize = CGSizeMake(self.width*self.page, moduleBtnH);
    
    //设置每个 moduleBtn 的坐标
    if (self.page!=0) {
        
        //满页个数
        NSInteger onePageNum = row*self.column;
        
        
        for (NSInteger pindex = 0; pindex < self.page; pindex++) {
            
            //是否为整页
            if (self.items.count % onePageNum == 0) {
                
                for (NSInteger j = 0; j < onePageNum; j++) {
                    //列
                    NSInteger col = j%self.column;
                    //行
                    NSInteger row = j/self.column;
                    
                    CGFloat mb_x = col * moduleBtnW + (pindex*self.width);
                    CGFloat mb_y = row * moduleBtnH;
                    
                    CGRect mbFram = CGRectMake(mb_x, mb_y, moduleBtnW, moduleBtnH);
                    [self.moduleBtns[j+onePageNum*pindex] setFrame:mbFram];
                }
                
            }else {
                if (pindex < self.page - 1) {
                    for (NSInteger j = 0; j < onePageNum; j++) {
                        //列
                        NSInteger col = j%self.column;
                        //行
                        NSInteger row = j/self.column;
                        
                        CGFloat mb_x = col * moduleBtnW + (pindex*self.width);
                        CGFloat mb_y = row * moduleBtnH;
                        
                        CGRect mbFram = CGRectMake(mb_x, mb_y, moduleBtnW, moduleBtnH);
                        [self.moduleBtns[j+onePageNum*pindex] setFrame:mbFram];
                    }
                    
                }else {
                    
                    NSInteger remainder = self.items.count % onePageNum;
                    
                    for (NSInteger j = 0; j < remainder; j++) {
                        
                        //列
                        NSInteger col = j%self.column;
                        //行
                        NSInteger row = j/self.column;
                        
                        CGFloat mb_x = col * moduleBtnW + (pindex*self.width);
                        CGFloat mb_y = row * moduleBtnH;
                        
                        CGRect mbFram = CGRectMake(mb_x, mb_y, moduleBtnW, moduleBtnH);
                        [self.moduleBtns[j+onePageNum*pindex] setFrame:mbFram];
                    }
                }
            }
        }
    }
}

#pragma mark - Public

- (instancetype)initWithColumnNum:(NSInteger)columnNum items:(NSMutableArray *)items {
    
    self = [super init];
    if (self) {
        self.column = columnNum;
        self.items = items;
    }
    return self;
}

#pragma mark - Setter/Getter

- (void)setItems:(NSMutableArray *)items {
    _items = items;
    __weak typeof(&*self)weakSelf = self;
    
    //移除 module 上的 btn
    for (ACShareModule *btn in self.scrollView.subviews) {
        [btn removeFromSuperview];
    }
    [self.moduleBtns removeAllObjects];
    
    //创建 moduleBtn 并添加到 scrollView;
    
    CGFloat moduleBtnW = self.width/self.column;
    CGFloat moduleBtnH = (self.height-cancelH-pcH)/row;
    
    
    
    for (int index = 0; index < items.count; index++) {
        ACShareItem *si = items[index];
        
        ACShareModule *btn = [[ACShareModule alloc] init];
        btn.size = CGSizeMake(moduleBtnW, moduleBtnH);
        btn.title = si.title;
        btn.icon = si.icon;
        
        btn.tag = index;
        btn.action = ^(){
            if (weakSelf.action) {
                weakSelf.action(index);
            }
        };
        [self.moduleBtns addObject:btn];
        [self.scrollView addSubview:btn];
    }
    
    if (self.page <= 1) {
        self.pageControl.hidden = YES;
    }else {
        self.pageControl.hidden = NO;
        self.pageControl.numberOfPages = self.page;
    }
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.directionalLockEnabled = YES;
        _scrollView.pagingEnabled = NO;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:UIColorHex(@"#898989") forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
        [_cancelBtn setBackgroundImage:[UIImage imageWithColor:UIColorHex(@"#D6D9E0")] forState:UIControlStateHighlighted];
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = UIColorHex(@"#FFA57E");
        _pageControl.pageIndicatorTintColor = UIColorHex(@"#F4F6F9");
    }
    return _pageControl;
}

- (void)cancelBtnAction:(id)sender {
    if (self.cancelAction) {
        self.cancelAction();
    }
}

#pragma mark - Privite

- (NSInteger)page {
    //每页 item 个数
    NSInteger itemNumPerPage = row*self.column;
    
    if (self.items.count == 0) {
        return 0;
    }else {
        if (self.items.count <= itemNumPerPage) {
            return 1;
        }else {
            if (self.items.count % itemNumPerPage == 0) {
                return self.items.count/itemNumPerPage;
            }else {
                return self.items.count/itemNumPerPage+1;
            }
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.pageControl.currentPage = (scrollView.contentOffset.x-scrollView.width/2)/scrollView.width+1;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
}

@end
