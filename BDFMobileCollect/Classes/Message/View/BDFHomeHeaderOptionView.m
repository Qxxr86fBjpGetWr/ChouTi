//
//  BDFHomeHeaderOptionView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/6/1.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFHomeHeaderOptionView.h"
#import "BDFHomeHeaderOptionItemView.h"

#define kSeperatorColor kRGBColor(234,237,240)
#define kLineHeight (1 / [UIScreen mainScreen].scale)
#define kCommonBlackColor [UIColor lightGrayColor]
#define kCommonHighLightRedColor [UIColor blackColor]

@interface BDFHomeHeaderOptionView () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) CALayer *lineLayer;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, weak) UIView *scrollLineView;

@end

@implementation BDFHomeHeaderOptionView

// 设置偏移量
- (void)setContentOffset:(CGPoint)contentOffset {
    _contentOffset = contentOffset;
    CGFloat offsetX = contentOffset.x;
    // 当前索引
    NSInteger index = offsetX / SCREEN_WIDTH;
    
    BDFHomeHeaderOptionItemView *leftItem = (BDFHomeHeaderOptionItemView *)[self.scrollView viewWithTag:index + 1];
    // 下一个按钮 如果rightBtnLeftDelta > 0则下一个按钮开始渲染
    BDFHomeHeaderOptionItemView *rightItem = (BDFHomeHeaderOptionItemView *)[self.scrollView viewWithTag:index + 2];
    
    // right
    // 相对于当前屏幕的宽度
    CGFloat rightPageLeftDelta = offsetX - index * SCREEN_WIDTH;
    CGFloat progress = rightPageLeftDelta / SCREEN_WIDTH;
    
    if ([leftItem isKindOfClass:[BDFHomeHeaderOptionItemView class]]) {
        leftItem.textColor = kBlackColor;
        leftItem.fillColor = kCommonBlackColor;
        leftItem.progress = progress;
    }
    if ([rightItem isKindOfClass:[BDFHomeHeaderOptionItemView class]]) {
        rightItem.textColor = kCommonBlackColor;
        rightItem.fillColor = kBlackColor;
        rightItem.progress = progress;
    }
    
    for (BDFHomeHeaderOptionItemView *itemView in self.scrollView.subviews) {
        if ([itemView isKindOfClass:[BDFHomeHeaderOptionItemView class]]) {
            if (itemView.tag != index + 1 && itemView.tag != index + 2) {
                itemView.textColor = kCommonBlackColor;
                itemView.fillColor = kCommonHighLightRedColor;
                itemView.progress = 0.0;
            }
        }
    }
    
    // 重置当前索引
    self.currentIndex = index;
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
        
        self.scrollLineView.x = self.scrollLineView.width * (progress + index);
        
        if(index + 1 >= 4 / 2 + 0 && index+1 <= self.titles.count - (4 / 2 - 1)){
            [self.scrollView scrollRectToVisible:CGRectMake(leftItem.x - (self.frame.size.width - leftItem.frame.size.width) / 2, 0, self.frame.size.width , self.frame.size.height) animated:YES];
        }
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    
    // 标题
    if (titles.count) {
        for (int i = 0; i < titles.count; i++) {
            BDFHomeHeaderOptionItemView *item = [[BDFHomeHeaderOptionItemView alloc] init];
            [self.scrollView addSubview:item];
            item.text = titles[i];
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
            optionItemW = 60;
        }else {
            optionItemW = SCREEN_WIDTH / self.titles.count;
        }
        
        self.scrollView.contentSize = CGSizeMake(optionItemW * self.titles.count, self.scrollView.height - kLineHeight);
        CGFloat btnW = optionItemW;
        for (int i = 0 ; i < self.titles.count; i++) {
            BDFHomeHeaderOptionItemView *item = (BDFHomeHeaderOptionItemView *)[self.scrollView viewWithTag:i + 1];
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
    BDFHomeHeaderOptionItemView *item = (BDFHomeHeaderOptionItemView *)tapGest.view;
    if (item) {
        
        if (self.homeHeaderOptionalViewItemClickHandle) {
            self.homeHeaderOptionalViewItemClickHandle(self, item.text, item.tag - 1);
        }
        self.currentIndex = item.tag - 1;
    }
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
        line.backgroundColor = kSeperatorColor.CGColor;
        _lineLayer = line;
    }
    return _lineLayer;
}


- (UIView *)scrollLineView {
    if (!_scrollLineView) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = kBlackColor;
        [self.scrollView addSubview:lineView];
        _scrollLineView = lineView;
    }
    return _scrollLineView;
}

@end
