//
//  main.m
//  IOS_mid
//
//  Created by 车春江 on 2020/11/19.
//  Copyright © 2020 车春江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AFNetworking.h>

struct ContentData{
    NSString* title;
    NSString* detail;
    NSString* tags[10];
    Boolean isPublic;
};

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    
//    NSString *register_url = @"http://172.18.176.202:3333/hw_mid/user/register";
//    NSDictionary *register_parameters = @{@"name": @"faker", @"password": @"111111",
//    @"email": @"skt.faker.ccj@gmail.com"};
//    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
//    // 设置请求体为JSON
//    manage.requestSerializer = [AFJSONRequestSerializer serializer]; // 设置响应体为JSON
//    manage.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manage POST:register_url parameters:register_parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
//    // 弹出提示框，提醒用户返回去登录
//        NSLog(@"register");
//        NSLog(@"%@---%@",[responseObject class],responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"failue");
//    }];
//
//
//    NSString *login_url = @"http://172.18.176.202:3333/hw_mid/user/login";
//    NSDictionary *login_parameters = @{@"email": @"skt.faker.ccj@gmail.com", @"password": @"111111",
//    };
//    [manage POST:login_url parameters:login_parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
//    // 弹出提示框，提醒用户返回去登录
//        NSLog(@"login");
//        NSLog(@"%@---%@",[responseObject class],responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"failue");
//    }];
//
//
//    struct ContentData data;
//    data.title = @"faker";
//    data.detail = @"I am Faker";
//    data.isPublic = true;
//    NSString *post_text_content_url = @"http://172.18.176.202:3333/hw_mid/content/text";
//    NSDictionary *post_text_content_parameters = @{@"title": @"faker", @"detail": @"I am Faker", @"tags":@"SKT", @"isPublic":@"true"};
//    [manage POST:post_text_content_url parameters:post_text_content_parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
//    // 弹出提示框，提醒用户返回去登录
//        NSLog(@"post content");
//        NSLog(@"%@---%@",[responseObject class],responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"failue");
//    }];
    
    
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
