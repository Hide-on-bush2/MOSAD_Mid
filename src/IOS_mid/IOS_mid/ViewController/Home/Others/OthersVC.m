//
//  OthersVC.m
//  IOS_mid
//
//  Created by jinshlin on 2020/11/20.
//  Copyright © 2020 车春江. All rights reserved.
//

#import "OthersVC.h"
#import "UserInfo.h"
#import "DynamicCell.h"
#import "CellModel.h"
#import "AFNetworking.h"
#import <Masonry/Masonry.h>
#import "XYAlbumModel.h"
#import <MBProgressHUD.h>
#import <YYModel.h>

@interface OthersVC () <UITableViewDataSource,UITableViewDelegate, UISearchResultsUpdating>
@property (nonatomic,strong)UITableView * tabelView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic, strong) NSMutableArray *filterDataSource;

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, assign) bool isFiltering;
@end

@implementation OthersVC
- (void)viewDidLoad {
    [super viewDidLoad];

    //search
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.obscuresBackgroundDuringPresentation = false;
    self.searchController.hidesNavigationBarDuringPresentation = false;
    //调整searchbar文字颜色为白色
    // Include the search bar within the navigation bar.
    self.navigationItem.titleView = self.searchController.searchBar;
    self.definesPresentationContext = true;
    
    _tabelView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    
    [self.view addSubview:_tabelView];
    [self showContent];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _tabelView.frame = self.view.bounds;
}

- (void)showContent{
    _dataArray = [NSMutableArray array];
    _filterDataSource = @[].mutableCopy;
    
    [self getContent];

    [_tabelView reloadData];
}

- (void)getContent{
    NSString *urlString = @"http://172.18.178.56/api/content/album/";
    NSString *my = @"5fbcc6d6f5beb22628d4b688";
    NSString *url = [urlString stringByAppendingString:my];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置响应体数据为json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //请求体，参数（NSDictionary 类型）
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [manager GET:url
      parameters:nil
         headers:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hideAnimated:YES];
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            return;
        }
        //1.data -> model
        NSArray <XYAlbumModel *> *models = [NSArray yy_modelArrayWithClass:XYAlbumModel.class json:responseObject[@"Data"]];
        
        //2.model -> CellModel
        for (XYAlbumModel *model in models) {
            CellModel *cellModel = [[CellModel alloc] init];
            cellModel.zanNum = model.likeNum;
            cellModel.time = model.album.time;
            cellModel.comemtNum = model.commentNum;
            cellModel.content = model.detail;
            NSMutableString *mutableString = [[NSMutableString alloc] init];

            for (XYImage *xyImage in model.album.images) {
                [mutableString appendFormat:@"http://172.18.178.56/api/thumb/%@,",xyImage.thumb];
            }
            //remove last ,
            if ([mutableString hasSuffix:@","]) {
               [mutableString deleteCharactersInRange: NSMakeRange(mutableString.length - 1, 1)];
            }
            cellModel.imgsss = mutableString;
            [self.dataArray addObject:cellModel];
        }
        [self.tabelView reloadData];
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.isFiltering? self.filterDataSource.count : self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellModel *model = self.isFiltering?self.filterDataSource[indexPath.row] :_dataArray[indexPath.row];
    NSArray * imgs = [model.imgsss componentsSeparatedByString:@","];
    return  [DynamicCell cellHeightWithStr:model.content imgs:imgs];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DynamicCell * cell = [DynamicCell dynamicCellWithTable:tableView];
    
    cell.model = self.isFiltering?self.filterDataSource[indexPath.row]: _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isFiltering) {
        return;
    }
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tabelView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self filterContentForSearchText:searchController.searchBar.text];
}

- (void)filterContentForSearchText:(NSString *)text {
    [self.filterDataSource removeAllObjects];
    for (CellModel *model in self.dataArray) {
        if ([model.content containsString:text] || [model.title containsString:text]) {
            [self.filterDataSource addObject:model];
        }
    }
    [self.tabelView reloadData];
}

#pragma mark - Getter
- (bool)isFiltering {
    return self.searchController.isActive && !self.isSearchBarEmpty;
}

- (bool)isSearchBarEmpty {
    return self.searchController.searchBar.text.length == 0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
