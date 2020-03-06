//
//  JHCollectionView.m
//  JHListView
//
//  Created by HaoCold on 2020/3/5.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "JHCollectionView.h"
#import "MJRefresh.h"

@implementation JHCollectionViewConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        
        self.cellClass = [UICollectionViewCell class];
    }
    return self;
}
@end

@interface JHCollectionView()
@property (nonatomic,  strong) JHCollectionViewConfig *config;
@property (nonatomic,  assign) BOOL  hasLoadData;
@end

@implementation JHCollectionView

#pragma mark -------------------------------------视图-------------------------------------------

- (instancetype)initWithFrame:(CGRect)frame config:(JHCollectionViewConfig *)config
{
    if (self = [super initWithFrame:frame]) {
        _config = config;
        _dataArray = @[].mutableCopy;
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    [self addSubview:self.collectionView];
    
    __weak typeof(self) weakSelf = self;
    
    // 下拉
    if (_config.headerRefresh) {
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf beginRefresh:YES];
        }];
    }

    // 上拉
    if (_config.footerRefresh) {
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
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
        
        [_collectionView.mj_header beginRefreshing];
    }
}

- (void)refreshData
{
    [_collectionView.mj_header beginRefreshing];
}

- (void)beginRefresh:(BOOL)isPullDown
{
    // 子类实现
}

- (void)endRefresh:(BOOL)isPullDown count:(NSInteger)count
{
    if (isPullDown) {
        [_collectionView.mj_header endRefreshing];
    }else{
        [_collectionView.mj_footer endRefreshing];
    }
    
    if (count == 0) {
        [_collectionView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ID = NSStringFromClass(_config.cellClass);
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.accessibilityIdentifier = _config.identity;
    if (_config.modelClass) {
        [cell setValue:_dataArray[indexPath.row] forKey:@"model"];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark -------------------------------------懒加载-----------------------------------------

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = _config.layout;
        if (!layout) {
            layout = [[UICollectionViewFlowLayout alloc] init];
        }
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        NSString *ID = NSStringFromClass(_config.cellClass);
        if (_config.cellIsNib) {
            [collectionView registerNib:[UINib nibWithNibName:ID bundle:nil] forCellWithReuseIdentifier:ID];
        }else{
            [collectionView registerClass:_config.cellClass forCellWithReuseIdentifier:ID];
        }
        
        _collectionView = collectionView;
    }
    return _collectionView;
}

@end
