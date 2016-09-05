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

@property (nonatomic, strong) NSMutableArray <buttonClick>*buttonClickArray;

@property (nonatomic, assign) CGRect originFrame;

@property (assign, nonatomic) BOOL isExpand;

@end

#define kSelfHeight self.frame.size.height
#define kSelfWidth self.frame.size.width
#define kSelfX self.frame.origin.x
#define kSelfY self.frame.origin.y
#define kButtonTagConst 8820

@implementation HQLExpandableButton

- (instancetype)initWithFrame:(CGRect)frame scrollDirection:(scrollDirection)direction {
    if (self = [super initWithFrame:frame]) {
        self.originFrame = frame;
        self.diretion = direction;
        self.duringTime = 0.3;
    }
    return self;
}

- (void)addAction:(HQlExpandableButtonAction *)action {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kSelfWidth, kSelfHeight)];
    [button setTitle:action.buttonTitle forState:UIControlStateNormal];
    [button setImage:action.buttonImage forState:UIControlStateNormal];
    [self addButton:button buttonClick:action.buttonClick];
}

- (void)addButton:(UIButton *)button buttonClick:(buttonClick)buttonClick {
    [self.buttonArray addObject:button];
    [self addSubview:button];
    [button setTag:(kButtonTagConst + self.buttonArray.count - 1)];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.alpha = self.buttonArray.count == 1 ? 1 : 0;
    _subButtons = self.buttonArray.copy;
    
    if (!buttonClick) {
        buttonClick = ^(UIButton *btn) {};
    }
    [self.buttonClickArray addObject:buttonClick];
}

- (void)buttonClick:(UIButton *)btn {
    if (_isHideWhenClickInFistTimes) {
        __weak typeof(self) weakSelf = self;
        if (_isExpand) {
            [self hideAnimate:^{
                CGRect btnF = btn.frame;
                btnF.origin = CGPointZero;
                btn.frame = btnF;
                for (UIButton *button in weakSelf.buttonArray) {
                    if (button == btn) continue;
                    button.alpha = 0;
                }
            } completion:^{
                
            }];
        } else {
            [self showAnimate:^{
                
            } completion:^{
                
            }];
        }
    }
    NSInteger tag = btn.tag;
    buttonClick buttonClick = self.buttonClickArray[tag - kButtonTagConst];
    buttonClick(btn);
}

- (void)showAnimate:(void(^)())animate completion:(void(^)())completion {
    _isExpand = YES;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:weakSelf.duringTime animations:^{
        weakSelf.frame = [weakSelf getAnimateFrame];
        for (UIButton *button in weakSelf.buttonArray) {
            button.alpha = 1;
        }
        if (animate) {
            animate();
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)hideAnimate:(void(^)())animate completion:(void(^)())completion {
    _isExpand = NO;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:weakSelf.duringTime animations:^{
        weakSelf.frame = weakSelf.originFrame;
        if (animate) {
            animate();
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (CGRect)getAnimateFrame {
    CGRect targetFrame = CGRectZero;
    CGFloat targetWidht = kSelfWidth * self.buttonArray.count;
    CGFloat targetHeight = kSelfHeight * self.buttonArray.count;
    switch (self.diretion) {
        case scrollDirectionUP:
            targetFrame = CGRectMake(kSelfX, kSelfY - targetHeight + kSelfHeight, kSelfWidth, targetHeight);
            for (NSInteger i = self.buttonArray.count - 1; i >= 0 ; i--) {
                UIButton *button = self.buttonArray[i];
                UIButton *preButton = nil;
                if (i != self.buttonArray.count - 1) {
                    preButton = self.buttonArray[i + 1];
                }
                CGFloat buttonY = CGRectGetMaxY(preButton.frame);
                
                CGRect buttonF = button.frame;
                buttonF.origin.y = buttonY;
                button.frame = buttonF;
            }
            break;
        case scrollDirectionRight:
            targetFrame = CGRectMake(kSelfX, kSelfY, targetWidht, kSelfHeight);
            for (NSInteger i = 0; i < self.buttonArray.count; i++) {
                UIButton *button = self.buttonArray[i];
                UIButton *preButton = nil;
                if (i != 0) {
                    preButton = self.buttonArray[i - 1];
                }
                CGFloat buttonX = CGRectGetMaxX(preButton.frame);
                
                CGRect buttonF = button.frame;
                buttonF.origin.x = buttonX;
                button.frame = buttonF;
            }
            break;
        case scrollDirectionDown:
            targetFrame = CGRectMake(kSelfX, kSelfY, kSelfWidth, targetHeight);
            for (NSInteger i = 0; i < self.buttonArray.count; i++) {
                UIButton *button = self.buttonArray[i];
                UIButton *preButton = nil;
                if (i != 0) {
                    preButton = self.buttonArray[i - 1];
                }
                CGFloat buttonY = CGRectGetMaxY(preButton.frame);
                CGRect buttonF = button.frame;
                buttonF.origin.y = buttonY;
                button.frame = buttonF;
            }
            break;
        case scrollDirectionleft:
            targetFrame = CGRectMake(kSelfX - targetWidht + kSelfWidth, kSelfY, targetWidht, kSelfHeight);
            for (NSInteger i = self.buttonArray.count - 1; i >= 0 ; i--) {
                UIButton *button = self.buttonArray[i];
                UIButton *preButton = nil;
                if (i != self.buttonArray.count - 1) {
                    preButton = self.buttonArray[i + 1];
                }
                CGFloat buttonX = CGRectGetMaxX(preButton.frame);
                
                CGRect buttonF = button.frame;
                buttonF.origin.x = buttonX;
                button.frame = buttonF;
            }
            break;
        default:
            targetFrame = CGRectZero;
            break;
    }
    return targetFrame;
}

- (NSMutableArray<UIButton *> *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (NSMutableArray <buttonClick> *)buttonClickArray {
    if (!_buttonClickArray) {
        _buttonClickArray = [NSMutableArray array];
    }
    return _buttonClickArray;
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