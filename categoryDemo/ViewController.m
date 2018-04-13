//
//  ViewController.m
//  categoryDemo
//
//  Created by lingo on 2018/4/7.
//  Copyright © 2018年 lingo. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Person+A.h"
#import "Son.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // [Person commonClsMethod];
    //[[Person new] commonInstanceMethod];
    
    [[Son new] commonInstanceMethod];
    
}
@end
