//
//  Demo1Cell.m
//  JHListView
//
//  Created by HaoCold on 2020/3/3.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "Demo1Cell.h"
#import "Demo1Model.h"

@implementation Demo1Cell

- (void)setModel:(Demo1Model *)model
{
    _model = model;
    
    self.textLabel.text = model.text;
}

@end
