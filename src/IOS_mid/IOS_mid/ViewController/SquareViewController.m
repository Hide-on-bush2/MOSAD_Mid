//
//  SquareViewController.m
//  IOS_mid
//
//  Created by 车春江 on 2020/11/19.
//  Copyright © 2020 车春江. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SquareViewController.h"
#import "ContentCell.h"
#import "CollectionHeaderView.h"
#import "CollectionFooterView.h"
#import "ContentDetailsController.h"
#import "MJRefresh.h"
#import <AFNetworking.h>


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


@interface SquareViewController()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>
@property (strong, nonatomic)UICollectionView *collectionView;
@property(strong,nonatomic) CAGradientLayer* gradientLayer;
@property (strong, nonatomic)NSMutableArray* dataList;
@property (strong, nonatomic)NSMutableArray* contentList;
@property (nonatomic)int currLoadCount;
@property (strong, nonatomic)NSString* user_id;
@property (strong, nonatomic)NSString* user_name;
@end

static NSString *cellIdentifier = @"ContentCell";
static NSString *headerIdentifier = @"CollectionHeaderView";
static NSString *footerIdentifier = @"CollectionFooterView";
static int screenWidth;
static int screenHeight;
static NSString *base_url = @"http://172.18.178.56/api/";
static AFHTTPSessionManager *manage;
const int max_content_size = 10;

@implementation SquareViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    screenWidth = SCREEN_WIDTH;
    screenHeight = SCREEN_HEIGHT;
    
    self.contentList = [[NSMutableArray alloc]initWithCapacity:20];
    manage = [AFHTTPSessionManager manager];
    manage.requestSerializer = [AFJSONRequestSerializer serializer]; // 设置响应体为JSON
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
//    [self login];
    [self getPublic];
    [self get_userInfo];
    self.currLoadCount = 5;
    self.title = @"广场";
    self.navigationController.title = @"广场";
//    NSLog(@"screen width : %d",screenWidth);
//    NSLog(@"screen height : %d",screenHeight);
    //创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //flowlaout的属性，确定是水平滚动，还是垂直滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //接下来就在创建collectionView的时候初始化，就很方便了（能直接带上layout）
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //指定数据源和代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //collectionCell的注册
    [self.collectionView registerClass:[ContentCell class] forCellWithReuseIdentifier:cellIdentifier];
    //collection头视图的注册。  注意：奇葩的地方来了，头视图和尾部视图也得注册
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    [self.collectionView registerClass:[CollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier];
//    self.collectionView.automaticallyAdjustsScrollIndicatorInsets = NO;
//    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;

    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView.mj_footer endRefreshing];
        });
//        self.currLoadCount += 5;
        if(self.currLoadCount < self.dataList.count){
            self.currLoadCount += 5;
        }
        [self.collectionView reloadData];
    }];
    
    //添加到主页面上去
//    [self setBackground];
    [self.view addSubview:self.collectionView];
    
    self.dataList = [[NSMutableArray alloc]initWithCapacity:20];
//    NSDictionary* Demo1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"2018",@"date",@"SKT",@"dest",@"Happy",@"mood", nil];
//    [self.dataList addObject:Demo1];
//    NSDictionary* Demo2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"2019",@"date",@"T1",@"dest",@"bad",@"mood", nil];
//    [self.dataList addObject:Demo2];
//    NSDictionary* Demo3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"2020",@"date",@"FPX",@"dest",@"angry",@"mood", nil];
//    [self.dataList addObject:Demo3];
//    NSDictionary* Demo4 = [[NSDictionary alloc]initWithObjectsAndKeys:@"2021",@"date",@"DWG",@"dest",@"sad",@"mood", nil];
//    [self.dataList addObject:Demo4];
//    ContentCell* cell1 = [[ContentCell alloc]initWithName:@"faker" Text:@"I am Faker" Comment:@"这不是脚本？哦是飞科啊，那没事了"  Images:[[NSArray alloc]init]];
//    [self.dataList addObject:cell1];
//    ContentCell* cell2 = [[ContentCell alloc]initWithName:@"uzi" Text:@"I am Uzi" Comment:@"无畏澡八强" Images:[[NSArray alloc]init]];
//    [self.dataList addObject:cell2];
//    ContentCell* cell3 = [[ContentCell alloc]initWithName:@"theshy" Text:@"I am Theshy" Comment:@"断手上单就这？" Images:[[NSArray alloc]init]];
//    [self.dataList addObject:cell3];
//    ContentCell* cell4 = [[ContentCell alloc]initWithName:@"Knight" Text:@"I am 诺手" Comment:@"诺手来辣[神][神][神]" Images:[[NSArray alloc]init]];
//    [self.dataList addObject:cell4];
    
}

