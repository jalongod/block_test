//
//  TestClass.m
//  weak_strong
//
//  Created by rong on 2017/12/25.
//  Copyright © 2017年 zcr. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass

- (void)doSomething{
    NSLog(@"======do some thing ");
}


-(void)dealloc{
    NSLog(@"TestClass dealloc");
}
/**
 测试weak和strong的使用，内存原理
 结论：
 __weak 修饰后的变量相当于assign, 地址相同 retaincount不变  __weak 声明了一个可以自动 nil 化的弱引用。
 __strong 修饰后的变量相当于strong，地址相同 retaincount++
 
 block中的
 **/

- (void)test_dealloc_0{
    //不会循环引用
    __weak typeof(self) weakSelf = self;
    self.myBlock = ^{
        [weakSelf doSomething];
    };
}

- (void)test_dealloc_1{
    //会循环引用
    __weak typeof(self) weakSelf = self;
    self.myBlock = ^{
        [weakSelf doSomething];
    };
}
- (void)test_dealloc_2{
    //不会循环引用
    __weak typeof(self) weakSelf = self;
    self.myBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf doSomething];
    };
}
- (void)test_dealloc_3{
    //会循环引用
    //虽然没有写上self,但是block还是会通过_myobject找到self 囧
    self.myBlock = ^{
        [_myobject doSomething];
    };
}
- (void)test_dealloc_4{
    //不会循环引用
    __weak typeof(MYObject *) weakObject = self.myobject;
    self.myBlock = ^{
        [weakObject doSomething];
    };
}
- (void)test_dealloc_5{
    //会循环引用
    __weak typeof(MYObject *) weakObject = self.myobject;
    self.myBlock = ^{
        [weakObject doSomething];
        [self doSomething];
    };
    self.myBlock();
}

- (void)test_dealloc_6{
    //不会循环引用 !!!
    //block会且仅会对self引用一次
    __weak typeof(self) weakSelf = self;
    self.myBlock = ^{
        [weakSelf.myobject doSomething];
        [weakSelf doSomething];
    };
    self.myBlock();
}

/*
 如果用self持久化的block
 那么不论用weak还是strong,self都不会立即销毁,而是等block执行完毕
 */
- (void)doSlow1{
    __weak typeof(self) weakSelf = self;
    _myBlock  = ^{
//        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"slow thing start %i",[NSThread isMainThread]);
        sleep(1);
        [weakSelf doSomething];
//        [strongSelf doSomething];
        sleep(1);
        [weakSelf doSomething];
//        [strongSelf doSomething];
//        [self doSomething];
        NSLog(@"slow thing end %i",[NSThread isMainThread]);
    };
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _myBlock();
    });
    NSLog(@"do slow");
}

//weak    self会立即销毁,block会执行,但是self已经为nil了
//strong    self不会立即销毁,而是等待block执行完毕
- (void)doSlow2{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"slow thing start %i",[NSThread isMainThread]);
        sleep(1);
                [weakSelf doSomething];
//        [strongSelf doSomething];
        sleep(1);
                [weakSelf doSomething];
//        [strongSelf doSomething];
        //        [self doSomething];
        NSLog(@"slow thing end %i",[NSThread isMainThread]);
    });
    NSLog(@"do slow");

}

@end
