//
//  MessageData.m
//  ios_mid
//
//  Created by Khynnn on 2020/12/3.
//

#import <Foundation/Foundation.h>
#import "MessageData.h"

#import "AFNetworking.h"

@implementation MessageData

@synthesize like = _like;
@synthesize reply = _reply;
@synthesize system = _system;
@synthesize follow = _follow;

-(id)init{
    if(self = [super init]){
        self.like = [NSMutableArray arrayWithCapacity:10];
        self.reply = [NSMutableArray arrayWithCapacity:10];
        self.system = [NSMutableArray arrayWithCapacity:10];
        self.follow = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

+(instancetype)singleInstance{
    static MessageData *myInstance = nil;
    if(myInstance == nil){
        myInstance = [[MessageData alloc]init];
    }
    return myInstance;
}

- (void)getMeg{
    NSString *urlString = @"http://172.18.178.56/api/notification/all";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置响应体数据为json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:urlString
       parameters:nil
          headers:nil
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //NSLog(@"getMeg %@",responseObject);
                NSDictionary *dic = responseObject;
                for(id key in [dic valueForKey:@"Notification"]){
                    NSString *temp = [[key valueForKey:@"Data"] valueForKey:@"Type"];
                    if([temp isEqual:@"like"])
                        [self.like addObject:key];
                    else if([temp isEqual:@"follow"])
                        [self.follow addObject:key];
                    else if([temp isEqual:@"reply"])
                        [self.reply addObject:key];
                    else if([temp isEqual:@"system"])
                        [self.system addObject:key];
                }
                NSLog(@"like %@",self.like);
                NSLog(@"follow %@", self.follow);
                NSLog(@"reply %@", self.reply);
                NSLog(@"system %@", self.system);
            }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
    }];
}

-(void)readAction:(NSString *)ID{
    NSString *urlString =[ @"http://172.18.178.56/api/notification/read/" stringByAppendingString:ID];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置响应体数据为json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager PATCH:urlString
        parameters:nil
           headers:nil
           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"readAction %@",responseObject);
        if([responseObject[@"State"] isEqual:@"success"])
            [[MessageData singleInstance] getMeg];
    }
           failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

-(void)deleteAction:(NSString *)ID{
    NSString *urlString =[ @"http://172.18.178.56/api/notification/" stringByAppendingString:ID];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置响应体数据为json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager DELETE:urlString
         parameters:nil
            headers:nil
            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"readAction %@",responseObject);
        if([responseObject[@"State"] isEqual:@"success"])
            [[MessageData singleInstance] getMeg];
    }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
