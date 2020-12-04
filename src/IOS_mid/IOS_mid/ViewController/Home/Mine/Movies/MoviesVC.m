//
//  MoviesVC+_.m
//  IOS_mid
//
//  Created by jinshlin on 2020/11/30.
//  Copyright © 2020 车春江. All rights reserved.
//

#import "MoviesVC.h"
#import "AddMoviesVC.h"
#import "DynamicCell.h"
#import "CellModel.h"
#import "AFNetworking.h"
#import <Masonry/Masonry.h>

@interface MoviesVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tabelView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation MoviesVC 
- (void)viewDidLoad {
  [super viewDidLoad];
  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick:)];
    
    _tabelView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    [self.view addSubview:_tabelView];
    [self showContent];
}

- (void)rightBarButtonItemClick:(UIBarButtonItem *)barButtonItem {
    
    AddMoviesVC *VC = [[AddMoviesVC alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _tabelView.frame = self.view.bounds;
}

- (void)showContent{
    _dataArray = [NSMutableArray array];
    
    for (int i =0; i<4; i++) {
        CellModel *model = [[CellModel alloc]init];
        model.avator = @"head_icon";
        model.name = @"我";
        model.title = @"主题";
        model.time = @"5分钟";
        model.comemtNum = @"100";
        model.zanNum = @"120";
        model.content = @"详情";

       if (i==1) {
             model.imgsss = @"11";
             model.content = @"内容";

        }else if(i == 2){
             model.imgsss = @"11,22,33,44";
            model.content = @"内容";

        }else if(i == 3){
            model.imgsss = @"11,22,33,44,55,66";
        }
        [_dataArray addObject:model];
    }
    [_tabelView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellModel *model = _dataArray[indexPath.row];
    NSArray * imgs = [model.imgsss componentsSeparatedByString:@","];
   return  [DynamicCell cellHeightWithStr:model.content imgs:imgs];
}

#pragma mark - UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DynamicCell * cell = [DynamicCell dynamicCellWithTable:tableView];
    
    cell.model = _dataArray[indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
