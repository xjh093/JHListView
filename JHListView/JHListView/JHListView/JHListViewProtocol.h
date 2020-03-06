//
//  JHListViewProtocol.h
//  JHListView
//
//  Created by HaoCold on 2020/3/2.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#ifndef JHListViewProtocol_h
#define JHListViewProtocol_h

@protocol JHListViewProtocol <NSObject>

/**
 首次加载数据，只加载一次。
 */
- (void)loadData;

/**
 刷新数据。
 */
- (void)refreshData;

/**
 列表开始刷新。
 
 @param isPullDown YES-下拉刷新，NO-上拉刷新。
 */
- (void)beginRefresh:(BOOL)isPullDown;

/**
 列表结束刷新。
 
 @param isPullDown YES-下拉刷新，NO-上拉刷新。
 @param count 本次刷新所获取到的数量。
 */
- (void)endRefresh:(BOOL)isPullDown count:(NSInteger)count;

@end

#endif /* JHListViewProtocol_h */






