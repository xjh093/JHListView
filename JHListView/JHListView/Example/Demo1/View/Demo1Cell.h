//
//  Demo1Cell.h
//  JHListView
//
//  Created by HaoCold on 2020/3/3.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Demo1Model;

NS_ASSUME_NONNULL_BEGIN

@interface Demo1Cell : UITableViewCell

// 基类是调用 setValue:forKey: 来给 Cell 赋值的，所以要声明为 model 
@property (nonatomic,  strong) Demo1Model *model;

@end

NS_ASSUME_NONNULL_END
