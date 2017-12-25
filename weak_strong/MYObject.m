//
//  MYObject.m
//  weak_strong
//
//  Created by rong on 2017/12/25.
//  Copyright © 2017年 zcr. All rights reserved.
//

#import "MYObject.h"

@implementation MYObject

-(void)doSomething{
    NSLog(@"myobject dosomething" );
}
-(void)slowThing{
    NSLog(@"slow thing start");
    sleep(3);
    NSLog(@"slow thing  end  " );
}
@end
