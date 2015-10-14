//
//  LoginViewControllerTests.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/7/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LoginViewController.h"

@interface LoginViewControllerTests : XCTestCase

@property (nonatomic) LoginViewController *vcToTest;

@end

@implementation LoginViewControllerTests

- (void)setUp {
    [super setUp];
    
    self.vcToTest = [[LoginViewController alloc] init];
}

- (void)testReverseString {

    [self.vcToTest login:self];
    
}
                          
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
