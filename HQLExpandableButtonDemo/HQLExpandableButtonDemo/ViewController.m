//
//  ViewController.m
//  HQLExpandableButtonDemo
//
//  Created by 何启亮 on 16/9/2.
//  Copyright © 2016年 HQL. All rights reserved.
//

#import "ViewController.h"
#import "HQLExpandableButton.h"

@interface ViewController ()

@property (strong, nonatomic) HQLExpandableButton*button;

@property (assign, nonatomic) BOOL animated;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button = [[HQLExpandableButton alloc] initWithFrame:CGRectMake(100, 100, 30, 30) scrollDirection:scrollDirectionleft];
    self.button.backgroundColor = [UIColor yellowColor];
    self.button.layer.cornerRadius = 15;
    self.button.layer.masksToBounds = YES;
    self.button.layer.borderColor = [UIColor redColor].CGColor;
    self.button.layer.borderWidth = 1;
    [self.view addSubview:self.button];
    
    self.button.isHideWhenClickInFistTimes = NO;
    
    for (int i = 0; i < 3; i++) {
        HQlExpandableButtonAction *action = [[HQlExpandableButtonAction alloc] initWithTitle:[NSString stringWithFormat:@"%d",i] image:nil buttonClick:^(UIButton *btn) {
            NSLog(@"点击了%d",i);
        }];
        [self.button addAction:action];
    }
    
    _animated = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _animated = !_animated;
    if (_animated) {
        NSLog(@"%@",NSStringFromCGRect(self.button.frame));
        [self.button showAnimate:nil completion:nil];
    } else {
        NSLog(@"%@",NSStringFromCGRect(self.button.frame));
        [self.button hideAnimate:nil completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
