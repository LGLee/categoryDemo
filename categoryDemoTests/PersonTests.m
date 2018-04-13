//
//  PersonTests.m
//  categoryDemoTests
//
//  Created by lingo on 2018/4/13.
//  Copyright © 2018年 lingo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Person.h"
@interface PersonTests : XCTestCase
/** <#注释#> */
@property (nonatomic, strong) Person  *p;
@end

@implementation PersonTests

- (void)setUp {
    [super setUp];
    self.p = [Person new];
}

- (void)tearDown {
    self.p = nil;
    [super tearDown];
}

- (void)testExample {
    
    [Person commonClsMethod];
    
    //[self.p commonInstanceMethod];
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
