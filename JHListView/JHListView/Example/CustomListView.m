//
//  CustomListView.m
//  JHListView
//
//  Created by HaoCold on 2020/3/2.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "CustomListView.h"

@interface CustomListView()
@property (nonatomic,  assign) NSInteger  page;
@end

@implementation CustomListView

- (instancetype)initWithFrame:(CGRect)frame config:(JHTableViewConfig *)config
{
    self = [super initWithFrame:frame config:config];
    if (self) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.dataArray.array = @[@"Demo1",@"Demo2",@"Demo3"];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *vc = [NSString stringWithFormat:@"Demo%@Ctrl",@(indexPath.row+1)];
    [self.config.ctrl.navigationController pushViewController:[NSClassFromString(vc) new] animated:YES];
}

@end
