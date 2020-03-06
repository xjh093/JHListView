//
//  JHCollectionView.h
//  JHListView
//
//  Created by HaoCold on 2020/3/5.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHListViewConfig.h"
#import "JHListViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface JHCollectionViewConfig : JHListViewConfig
@property (nonatomic,  strong) UICollectionViewFlowLayout *layout;  // 布局配置
@end

@interface JHCollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,JHListViewProtocol>

@property (nonatomic,  strong) UICollectionView *collectionView;
@property (nonatomic,  strong) NSMutableArray *dataArray;

@property (nonatomic,  strong,  readonly) JHCollectionViewConfig *config;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame config:(__kindof JHCollectionViewConfig *)config NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
