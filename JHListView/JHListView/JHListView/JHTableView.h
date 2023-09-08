//
//  JHTableView.h
//  JHListView
//
//  Created by HaoCold on 2020/3/2.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHListViewConfig.h"
#import "JHListViewProtocol.h"
#import "MJRefresh.h"

NS_ASSUME_NONNULL_BEGIN

@interface JHTableViewConfig : JHListViewConfig
@property (nonatomic,  assign) CGFloat  rowHeight;                  // 行高
@property (nonatomic,  assign) CGFloat  sectionHeaderHeight;        // 组头高
@property (nonatomic,  assign) CGFloat  sectionFooterHeight;        // 组尾高
@end

@interface JHTableView : UIView<UITableViewDelegate,UITableViewDataSource,JHListViewProtocol>

@property (nonatomic,  strong) UITableView *tableView;
@property (nonatomic,  strong) NSMutableArray *dataArray;

@property (nonatomic,  strong,  readonly) JHTableViewConfig *config;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame config:(__kindof JHTableViewConfig *)config NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
