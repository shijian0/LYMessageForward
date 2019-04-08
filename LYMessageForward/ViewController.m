//
//  ViewController.m
//  LYMessageForward
//
//  Created by LiYong on 2019/4/8.
//  Copyright © 2019 勇 李. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/message.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    Person * pe = [[Person alloc]init];
    Person * pe = objc_msgSend(objc_getClass("Person"), sel_registerName("alloc"));
    pe = objc_msgSend([Person alloc], sel_registerName("init"));
//    [pe eat];
    [pe performSelector:@selector(eat:)withObject:@"鸡腿"];
//    objc_msgSend(pe, sel_registerName("eat"));
    // Do any additional setup after loading the view.
}


@end