- (void)login{
    NSDictionary* login_param = @{@"name":@"chechunjiang@icloud.com",@"password":@"111111"};
    NSString* login_url = @"http://172.18.178.56/api/user/login/pass";
    [manage POST:login_url parameters:login_param headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"login failure");
    }];
}

- (void)getPublic{
    NSString *getpublic_url = [base_url stringByAppendingFormat:@"%@%d",@"content/public?page=1&eachPage=",max_content_size];
    // 设置请求体为JSON
    [manage GET:getpublic_url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for(int i = 0;i < max_content_size;i++){
//            NSLog(@"%@", responseObject[@"Data"][i]);
            [self.contentList addObject:responseObject[@"Data"][i]];
//            NSLog(@"data %d",i);
        }
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failue");
    }];

}

- (void)get_userInfo{
    NSString *urlString = @"http://172.18.178.56/api/user/info/self";
    
    [manage GET:urlString
       parameters:nil
          headers:nil
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.user_id = responseObject[@"ID"];
        self.user_name = responseObject[@"Name"];
        NSLog(@"id:%@",self.user_id);
        NSLog(@"name:%@",self.user_name);
            }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
    }];
}


-(void)addClockInRecored:(ContentCell*)record{
    [self.dataList addObject:record];
    [self.collectionView reloadData];
}

- (void)setBackground{
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.view.bounds;

    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层

    //设置渐变区域的起始和终止位置（范围为0-1）
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(1, 1);

    //设置颜色数组
    self.gradientLayer.colors = @[(__bridge id)[UIColor whiteColor].CGColor,
                                  (__bridge id)[UIColor grayColor].CGColor];

    //设置颜色分割点（范围：0-1）
    self.gradientLayer.locations = @[@(0.5f), @(1.0f)];
//    [self.collectionView.layer addSublayer:self.gradientLayer];
//    [self.view.layer insertSublayer:self.gradientLayer below:self.collectionView.layer];
    self.gradientLayer.zPosition = -1;
    [self.collectionView.layer insertSublayer:self.gradientLayer atIndex:0];

}

#pragma mark UICollectionViewDataSource

//返回多少组（section），此方法不写默认是1组(跟tableview类似)
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark required
//每组返回多少个Item，这个Item类似tableview中的cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.dataList.count < self.currLoadCount ? self.dataList.count : self.currLoadCount;
    return self.contentList.count;
}

//返回cell，这里构建Item（即cell）
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //这里是自定义的cell
    ContentCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//    NSUInteger size = self.contentList.count;
//    NSDictionary* content = self.contentList[indexPath.row];
//    [cell setupContenWithDate:[content date_] Dest:[content dest_] Mood:[content expr_]];
//    [cell setupContenWithName:content[@"User"][@"Name"] Text:content[@"Detail"] Comment:nil Images:nil];
//    [cell initWithJson:content];
    [self setupModelOfCell:cell AtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor = [[UIColor blackColor] CGColor];
    cell.layer.cornerRadius = 5;
    cell.VC = self;
    cell.user_id = self.user_id;
    cell.user_name = self.user_name;
    return cell;
}

- (void)setupModelOfCell:(ContentCell*)cell AtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%d",indexPath.item);
    NSDictionary* content = self.contentList[indexPath.item];
    //    [cell setupContenWithDate:[content date_] Dest:[content dest_] Mood:[content expr_]];
    //    [cell setupContenWithName:content[@"User"][@"Name"] Text:content[@"Detail"] Comment:nil Images:nil];
    [cell initWithJson:content];
}

