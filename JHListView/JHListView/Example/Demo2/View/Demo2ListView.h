//
//  Demo2ListView.h
//  JHListView
//
//  Created by HaoCold on 2020/3/5.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "JHTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface Demo2ListViewConfig : JHTableViewConfig

/// 轮播图，请求参数
@property (nonatomic,  assign) NSInteger  bannerID;

@end

@interface Demo2ListView : JHTableView

@property (nonatomic,  strong) Demo2ListViewConfig *lvconfig;

@end

NS_ASSUME_NONNULL_END
