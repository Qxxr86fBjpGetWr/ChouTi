//
//  BDFCustomSliderHeaderView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/6.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFCustomSliderHeaderView.h"
#import "BDFCustomSliderHeaderItem.h"

#define kLineHeight (1 / [UIScreen mainScreen].scale)

@interface BDFCustomSliderHeaderView()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *scrollLineView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, weak) CALayer *lineLayer;

@end

@implementation BDFCustomSliderHeaderView

// 设置偏移量
- (void)setContentOffset:(CGPoint)contentOffset {
    _contentOffset = contentOffset;
    CGFloat offsetX = contentOffset.x;
    // 当前索引
    NSInteger index = offsetX / SCREEN_WIDTH;
    
    BDFCustomSliderHeaderItem *leftItem = (BDFCustomSliderHeaderItem *)[self.scrollView viewWithTag:index + 1];
    // 下一个按钮 如果rightBtnLeftDelta > 0则下一个按钮开始渲染
    BDFCustomSliderHeaderItem *rightItem = (BDFCustomSliderHeaderItem *)[self.scrollView viewWithTag:index + 2];
    
    // right
    // 相对于当前屏幕的宽度
    CGFloat rightPageLeftDelta = offsetX - index * SCREEN_WIDTH;
    CGFloat progress = rightPageLeftDelta / SCREEN_WIDTH;
    
    if ([leftItem isKindOfClass:[BDFCustomSliderHeaderItem class]]) {
        leftItem.textColor = kOrangeColor;
        leftItem.fillColor = kBlackColor;
        leftItem.progress = progress;
    }
    if ([rightItem isKindOfClass:[BDFCustomSliderHeaderItem class]]) {
        rightItem.textColor = kBlackColor;
        rightItem.fillColor = kOrangeColor;
        rightItem.progress = progress;
    }
    
    for (BDFCustomSliderHeaderItem *itemView in self.scrollView.subviews) {
        if ([itemView isKindOfClass:[BDFCustomSliderHeaderItem class]]) {
            if (itemView.tag != index + 1 && itemView.tag != index + 2) {
                itemView.textColor = kBlackColor;
                itemView.fillColor = kRedColor;
                itemView.progress = 0.0;
            }
        }
    }
    // 重置当前索引
    self.currentIndex = index;
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
        
        self.scrollLineView.x = self.scrollLineView.width * (progress + index);
//
//        if(index + 1 >= 4 / 2 + 0 && index+1 <= self.titles.count - (4 / 2 - 1)){
//            [self.scrollView scrollRectToVisible:CGRectMake(leftItem.x - (self.frame.size.width - leftItem.frame.size.width) / 2, 0, self.frame.size.width , self.frame.size.height) animated:YES];
//        }
//
    } completion:^(BOOL finished) {

    }];
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    
    if (titles.count) {
        for (int i = 0; i < titles.count; i++) {
            BDFCustomSliderHeaderItem *item = [[BDFCustomSliderHeaderItem alloc] init];
            [self.scrollView addSubview:item];
            item.text = titles[i];
            item.textColor = kBlackColor;
            item.tag = i + 1;
            item.textAlignment = NSTextAlignmentCenter;
            item.userInteractionEnabled = YES;
            [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapGest:)]];
        }
    }
    
    // 位置
    CGFloat optionItemW = 0;
    
    if (self.titles.count) {
        self.scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - kLineHeight);
        if (self.titles.count > 6) {
            optionItemW = 90;
        }else {
            optionItemW = SCREEN_WIDTH / self.titles.count;
        }
        
        self.scrollView.contentSize = CGSizeMake(optionItemW * self.titles.count, self.scrollView.height - kLineHeight);
        CGFloat btnW = optionItemW;
        for (int i = 0 ; i < self.titles.count; i++) {
            BDFCustomSliderHeaderItem *item = (BDFCustomSliderHeaderItem *)[self.scrollView viewWithTag:i + 1];
            item.frame = CGRectMake(btnW * i, 0, btnW, self.scrollView.height);
        }
    }
    // 分割线
    self.lineLayer.frame = CGRectMake(0, self.scrollView.height - kLineHeight, SCREEN_WIDTH, kLineHeight);
    //滚动滑块
    self.scrollLineView.frame = CGRectMake(0, self.scrollView.height - kLineHeight - 3, optionItemW, 3);
}

// 点击item执行回调
- (void)itemTapGest:(UITapGestureRecognizer *)tapGest {
    BDFCustomSliderHeaderItem *item = (BDFCustomSliderHeaderItem *)tapGest.view;
    if (item) {
        if (self.homeHeaderOptionalViewItemClickHandle) {
            self.homeHeaderOptionalViewItemClickHandle(self, item.text, item.tag - 1);
        }
        self.currentIndex = item.tag - 1;
    }
}

- (UIView *)scrollLineView {
    if (!_scrollLineView) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = kOrangeColor;
        [self.scrollView addSubview:lineView];
        _scrollLineView = lineView;
    }
    return _scrollLineView;
}

- (UIScrollView *)scrollView {
    if(!_scrollView){
        UIScrollView *sc = [[UIScrollView alloc] init];
        sc.delegate = self;
        [self addSubview:sc];
        _scrollView = sc;
        sc.backgroundColor = [UIColor clearColor];
        sc.showsVerticalScrollIndicator = NO;
        sc.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (CALayer *)lineLayer {
    if (!_lineLayer) {
        CALayer *line = [CALayer layer];
        [self.scrollView.layer addSublayer:line];
        line.backgroundColor = kBlackColor.CGColor;
        _lineLayer = line;
    }
    return _lineLayer;
}

@end
