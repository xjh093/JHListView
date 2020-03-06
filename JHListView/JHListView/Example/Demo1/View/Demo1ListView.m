//
//  Demo1ListView.m
//  JHListView
//
//  Created by HaoCold on 2020/3/3.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "Demo1ListView.h"
#import "YYModel.h"

@interface Demo1ListView()
@property (nonatomic,  assign) NSInteger  page;
@end

@implementation Demo1ListView

- (instancetype)initWithFrame:(CGRect)frame config:(JHTableViewConfig *)config
{
    self = [super initWithFrame:frame config:config];
    if (self) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
        
        NSArray *json = @[@{@"text":@"1"},@{@"text":@"2"},@{@"text":@"3"},@{@"text":@"4"},@{@"text":@"5"}];
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
}

@end
