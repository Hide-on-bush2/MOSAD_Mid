//
//  ContentInfo+_.h
//  IOS_mid
//
//  Created by jinshlin on 2020/11/28.
//  Copyright © 2020 车春江. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentResponse :NSObject
@property(nonatomic, strong)NSMutableDictionary *info;
+(instancetype)singleInstance;
@end

NS_ASSUME_NONNULL_END
