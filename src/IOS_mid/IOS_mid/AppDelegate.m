//
//  AppDelegate.m
//  ios_mid
//
//  Created by Khynnn on 2020/11/27.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if (@available(iOS 13.0, *)) {
      
    } else {
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        LoginViewController* login = [[LoginViewController alloc] init];
        UINavigationController* loginNC = [[UINavigationController alloc] initWithRootViewController:login];
        self.window.rootViewController = loginNC;
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
        
    }
    //TabBarController* TabBarCV = [[TabBarController alloc]init];
    //UINavigationController* tabBarCV = [[UINavigationController alloc]initWithRootViewController:TabBarCV];
    //self.window.rootViewController = TabBarCV;
    /*LoginViewController* login = [[LoginViewController alloc] init];
    UINavigationController* loginNC = [[UINavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = loginNC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];*/
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
