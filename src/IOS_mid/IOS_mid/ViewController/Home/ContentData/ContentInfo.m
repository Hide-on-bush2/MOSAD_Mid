//
//  ContentInfo+_.m
//  IOS_mid
//
//  Created by jinshlin on 2020/12/3.
//  Copyright © 2020 车春江. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ContentInfo.h"

@implementation ContentInfo

@synthesize info = _info;

-(id)init{
    if(self = [super init]){
        self.info = [NSMutableDictionary dictionary];
    }
    return self;
}

+(instancetype)singleInstance{
    static ContentInfo *myInstance = nil;
    if(myInstance == nil){
        myInstance = [[ContentInfo alloc]init];
    }
    return myInstance;
}

@end
