//
//  main.m
//  weak_strong
//
//  Created by rong on 2017/12/7.
//  Copyright © 2017年 zcr. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TLog(prefix,obj) NSLog(@"变量内存地址%p ||变量值%p ||指向对象%@ ||变量:%@ ",&obj,obj,obj,prefix);

@interface MYObject:NSObject
@property(nonatomic,copy)NSString *value;
@end
@implementation MYObject
@end


@interface TestClass:NSObject
@end
@implementation TestClass
/**
 测试weak和strong的使用，内存原理
 结论：
 __weak 修饰后的变量相当于assign, 地址相同 retaincount不变  __weak 声明了一个可以自动 nil 化的弱引用。
 __strong 修饰后的变量相当于strong，地址相同 retaincount++
 
 block中的
 **/
- (void)test1{
    MYObject *obj = [[MYObject alloc]init];
    obj.value = @"MYObject";
    TLog(@"obj", obj);
    __weak typeof(obj) weakObj = obj;
    TLog(@"weakObj" , weakObj);
    
    void(^blockTest)(void) =^(){
        TLog(@"weakObj-block-pre", weakObj);
        __strong typeof(weakObj) strongObj = weakObj;
        TLog(@"weakObj-block-after", weakObj);
        TLog(@"strongObj-block", strongObj);
    };
    TLog(@"weakObj1", weakObj);
    blockTest();
    TLog(@"weakObj2", weakObj);
    obj = nil;
    blockTest();
    TLog(@"weakObj3", weakObj);
}

//测试__strong的用途
- (void)test2{
    MYObject *obj = [[MYObject alloc]init];
    obj.value = @"MYObject";
    TLog(@"obj", obj);
    __weak typeof(obj) weakObj = obj;
    TLog(@"weakObj" , weakObj);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        __strong typeof(weakObj) strongObj = weakObj;
//        TLog(@"weakObj-block-after1", weakObj);
        TLog(@"strongObj-block1", strongObj);
        sleep(3);
//        TLog(@"weakObj-block-after2", weakObj);
        TLog(@"strongObj-block2", strongObj);
    });
    sleep(1);
    obj = nil;
    TLog(@"weakObj2", weakObj);
    sleep(3);
    TLog(@"weakObj3", weakObj);
}

- (void)test3{
    MYObject *obj = [[MYObject alloc]init];
    obj.value = @"my-object-1";
    TLog(@"obj",obj);
    
    __block MYObject *blockObj = obj;
    obj = nil;
    TLog(@"blockObj -1",blockObj);
    
    void(^testBlock)(void) = ^(){
        TLog(@"blockObj - block",blockObj);
        MYObject *obj2 = [[MYObject alloc]init];
        obj2.value = @"my-object-2";
        TLog(@"obj2",obj2);
        blockObj = obj2;
        TLog(@"blockObj - block",blockObj);
    };
    NSLog(@"%@",testBlock);
    TLog(@"blockObj -2",blockObj);
    testBlock();
    TLog(@"blockObj -3",blockObj);
}


@end



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        TestClass *testObj = [TestClass new];
        [testObj test1];
//        [testObj test2];
//        [testObj test3];
    }
    return 0;
}


