//
//  JHTableView.m
//  JHListView
//
//  Created by HaoCold on 2020/3/2.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "JHTableView.h"

@implementation JHTableViewConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellClass = [UITableViewCell class];
    }
    return self;
}
@end

@interface JHTableView()
@property (nonatomic,  strong) JHTableViewConfig *config;
@property (nonatomic,  assign) BOOL  hasLoadData;
@end

@implementation JHTableView

#pragma mark -------------------------------------视图-------------------------------------------

- (instancetype)initWithFrame:(CGRect)frame config:(JHTableViewConfig *)config
{
    self = [super initWithFrame:frame];
    if (self) {
        _config = config;
        _dataArray = @[].mutableCopy;
        
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    [self addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    
    // 下拉
    if (_config.headerRefresh) {
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf beginRefresh:YES];
        }];
    }

    // 上拉
    if (_config.footerRefresh) {
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf beginRefresh:NO];
        }];
    }
}

#pragma mark -------------------------------------事件-------------------------------------------

#pragma mark - public

#pragma mark --- 首次加载数据，只加载一次
- (void)loadData
{
    if (!_hasLoadData) {
        _hasLoadData = YES;
        
        [_tableView.mj_header beginRefreshing];
    }
}

- (void)refreshData
{
    [_tableView.mj_header beginRefreshing];
}

- (NSDictionary *)prepareForRefresh:(BOOL)isPullDown{
    return @{};
}

- (void)beginRefresh:(BOOL)isPullDown
{
    // 子类实现
}

- (void)endRefresh:(BOOL)isPullDown count:(NSInteger)count
{
    if (isPullDown) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }else{
        [_tableView.mj_footer endRefreshing];
    }
    
    if (count == 0) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark --- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = _dataArray[indexPath.row];
    NSString *key = NSStringFromClass([model class]);
    NSString *ID = _config.modelCellPair[key];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessibilityIdentifier = _config.identity;
    if ([cell respondsToSelector:NSSelectorFromString(@"setModel:")]) {
        [cell setValue:model forKey:@"model"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -------------------------------------懒加载-----------------------------------------

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:0];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.backgroundColor = [UIColor whiteColor];
        _tableView = tableView;
        
        if (_config.rowHeight > 0) {
            _tableView.rowHeight = _config.rowHeight;
        }
        if (_config.sectionHeaderHeight > 0) {
            _tableView.sectionHeaderHeight = _config.sectionHeaderHeight;
        }
        if (_config.sectionFooterHeight > 0) {
            _tableView.sectionFooterHeight = _config.sectionFooterHeight;
        }
        
        NSMutableDictionary *mdic = @{}.mutableCopy;
        if (_config.modelCells.count) {
            for (JHModelCellConfig *mcc in _config.modelCells) {
                NSString *ID = NSStringFromClass(mcc.cellClass);
                if (mcc.cellIsNib) {
                    [tableView registerNib:[UINib nibWithNibName:ID bundle:nil] forCellReuseIdentifier:ID];
                }else{
                    [tableView registerClass:mcc.cellClass forCellReuseIdentifier:ID];
                }
                
                NSString *key = NSStringFromClass(mcc.modelClass);
                NSString *val = NSStringFromClass(mcc.cellClass);
                [mdic setValue:val forKey:key];
            }
            
            _config.modelCellPair = mdic;
        }else{
            NSString *ID = NSStringFromClass(_config.cellClass);
            if (_config.cellIsNib) {
                [tableView registerNib:[UINib nibWithNibName:ID bundle:nil] forCellReuseIdentifier:ID];
            }else{
                [tableView registerClass:_config.cellClass forCellReuseIdentifier:ID];
            }
            
            NSString *key = NSStringFromClass(_config.modelClass);
            [mdic setValue:ID forKey:key];
            
            _config.modelCellPair = mdic;
        }
    }
    return _tableView;
}

@end
