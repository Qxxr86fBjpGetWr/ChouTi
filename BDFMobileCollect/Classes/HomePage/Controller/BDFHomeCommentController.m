//
//  BDFHomeCommentController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/28.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFHomeCommentController.h"
#import "BDFHomeHotNewsCell.h"
#import "BDFHomeCommentsCell.h"
#import "BDFHomeHotNewsUpsRequest.h"
#import "BDFHomeCommentIndexModel.h"
#import "BDFHomeHotNewsAddRequest.h"
#import "BDFHomeCommenntsModel.h"
#import "BDFCommentFrameModel.h"
#import "BDFHomeCommPoint.h"
#import "BDFKeyBoardToolView.h"
#import "UIView+Frame.h"
#import "UIVisualEffectView+Addition.h"
#import "UIView+Tap.h"

@interface BDFHomeCommentController ()<BDFHomeHotNewsCellButtonDelegate>

@property (nonatomic,strong) NSMutableArray <BDFCommentFrameModel *>*commentsArray;

@property (strong,nonatomic) NSMutableArray *points;

@property (strong,nonatomic) NSMutableArray *allPoints;

@property (nonatomic, weak) BDFKeyBoardToolView *toolView;

@property (nonatomic, weak) UIVisualEffectView *blurView;

@end

@implementation BDFHomeCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needCellSepLine = NO;
    
    self.blurView.alpha = 0.7;
    _points = [NSMutableArray array];
    _allPoints = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(keyboardWillHide:)
        name:UIKeyboardWillHideNotification object:nil];
    [self loadData];
}

-(void)loadData {
    [super loadData];
    
    BDFHomeHotNewsUpsRequest *indexRequest = [BDFHomeHotNewsUpsRequest bdf_requestWithUrl:BDFHOMEPAGEHOTNNEWSCOMMENTINDEX isPost:YES];
    indexRequest.link_id = _cellFrame.hotNewsModel.id;
    [indexRequest bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        
        BDFHomeCommentIndexModel *model =
        [BDFHomeCommentIndexModel modelWithDictionary:response];
        
        NSString *tempString = [model.comments.ids componentsJoinedByString:@","];
        NSArray *tempArray = [tempString componentsSeparatedByString:@","];
        self.allPoints = [NSMutableArray arrayWithArray:tempArray];
        
        [self removeChildComment:tempArray.mutableCopy tree:model.comments.depthMap];
        
        [self allCommentsSortWithArray:self.allPoints treeMap:model.comments.treeMap idString:nil];
        
        BDFHomeHotNewsAddRequest *commentsRequest = [BDFHomeHotNewsAddRequest bdf_requestWithUrl:BDFHOMEPAGEHOTNNEWSCOMMENT isPost:NO];
        commentsRequest.ids = [self.points componentsJoinedByString:@","];
        [commentsRequest bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
            BDFHomeCommenntsModel *commentModel = [[BDFHomeCommenntsModel alloc] init];
            commentModel.commentsArray = [BDFHomeCommenntModel modelArrayWithDictArray:response];
            
            for (BDFHomeCommenntModel *obj in commentModel.commentsArray) {
                BDFCommentFrameModel *commentFraModel = [[BDFCommentFrameModel alloc] init];
                NSString *deep = model.comments.depthMap[[NSString stringWithFormat:@"%ld",obj.id]];
                commentFraModel.deep = [deep integerValue];
                commentFraModel.commentModel = obj;
                [self.commentsArray addObject:commentFraModel];
            }
            [self bdf_reloadData];
        }];
    }];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolView.transform = CGAffineTransformMakeTranslation(0, - CGRectGetHeight(keyboardRect) - _toolView.height - SCREEN_StatusBarAndNavBarHeight);
        
        self.blurView.hidden = NO;
        [self.view insertSubview:self.blurView belowSubview:self.toolView];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
//    [self.view sendSubviewToBack:self.blurView];
//    self.toolView.transform = CGAffineTransformIdentity;
//    [self.blurView removeFromSuperview];
    [self endEdit];
}

- (void)removeChildComment:(NSMutableArray *)allComment tree:(NSDictionary *)treeMap {
    for (int i = 0; i < allComment.count; i ++) {
        NSString *string = [NSString stringWithFormat:@"%@",allComment[i]];
        NSInteger deep = [treeMap[string] integerValue];
        if (deep != 0) {
            [self.allPoints removeObject:string];
        }
    }
}

- (void)allCommentsSortWithArray:(NSArray *)parentArray treeMap:(NSDictionary *)map idString:(NSString *)string{
    
    for (int i = 0; i < parentArray.count; i ++) {
        NSString *obj = [NSString stringWithFormat:@"%@",parentArray[i]];
        [self.points addObject:obj];
        
        NSArray *childArray = map[obj];
        if (!childArray) {
            continue;
        }
        [self allCommentsSortWithArray:childArray treeMap:map idString:nil];
    }
}

#pragma mark - endEdit
- (void)endEdit {
    self.toolView.transform = CGAffineTransformIdentity;
    [self.blurView setHidden:YES];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)bdf_numberOfSections {
    return 2;
}

-(NSInteger)bdf_numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return self.commentsArray.count;
    }
}

-(BDFBaseTableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
         BDFBaseTableViewCell *cell = [BDFHomeHotNewsCell cellWithTableView:self.tableView];
        [cell setValue:_cellFrame forKey:@"newsFrame"];
        return cell;
    }else {
        BDFHomeCommentsCell *cell = [BDFHomeCommentsCell cellWithTableView:self.tableView];
        cell.commentFrameModel = self.commentsArray[indexPath.row];
        return cell;
    }
}

-(void)bdf_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BDFBaseTableViewCell *)cell {
    if (indexPath.section == 1) {
        [self.toolView.textView becomeFirstResponder];
    }
}

- (CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGRectGetMaxY(self.cellFrame.shareButtomF);
    }else {
         BDFCommentFrameModel *commentFrameModel = self.commentsArray[indexPath.row];
        return CGRectGetMaxY(commentFrameModel.contentF);
    }
}

-(NSMutableArray<BDFCommentFrameModel *> *)commentsArray {
    if (!_commentsArray) {
        _commentsArray = [NSMutableArray array];
    }
    return _commentsArray;
}

- (BDFKeyBoardToolView *)toolView {
    if (!_toolView) {
        BDFKeyBoardToolView *view = [[BDFKeyBoardToolView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 100)];
        [self.view addSubview:view];
        _toolView = view;
    }
    return _toolView;
}

- (UIVisualEffectView *)blurView {
    if (!_blurView) {
        UIVisualEffectView *view = [[UIVisualEffectView alloc] initVisualEffectView];
        view.alpha = 0.7;
//        view.layer.anchorPoint = self.view.center;
        WeakSelf(weakSelf);
        [view setTapActionWithBlock:^{
            [weakSelf endEdit];
        }];
        view.hidden = YES;
        _blurView = view;
        [self.view addSubview:view];
    }
    return _blurView;
}

@end
