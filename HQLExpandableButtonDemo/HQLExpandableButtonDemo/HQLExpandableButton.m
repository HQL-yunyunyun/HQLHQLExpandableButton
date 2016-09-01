//
//  HQLExpandableButton.m
//  HQLExpandableButtonDemo
//
//  Created by 何启亮 on 16/9/2.
//  Copyright © 2016年 HQL. All rights reserved.
//

#import "HQLExpandableButton.h"

@implementation HQLExpandableButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


@implementation HQlExpandableButtonAction

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image buttonClick:(buttonClick)buttonClick {
    if (self = [super init]) {
        self.buttonTitle = title;
        self.buttonImage = image;
        self.buttonClick = buttonClick;
    }
    return self;
}

@end