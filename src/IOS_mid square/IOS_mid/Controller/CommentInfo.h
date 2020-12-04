//
//  CommentInfo.h
//  IOS_mid
//
//  Created by 车春江 on 2020/12/3.
//  Copyright © 2020 车春江. All rights reserved.
//

#ifndef CommentInfo_h
#define CommentInfo_h
#import <UIKit/UIKit.h>
@interface CommentInfo:UILabel
@property(nonatomic, strong) NSString* from;
@property(nonatomic, strong) NSString* to;
@property(nonatomic, strong) NSString* content;
@property(nonatomic, strong) NSString* comment_id;

- (CommentInfo*)initWithFrom:(NSString*)from To:(NSString*)to Content:(NSString*)content ID:(NSString*)id;
@end

#endif /* CommentInfo_h */
