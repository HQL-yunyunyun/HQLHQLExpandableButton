//
//  HQLExpandableButton.m
//  HQLExpandableButtonDemo
//
//  Created by 何启亮 on 16/9/2.
//  Copyright © 2016年 HQL. All rights reserved.
//

#import "HQLExpandableButton.h"

@interface HQLExpandableButton ()

@property (nonatomic, strong) NSMutableArray <UIButton *>*buttonArray;

@property (nonatomic, assign) CGRect originFrame;

@end

#define kSelfHeight self.frame.size.height
#define kSelfWidth self.frame.size.width
#define kSelfX self.frame.origin.x
#define kSelfY self.frame.origin.y

@implementation HQLExpandableButton

- (instancetype)initWithFrame:(CGRect)frame scrollDirection:(scrollDirection)direction {
    if (self = [super initWithFrame:frame]) {
        self.diretion = direction;
    }
    return self;
}

//scrollDirectionUP = 0, // 上
//scrollDirectionRight,
//scrollDirectionDown,
//scrollDirectionleft

- (CGRect)getAnimateFrame {
    CGRect targetFrame = CGRectZero;
    NSInteger buttonCount = self.buttonArray.count;
    switch (self.diretion) {
        case scrollDirectionUP:
            targetFrame = CGRectMake(kSelfX, kSelfY - ((buttonCount - 1) * kSelfHeight), kSelfWidth, buttonCount * kSelfHeight);
            break;
        case scrollDirectionRight:
            targetFrame = CGRectMake(kSelfX, kSelfY, buttonCount * kSelfWidth, kSelfHeight);
            break;
        case scrollDirectionDown:
            targetFrame = CGRectMake(kSelfX, kSelfY, kSelfWidth, buttonCount * kSelfHeight);
            break;
        case scrollDirectionleft:
            targetFrame = CGRectMake(kSelfX + ((buttonCount - 1) * kSelfWidth), kSelfY, buttonCount * kSelfWidth, kSelfHeight);
            break;
        default:
            targetFrame = CGRectZero;  
            break;
    }
    return targetFrame;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.originFrame = frame;
}

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