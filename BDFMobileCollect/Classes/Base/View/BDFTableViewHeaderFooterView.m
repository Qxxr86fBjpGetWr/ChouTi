//
//  BDFTableViewHeaderFooterView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/9.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFTableViewHeaderFooterView.h"

@implementation BDFTableViewHeaderFooterView

+(instancetype)headerFooterViewWithTableView:(UITableView *)tableView {
    if (!tableView) {
        return [[self alloc] init];
    }
    NSString *clssname = NSStringFromClass([self class]);
    NSString *identify = [clssname stringByAppendingString:@"headerFooterID"];
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:identify];
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identify];
}

+(instancetype)nibHeaderFooterViewWithTableView:(UITableView *)tableView {
    if (!tableView) {
        return [[self alloc] init];
    }
    NSString *classname = NSStringFromClass([self class]);
    NSString *identify = [classname stringByAppendingString:@"nibHeaderFooterID"];
    UINib *nib = [UINib nibWithNibName:classname bundle:nil];
    [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identify];
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identify];
}



@end
