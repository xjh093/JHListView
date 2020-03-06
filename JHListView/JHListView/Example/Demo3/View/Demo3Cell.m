//
//  Demo3Cell.m
//  JHListView
//
//  Created by HaoCold on 2020/3/6.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "Demo3Cell.h"
#import "Demo3Model.h"

@interface Demo3Cell()
@property (nonatomic,  strong) UILabel *textLabel;
@end

@implementation Demo3Cell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.textLabel];
    }
    return self;
}

- (void)setModel:(Demo3Model *)model
{
    _model = model;
    
    _textLabel.text = model.text;
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = self.contentView.bounds;
        label.layer.cornerRadius = 5;
        label.layer.borderColor = [UIColor grayColor].CGColor;
        label.layer.borderWidth = 1;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        _textLabel = label;
    }
    return _textLabel;
}

@end
