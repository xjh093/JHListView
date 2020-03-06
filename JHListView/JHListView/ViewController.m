//
//  ViewController.m
//  JHListView
//
//  Created by HaoCold on 2020/3/2.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "ViewController.h"
#import "CustomListView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
        简单地封装了 UITableView 与 UICollectionView
        可以：
            1.减少控制器代码。
            2.避免写重复的代码。继承`JHTableView`，`UICollectionView`并重写几个方法即可。
    */
    
    self.navigationItem.title = @"JHListView";
    self.navigationController.navigationBar.translucent = NO;
    [self setupSubView];
}

- (void)setupSubView
{
    
    JHTableViewConfig *config = [[JHTableViewConfig alloc] init];
    config.ctrl = self;
    
    CustomListView *listView = [[CustomListView alloc] initWithFrame:self.view.bounds config:config];
    [self.view addSubview:listView];
}

@end
