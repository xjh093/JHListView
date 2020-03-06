//
//  Demo3Ctrl.m
//  JHListView
//
//  Created by HaoCold on 2020/3/6.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "Demo3Ctrl.h"
#import "Demo3ListView.h"
#import "Demo3Cell.h"
#import "Demo3Model.h"

@interface Demo3Ctrl ()
@property (nonatomic,  strong) Demo3ListView *listView;
@end

@implementation Demo3Ctrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Demo1";
    
    [self.view addSubview:self.listView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 首次加载数据
    [_listView loadData];
}

- (Demo3ListView *)listView{
    if (!_listView) {
        _listView = [[Demo3ListView alloc] initWithFrame:self.view.bounds config:({
            JHCollectionViewConfig *config = [[JHCollectionViewConfig alloc] init];
            
            config.identity = @"Demo3";
            config.cellClass = [Demo3Cell class];
            config.modelClass = [Demo3Model class];
            config.headerRefresh = YES;
            config.footerRefresh = YES;
            config.url = @"api/home/list";
            config.urlParam = @{@"type":@"1"};
            config.ctrl = self;
            config.layout = ({
                UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
                CGFloat w = (CGRectGetWidth(self.view.bounds)-30)*0.5;
                layout.itemSize = CGSizeMake(w, w);
                layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
                layout;
            });
            
            config;
        })];
        _listView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    }
    return _listView;
}

@end