#pragma mark  optional
//自定义header/footerView
// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
//这里返回的view必须要从dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:这个方法中获取，而且根据不同的kind作为headerView或者footerView，切记：collectionView中头部视图和尾部视图也需要注册
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (UICollectionElementKindSectionHeader == kind) {
        //这里是自定义的头视图
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        ((CollectionHeaderView*)headerView).searchBar.delegate = self;
//        headerView.backgroundColor = [UIColor yellowColor];
//       UILabel *titleLabel = [[UILabel alloc]initWithFrame:headerView.bounds];
//       titleLabel.text = [NSString stringWithFormat:@"第%ld个分区的区头",indexPath.section];
//       [headerView addSubview:titleLabel];
        return headerView;
    }
    if (UICollectionElementKindSectionFooter == kind) {
        //这里是自定义的尾视图
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerIdentifier forIndexPath:indexPath];
//        footerView.backgroundColor = [UIColor blueColor];
//        UILabel *titleLabel = [[UILabel alloc]initWithFrame:footerView.bounds];
//        titleLabel.text = [NSString stringWithFormat:@"第%ld个分区的区尾",indexPath.section];
//        [footerView addSubview:titleLabel];
        return footerView;
    }
    return reusableView;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    // 这里可以根据你需要的效果自定义cell的transform的效果
    cell.transform = CGAffineTransformTranslate(cell.transform, 0, 40);
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        cell.transform = CGAffineTransformTranslate(cell.transform, 0, -40);
    } completion:nil];
}

#pragma mark - UICollectionViewDelegateFlowLayout

//布局确定每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(screenWidth-20, 400);
}

//布局确定每个section内的Item距离section四周的间距 UIEdgeInsets
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//返回每个section内上下两个Item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//返回每个section内左右两个Item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

////返回headerView的尺寸
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    NSLog(@"11");
//    CGFloat width = CGRectGetWidth(collectionView.bounds);
//    CGFloat height = 50;
//    return CGSizeMake(width, height);
//}
//
////返回footerView的尺寸
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    NSLog(@"12");
//    CGFloat width = CGRectGetWidth(collectionView.bounds);
//    CGFloat height = 50;
//    return CGSizeMake(width, height);
//}

/**
 区头大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(screenWidth, 50);
}
/**
 区尾大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(screenWidth, 50);
}


#pragma mark - UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

//    NSUInteger size = self.dataList.count;
//    ContentCell* cell = self.dataList[size - indexPath.row - 1];
//    cell.backgroundColor = [UIColor yellowColor];
//
//    ContentDetailsController* detail = [[ContentDetailsController alloc]initWithName:[cell username_] Text:[cell text_] Comment:[cell comment_] Images:[cell imageView]];
//    self.navigationController.delegate = detail;
//    [self.navigationController pushViewController:detail animated:YES];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark searchFunction

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString* content = searchBar.text;
    for(int i = 0;i < self.dataList.count;i++){
        ContentCell* item = [self.dataList objectAtIndex:i];
        if([content isEqualToString:[item username_]] || [content isEqualToString:[item text_]] || [content isEqualToString:[item comment_]]){
//            NSLog(@"find");
            NSString* meg = [@" 昵称: " stringByAppendingFormat:@"%@", [item username_]];
            meg = [meg stringByAppendingFormat:@" 文本: %@",[item text_]];
            meg = [meg stringByAppendingFormat:@" 评论: %@",[item comment_]];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"广场" message:meg preferredStyle: UIAlertControllerStyleAlert];//中间弹出 还有一种从底部弹出UIAlertControllerStyleActionSheet
            [self presentViewController:alertController animated:YES completion:nil]; //以模态弹出的方式让弹出框出现
            
            UIAlertAction    *commitBut = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertController addAction:commitBut];//添加按钮
            break;
        }
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"广场" message:@"很抱歉没有找到记录" preferredStyle: UIAlertControllerStyleAlert];//中间弹出 还有一种从底部弹出UIAlertControllerStyleActionSheet
    [self presentViewController:alertController animated:YES completion:nil]; //以模态弹出的方式让弹出框出现
    
    UIAlertAction    *commitBut = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:commitBut];//添加按钮
}

@end
