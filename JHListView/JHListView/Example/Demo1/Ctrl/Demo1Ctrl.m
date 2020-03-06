//
//  Demo1Ctrl.m
//  JHListView
//
//  Created by HaoCold on 2020/3/3.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "Demo1Ctrl.h"
#import "Demo1ListView.h"
#import "Demo1Cell.h"
#import "Demo1Model.h"

@interface Demo1Ctrl ()
@property (nonatomic,  strong) Demo1ListView *listView;
@end

@implementation Demo1Ctrl

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

- (Demo1ListView *)listView{
    if (!_listView) {
        _listView = [[Demo1ListView alloc] initWithFrame:self.view.bounds config:({
            JHTableViewConfig *config = [[JHTableViewConfig alloc] init];
            
            config.identity = @"Demo1";
            config.rowHeight = 50;
            config.cellClass = [Demo1Cell class];
            config.modelClass = [Demo1Model class];
            config.headerRefresh = YES;
            config.footerRefresh = YES;
            config.url = @"api/home/list";
            config.urlParam = @{@"type":@"1"};
            config.ctrl = self;
            
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
