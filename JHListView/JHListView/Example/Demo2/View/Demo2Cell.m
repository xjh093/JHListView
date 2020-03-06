//
//  Demo2Cell.m
//  JHListView
//
//  Created by HaoCold on 2020/3/5.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "Demo2Cell.h"
#import "Demo2Model.h"

@implementation Demo2Cell

- (void)setModel:(Demo2Model *)model
{
    _model = model;
    
    self.textLabel.text = model.text;
}

@end
