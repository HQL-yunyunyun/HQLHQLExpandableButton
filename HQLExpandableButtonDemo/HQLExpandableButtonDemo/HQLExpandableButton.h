//
//  HQLExpandableButton.h
//  HQLExpandableButtonDemo
//
//  Created by 何启亮 on 16/9/2.
//  Copyright © 2016年 HQL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonClick)(UIButton *);

typedef enum{
    scrollDirectionUP = 0, // 上
    scrollDirectionRight,
    scrollDirectionDown,
    scrollDirectionleft
} scrollDirection;

@class HQlExpandableButtonAction;

@interface HQLExpandableButton : UIView

/**
 *  子button
 */
@property (strong, nonatomic, readonly) NSArray *subButtons;

@property (assign, nonatomic) scrollDirection diretion;

@property (assign, nonatomic) CGFloat duringTime;

// frame 是button的初始frame
- (instancetype)initWithFrame:(CGRect)frame scrollDirection:(scrollDirection)direction;

- (void)addAction:(HQlExpandableButtonAction *)action;

- (void)addButton:(UIButton *)button buttonClick:(buttonClick)buttonClick;

- (void)showAnimate;

- (void)hideAnimate;

@end


@interface HQlExpandableButtonAction : NSObject

@property (copy, nonatomic) NSString *buttonTitle;

@property (strong, nonatomic) UIImage *buttonImage;

@property (copy, nonatomic) buttonClick buttonClick;

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image buttonClick:(buttonClick)buttonClick;

@end