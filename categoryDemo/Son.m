//
//  Son.m
//  categoryDemo
//
//  Created by lingo on 2018/4/13.
//  Copyright © 2018年 lingo. All rights reserved.
//

#import "Son.h"

@implementation Son
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
