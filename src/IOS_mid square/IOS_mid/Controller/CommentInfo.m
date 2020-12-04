//
//  CommentInfo.m
//  IOS_mid
//
//  Created by 车春江 on 2020/12/3.
//  Copyright © 2020 车春江. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentInfo.h"

@implementation CommentInfo

- (CommentInfo*)initWithFrom:(NSString*)from To:(NSString*)to Content:(NSString*)content ID:(NSString*)id{
    
    if(self=[super init]){
        self.from = from;
        self.to = to;
        self.content = content;
        self.comment_id = id;
    }
    
    return self;
}

@end
