//
//  JHListViewConfig.h
//  JHListView
//
//  Created by HaoCold on 2020/3/5.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHListViewConfig : NSObject
@property (nonatomic,    copy) NSString *identity;                  // 列表界面标识

@property (nonatomic,  strong) Class cellClass;                     // cell
@property (nonatomic,  strong) Class modelClass;                    // model
@property (nonatomic,  assign) BOOL  cellIsNib;                     // cell是否是Xib

@property (nonatomic,  assign) BOOL headerRefresh;                  // 头部刷新
@property (nonatomic,  assign) BOOL footerRefresh;                  // 尾部刷新

@property (nonatomic,    weak) UIViewController *ctrl;              // 控制器

@property (nonatomic,    copy) NSString *url;                       // url
@property (nonatomic,  strong) NSDictionary *urlParam;              // 请求参数
@end

NS_ASSUME_NONNULL_END
