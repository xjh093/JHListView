//
//  Demo2ListView.m
//  JHListView
//
//  Created by HaoCold on 2020/3/5.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "Demo2ListView.h"
#import "YYModel.h"

@implementation Demo2ListViewConfig

@end

@interface Demo2ListView()
@property (nonatomic,  assign) NSInteger  page;

@property (nonatomic,  strong) UIView *customBannerView;
@end

@implementation Demo2ListView

- (instancetype)initWithFrame:(CGRect)frame config:(__kindof JHTableViewConfig *)config
{
    self = [super initWithFrame:frame config:config];
    if (self) {
        self.lvconfig = config;
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.tableHeaderView = self.customBannerView;
    }
    return self;
}

#pragma mark --- JHListViewProtocol

- (void)beginRefresh:(BOOL)isPullDown
{
    [self request:isPullDown];
}

#pragma mark --- private

- (void)request:(BOOL)isPullDown
{
    if (isPullDown) {
        _page = 1;
    }else{
        _page++;
    }
    
    // 一些参数
    NSMutableDictionary *mdic = @{}.mutableCopy;
    [mdic setValue:@(_page) forKey:@"page"];
    [mdic setValue:@(1) forKey:@"xxx"];
    
    //
    __unused NSString *url = self.config.url;
    NSDictionary *dic = self.config.urlParam;
    [mdic addEntriesFromDictionary:dic];
    
    // 使用 url, dic 发起请求
    // 模拟请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *json = @[@{@"text":@"111"},@{@"text":@"222"},@{@"text":@"333"},@{@"text":@"444"},@{@"text":@"555"}];
        NSArray *array = [NSArray yy_modelArrayWithClass:self.config.modelClass json:json];
        
        if (isPullDown) {
            self.dataArray.array = array;
        }else{
            [self.dataArray addObjectsFromArray:array];
        }
        
        [self.tableView reloadData];
        
        // 结束刷新
        [self endRefresh:isPullDown count:array.count];
    });
    
    // 使用 bannerID 请求轮播图等
    NSInteger bannerID = self.lvconfig.bannerID;
    __unused NSDictionary *dict = @{@"bid":@(bannerID)};
    
    
}

#pragma mark --- lazy

- (UIView *)customBannerView{
    if (!_customBannerView) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 200);
        view.backgroundColor = [UIColor clearColor];
        _customBannerView = view;
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = view.bounds;
        label.text = @"这里显示轮播图";
        label.backgroundColor = [UIColor lightGrayColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:19];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
    }
    return _customBannerView;
}

@end
