//
//  Demo2Ctrl.m
//  JHListView
//
//  Created by HaoCold on 2020/3/5.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "Demo2Ctrl.h"
#import "Demo2ListView.h"
#import "Demo2Cell.h"
#import "Demo2Model.h"

@interface Demo2Ctrl ()
@property (nonatomic,  strong) Demo2ListView *listView;
@end

@implementation Demo2Ctrl

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

- (Demo2ListView *)listView{
    if (!_listView) {
        _listView = [[Demo2ListView alloc] initWithFrame:self.view.bounds config:({
            Demo2ListViewConfig *config = [[Demo2ListViewConfig alloc] init];
            
            config.identity = @"Demo2";
            config.rowHeight = 50;
            config.cellClass = [Demo2Cell class];
            config.modelClass = [Demo2Model class];
            config.headerRefresh = YES;
            config.footerRefresh = YES;
            config.url = @"api/home/list";
            config.urlParam = @{@"type":@"1"};
            config.ctrl = self;
            
            config.bannerID = 100;
            
            config;
        })];
        _listView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    }
    return _listView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
