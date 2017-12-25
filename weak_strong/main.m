//
//  main.m
//  weak_strong
//
//  Created by rong on 2017/12/7.
//  Copyright © 2017年 zcr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestClass.h"
#import "Test1.h"
#define TLog(prefix,obj) NSLog(@"变量内存地址%p ||变量值%p ||指向对象%@ ||变量:%@",&obj,obj,obj,prefix);
#define RLog(prefix,obj) NSLog(@"变量:%@  retainCount=%@",prefix,[obj valueForKey:@"retainCount"]);

//
///*
// 内存状态
// */
//- (void)test1{
//    MYObject *obj = [[MYObject alloc]init];
//    obj.value = @"MYObject";                        //o1
//    TLog(@"obj", obj);
//    __weak typeof(obj) weakObj = obj;               //o2 对o1进行了浅拷贝
//    TLog(@"weakObj" , weakObj);
//
//    void(^blockTest)(void) =^(){
//        TLog(@"weakObj-block-pre", weakObj);        //o3 对o2进行了浅拷贝
//        __strong typeof(weakObj) strongObj = weakObj;   //04 对o3进行了strong浅拷贝
//        TLog(@"weakObj-block-after", weakObj);
//        TLog(@"strongObj-block", strongObj);
//    };
//    TLog(@"weakObj1", weakObj);
//    blockTest();
//    TLog(@"weakObj2", weakObj);
//    obj = nil;
//    blockTest();
//    TLog(@"weakObj3", weakObj);
//}
//
////正确用法: strongSelf
//- (void)test2{
//    MYObject *obj = [[MYObject alloc]init];
//    obj.value = @"MYObject";
//    TLog(@"obj", obj);
//    __weak typeof(obj) weakObj = obj;
//    TLog(@"weakObj" , weakObj);
//
//    MYObject *obj2 = [[MYObject alloc]init];
//    obj2.value = @"MYObject2";
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        __strong typeof(weakObj) strongObj = weakObj;
////        TLog(@"weakObj-block-after1", weakObj);
//        TLog(@"strongObj-block1", strongObj);
//        sleep(3);
////        TLog(@"weakObj-block-after2", weakObj);
//        TLog(@"strongObj-block2", strongObj);
//    });
//    sleep(1);
//    obj = nil;
//    TLog(@"weakObj2", weakObj);
//    sleep(3);
//    TLog(@"weakObj3", weakObj);
//}
//
//- (void)test3{
//    MYObject *obj = [[MYObject alloc]init];
//    obj.value = @"my-object-1";
//    TLog(@"obj",obj);
//
//    __block MYObject *blockObj = obj;
//    obj = nil;
//    TLog(@"blockObj -1",blockObj);
//
//    void(^testBlock)(void) = ^(){
//        TLog(@"blockObj - block",blockObj);
//        MYObject *obj2 = [[MYObject alloc]init];
//        obj2.value = @"my-object-2";
//        TLog(@"obj2",obj2);
//        blockObj = obj2;
//        TLog(@"blockObj - block",blockObj);
//    };
//    NSLog(@"%@",testBlock);
//    TLog(@"blockObj -2",blockObj);
//    testBlock();
//    TLog(@"blockObj -3",blockObj);
//}
//





int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        TestClass *testObj = [TestClass new];
//        [testObj test_dealloc_0];
//        [testObj test_dealloc_1];
//        [testObj test_dealloc_2];
//        [testObj test_dealloc_3];
//        [testObj test_dealloc_4];
//        [testObj test_dealloc_6];
//        [testObj test_dealloc_6];
//        [testObj test1];
//        [testObj test2];
//        [testObj test3];
        
//        [testObj doSlow];
//        sleep(3);
        
        Test1 *t1 = [Test1 new];
        [t1 test2];
        
    }
    sleep(4);
    return 0;
}


