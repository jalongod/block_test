//
//  Test1.m
//  weak_strong
//
//  Created by rong on 2017/12/25.
//  Copyright © 2017年 zcr. All rights reserved.
//

#import "Test1.h"

@implementation Test1
-(void)dealloc{
    NSLog(@"test1 dealloc ");
}
-(void)test2{
    TestClass *test = [TestClass new];
//    [test doSlow1];
    [test doSlow2];
    test = nil;
}
@end
