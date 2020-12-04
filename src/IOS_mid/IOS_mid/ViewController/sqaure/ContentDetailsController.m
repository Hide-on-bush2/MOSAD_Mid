//
//  ContentDetailsController.m
//  IOS_mid
//
//  Created by 车春江 on 2020/11/23.
//  Copyright © 2020 车春江. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentDetailsController.h"
#import "YMOpenAnimation.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


@interface ContentDetailsController()
@property NSString* username;
@property NSString* text;
@property NSString* comment;
@property (strong, nonatomic) NSArray *imageView;
@property (nonatomic, strong) YMOpenAnimation *animation;
@end

static int screenWidth;
static int screenHeight;


@implementation ContentDetailsController

- (ContentDetailsController*)initWithName:(NSString*)username Text:(NSString*)text Comment:(NSString*)comment Images:(NSArray*)images{
    if(self = [super init]){
        self.username = username;
        self.text = text;
        self.comment = comment;
        self.imageView = images;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    screenWidth = SCREEN_WIDTH;
    screenHeight = SCREEN_HEIGHT;
    
    //设置标题
    self.title = @"查看内容";
    UILabel* username = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, screenWidth-20, 50)];
    username.text = [@" 昵称: " stringByAppendingFormat:@"%@",self.username];
    
    UILabel* text = [[UILabel alloc]initWithFrame:CGRectMake(10, 160, screenWidth-20, 50)];
    text.text = [@" 文本内容: " stringByAppendingFormat:@"%@",self.text];
    
    UILabel* comment = [[UILabel alloc]initWithFrame:CGRectMake(10, 220, screenWidth-20, 50)];
    comment.text = [@" 评论: " stringByAppendingFormat:@"%@",self.comment];
    
    
    UIImageView* img1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 440, (screenWidth-40)/3, 100)];
    UIImageView* img2 = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (screenWidth-40)/3 + 10, 440, (screenWidth-40)/3, 100)];
    UIImageView* img3 = [[UIImageView alloc]initWithFrame:CGRectMake(10 + ((screenWidth-40)/3 + 10)*2, 440, (screenWidth-40)/3, 100)];
    UIImageView* img4 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 550, (screenWidth-40)/3, 100)];
    UIImageView* img5 = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (screenWidth-40)/3 + 10, 550, (screenWidth-40)/3, 100)];
    
    NSArray* tmpImages = [[NSArray alloc]initWithObjects:img1, img2, img3,img4, img5, nil];
    
    int i = 0;
    for(;i < self.imageView.count;i++){
        UIImageView* tImg = [tmpImages objectAtIndex:i];
        UIImageView* img = [self.imageView objectAtIndex:i];
        tImg.image = img.image;
    }
    
    while(i < tmpImages.count){
        [[tmpImages objectAtIndex:i] setImage:[UIImage imageNamed:@"apple"]];
        i++;
    }
    
    [self.view addSubview:username];
    [self.view addSubview:text];
    [self.view addSubview:comment];
//    NSLog(@"%@",self.date);
//    NSLog(@"%@",self.dest);
//    NSLog(@"%@",self.attractionName);
//    NSLog(@"%@",self.expression);
    for(int j = 0;j < tmpImages.count;j++){
        [self.view addSubview:[tmpImages objectAtIndex:j]];
    }
    
}

#pragma mark Animatio

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
//    NSLog(@"1");
    if (operation == UINavigationControllerOperationPush) {
        self.animation.isPop = NO;
    } else if (operation == UINavigationControllerOperationPop) {
        self.animation.isPop = YES;
    }
    return self.animation;
}

- (YMOpenAnimation *)animation {
//    NSLog(@"2");
    if (nil == _animation) {
        _animation = [[YMOpenAnimation alloc] init];
    }
    return _animation;
}


@end

