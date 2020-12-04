//
//  UserInfo.m
//  IOS_mid
//
//  Created by Khynnn on 2020/11/22.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@implementation UserInfo

@synthesize info = _info;

-(id)init{
    if(self = [super init]){
        self.data = [NSMutableDictionary dictionary];
        self.info = [NSMutableDictionary dictionary];
        self.color = [UIColor colorWithRed:85.0/255.0 green:77.0/255.0 blue:132.0/255.0 alpha:100];
        self.lightColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:100];
        
        UIColor *blue = [UIColor colorWithRed:81.0/255.0 green:102.0/255.0 blue:151.0/255.0 alpha:100];
        UIColor *lightBlue = [UIColor colorWithRed:228.0/255.0 green:234.0/255.0 blue:244.0/255.0 alpha:100];
        UIColor *green = [UIColor colorWithRed:54.0/255.0 green:69.0/255.0 blue:30.0/255.0 alpha:100];
        UIColor *lightGreen = [UIColor colorWithRed:219.0/255.0 green:221.0/255.0 blue:213.0/255.0 alpha:100];
        self.colorArr = @[_color, blue, green];
        self.lightColorArr = @[_lightColor, lightBlue, lightGreen];
    }
    return self;
}

+(instancetype)singleInstance{
    static UserInfo *myInstance = nil;
    if(myInstance == nil){
        myInstance = [[UserInfo alloc]init];
    }
    return myInstance;
}

-(void)changeColor:(int)num{
    if(num == 0){
        self.color = [UIColor colorWithRed:85.0/255.0 green:77.0/255.0 blue:132.0/255.0 alpha:100];
        self.lightColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:100];
    }
    else if(num == 1){
        self.color = [_colorArr objectAtIndex:1];
        self.lightColor = [_lightColorArr objectAtIndex:1];
    }
    else if(num == 2){
        self.color = [_colorArr objectAtIndex:2];
        self.lightColor = [_lightColorArr objectAtIndex:2];
    }
}

@end
