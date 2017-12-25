//
//  TestClass.h
//  weak_strong
//
//  Created by rong on 2017/12/25.
//  Copyright © 2017年 zcr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYObject.h"
@interface TestClass : NSObject
@property(nonatomic,copy)void (^myBlock)(void);
@property(nonatomic,strong)MYObject* myobject;

- (void)test_dealloc_0;
- (void)test_dealloc_1;
- (void)test_dealloc_2;
- (void)test_dealloc_3;
- (void)test_dealloc_4;
- (void)test_dealloc_5;
- (void)test_dealloc_6;

- (void)doSlow1;
- (void)doSlow2;
@end
