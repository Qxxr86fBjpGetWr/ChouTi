//
//  BDFBaseTableViewCell.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/9.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFBaseTableViewCell.h"

@implementation BDFBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(UITableView *)tableView {
    float version = [[UIDevice currentDevice].systemVersion floatValue];
    if (version >= 7.0) {
        return  (UITableView *)self.superview.superview;
    }else {
        return (UITableView *)self.superview;
    }
}

+(instancetype)cellWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[self alloc] init];
    }
    NSString *className = NSStringFromClass(self);
    NSString *identify = [className stringByAppendingString:@"cellID"];
    [tableView registerClass:[self class] forCellReuseIdentifier:identify];
    return [tableView dequeueReusableCellWithIdentifier:identify];
}

+(instancetype)nibWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    }
    NSString *classname = NSStringFromClass([self class]);
    NSString *identifier = [classname stringByAppendingString:@"nibCellID"];
    UINib *nib = [UINib nibWithNibName:classname bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

@end
