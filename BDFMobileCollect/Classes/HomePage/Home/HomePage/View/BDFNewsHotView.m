//
//  BDFNewsHotView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/2.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFNewsHotView.h"

@interface BDFNewsHotView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BDFNewsHotView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

@end
