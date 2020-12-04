//
//  ContentInfo+_.m
//  IOS_mid
//
//  Created by jinshlin on 2020/11/28.
//  Copyright © 2020 车春江. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ContentResponse.h"

@implementation ContentResponse

@synthesize info = _info;

-(id)init{
    if(self = [super init]){
        self.info = [NSMutableDictionary dictionary];
    }
    return self;
}

+(instancetype)singleInstance{
    static ContentResponse *myInstance = nil;
    if(myInstance == nil){
        myInstance = [[ContentResponse alloc]init];
    }
    return myInstance;
}

@end
