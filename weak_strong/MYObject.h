//
//  MYObject.h
//  weak_strong
//
//  Created by rong on 2017/12/25.
//  Copyright © 2017年 zcr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYObject : NSObject
@property(nonatomic,copy)NSString *value;
-(void)doSomething;

-(void)slowThing;

@end
