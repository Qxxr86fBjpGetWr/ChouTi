//
//  BDFAllTypeNewsView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/10/20.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFAllTypeNewsView.h"
#import "BDFAllTypeCollectionCell.h"

@interface BDFAllTypeNewsView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableDictionary <NSNumber *,NSMutableArray <BDFHomeSubjectModel *>*> *dataMap;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;
@end

@implementation BDFAllTypeNewsView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame
           collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = kWhiteColor;
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataMap.allKeys.count;
}

//设置最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//设置最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSMutableArray *tempArray = self.dataMap[[NSNumber numberWithInteger:section]];
    return tempArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(100, 50);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BDFAllTypeCollectionCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BDFAllTypeCollectionCell"
                                                                                         forIndexPath:indexPath];
    if (!collectionViewCell) {
        collectionViewCell = [[BDFAllTypeCollectionCell alloc] init];
    }
    BDFHomeSubjectModel *rowData = [self getDataModelWithIndexPath:indexPath];
    collectionViewCell.titleLabel.text = rowData.name_cn;
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, collectionViewCell.width, collectionViewCell.height)];
//    title.textAlignment = NSTextAlignmentCenter;
//    title.center = collectionViewCell.center;
//    title.textColor = kLightGrayColor;
//    title.text = rowData.name_cn;
//    title.backgroundColor = kClearColor;
//    title.center = collectionViewCell.contentView.center;
    if ([indexPath isEqual:self.selectIndexPath]) {
        collectionViewCell.backgroundColor = kColorFromRGB(0xf5f5f5);
    } else {
        collectionViewCell.backgroundColor = kWhiteColor;
    }
    return collectionViewCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectIndexPath = indexPath;
    if (indexPath.section == 0) {
        BDFHomeSubjectModel *rowData = [self getDataModelWithIndexPath:indexPath];
        NSString *selectorString = [NSString stringWithFormat:@"%@%@",@"bdfHomeSubjectsDidSelect_",rowData.name_en];
        SEL selector = NSSelectorFromString(selectorString);
        if ([self.selectDelegate respondsToSelector:selector]) {
            [self.selectDelegate performSelector:selector];
        }
    }else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                if ([self.selectDelegate respondsToSelector:@selector(bdfHomeSubjectsDidSelectMostHot)]) {
                    [self.selectDelegate bdfHomeSubjectsDidSelectMostHot];
                }
                break;
            case 1:
                if ([self.selectDelegate respondsToSelector:@selector(bdfHomeSubjectsDidSelectTopic)]) {
                    [self.selectDelegate bdfHomeSubjectsDidSelectTopic];
                }
                break;
            case 2:
                if ([self.selectDelegate respondsToSelector:@selector(bdfHomeSubjectsDidSelectAttention)]) {
                    [self.selectDelegate bdfHomeSubjectsDidSelectAttention];
                }
                break;
            case 3:
                if ([self.selectDelegate respondsToSelector:@selector(bdfHomeSubjectsDidSelectPeople)]) {
                    [self.selectDelegate bdfHomeSubjectsDidSelectPeople];
                }
                break;
            case 4:
                if ([self.selectDelegate respondsToSelector:@selector(bdfHomeSubjectsDidSelectCollection)]) {
                    [self.selectDelegate bdfHomeSubjectsDidSelectCollection];
                }
                break;
                
            default:
                break;
        }
    }
}

- (BDFHomeSubjectModel *)getDataModelWithIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray <BDFHomeSubjectModel *> *secData = self.dataMap[[NSNumber numberWithInteger:indexPath.section]];
    BDFHomeSubjectModel *rowData = secData[indexPath.row];
    return rowData;
}

- (void)setSubjectsModel:(BDFHomeSubjectsModel *)subjectsModel {
    if (!subjectsModel) {
        return;
    }
    /** 第一组数据源拼接 */
    BDFHomeSubjectModel *model = [[BDFHomeSubjectModel alloc] init];
    model.name_cn = @"新热榜";
    model.id = @"0";
    [subjectsModel.subjects insertObject:model atIndex:0];
    
    /** 第二组数据源拼接 */
    NSArray *secondDataArray = @[@"最热榜",@"话题",@"关注人动态",@"人类发布",@"私藏"];
    NSMutableArray *tempArray = @[].mutableCopy;
    for (int i = 0; i < secondDataArray.count; i ++) {
        BDFHomeSubjectModel *model = [[BDFHomeSubjectModel alloc] init];
        model.name_cn = secondDataArray[i];
        model.id = [NSString stringWithFormat:@"%d",i];
        [tempArray addObject:model];
    }
    [self.dataMap setObject:subjectsModel.subjects forKey:@0];
    [self.dataMap setObject:tempArray forKey:@1];
    /** 计算大小 */
    NSInteger maxItemCount = MAX(subjectsModel.subjects.count, tempArray.count);
    self.size = CGSizeMake(200, maxItemCount * 50);
    [self reloadData];
}

- (NSMutableDictionary *)dataMap {
    if (!_dataMap) {
        _dataMap = @{}.mutableCopy;
    }
    return _dataMap;
}

@end
