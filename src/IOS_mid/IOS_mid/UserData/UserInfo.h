//
//  UserInfo.h
//  IOS_mid
//
//  Created by Khynnn on 2020/11/22.
//
#import <UIKit/UIKit.h>

@interface UserInfo:NSObject

@property(nonatomic, strong)NSMutableDictionary *data;
//URL user/info
@property(nonatomic, strong)NSMutableDictionary *info;

//用于个性化设置
@property(nonatomic, strong)UIColor *color;
@property(nonatomic, strong)UIColor *lightColor;

@property(nonatomic, strong) NSArray *colorArr;
@property(nonatomic, strong) NSArray *lightColorArr;

+(instancetype)singleInstance;
-(void)changeColor:(int)num;

@end
