//
//  Person+A.m
//  categoryDemo
//
//  Created by lingo on 2018/4/7.
//  Copyright © 2018年 lingo. All rights reserved.
//

#import "Person+A.h"

@implementation Person (A)

+ (void)load{
    LGLog();
}

+ (void)initialize{
    LGLog();
}


+ (void)commonClsMethod{
    LGLog();
}

- (void)commonInstanceMethod{
    LGLog();
}
@end
