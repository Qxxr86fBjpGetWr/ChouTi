//
//  BDFTableViewHeaderFooterView.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/9.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDFTableViewHeaderFooterView : UITableViewHeaderFooterView

/**
 *  快速创建一个不是从xib中加载的tableview header footer
 */
+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView;
/**
 *  快速创建一个从xib中加载的tableview header footer
 */
+ (instancetype)nibHeaderFooterViewWithTableView:(UITableView *)tableView;

@end
