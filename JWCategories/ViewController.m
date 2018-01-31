//
//  ViewController.m
//  JWCategories
//
//  Created by huangjw on 16/7/23.
//  Copyright © 2016年 huangjw. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Runtime.h"

@interface ViewController ()
{
    NSString *anIvar;
}

@property (nonatomic, strong) NSString *aProperty;
@end

@implementation ViewController

/* 方法替换常用方法
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(viewWillDisappear:) bySwizzledSelector:@selector(sure_viewWillDisappear:)];
    });
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@", [ViewController fetchIvarList]);
    NSLog(@"%@", [ViewController fetchPropertyList]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
