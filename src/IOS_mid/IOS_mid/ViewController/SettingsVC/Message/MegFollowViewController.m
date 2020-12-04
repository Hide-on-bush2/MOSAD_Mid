//
//  MegFollowViewController.m
//  ios_mid
//
//  Created by Khynnn on 2020/12/3.
//


#import <Foundation/Foundation.h>
#import "MegFollowViewController.h"
#import "MessageData.h"
#import "MyTableCell.h"

@interface MegFollowViewController ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation MegFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新增关注";
}


- (void)viewWillAppear:(BOOL)animated{
    [self createTable];
}

- (UITableView *)tableView {
   if (_tableView == nil) {
       _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
       _tableView.delegate = self;
       _tableView.dataSource = self;
       [self.view addSubview:_tableView];
   }
   
   return _tableView;
}

- (void)createTable{
    //_tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 120, self.view.frame.size.width - 20 , self.view.frame.size.height - 165) style:UITableViewStyleGrouped];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [MessageData singleInstance].follow.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    MyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil) {
        cell = [[MyTableCell alloc]initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //对于cell设置长按点击事件
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [cell addGestureRecognizer:longPressGestureRecognizer];
    
    cell.textLabel.numberOfLines = 2;
    UIColor *gray_color = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:100];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = gray_color.CGColor;
    //cell.layer.cornerRadius = 10;
    
    [cell setID:[MessageData singleInstance].follow[indexPath.section][@"Data"][@"ID"]
         Avatar:[MessageData singleInstance].system[indexPath.section][@"User"][@"Avatar"]
           Name:[MessageData singleInstance].system[indexPath.section][@"User"][@"Name"]
        Content:@"关注了你"
           time:[MessageData singleInstance].system[indexPath.section][@"Data"][@"CreateTime"]
           Read:[MessageData singleInstance].system[indexPath.section][@"Data"][@"Read"]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* v = [[UIView alloc]init];
    v.backgroundColor = [UIColor clearColor];
    return v;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* v = [[UIView alloc]init];
    v.backgroundColor = [UIColor clearColor];
    return v;
}

- (void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        MyTableCell *cell = (MyTableCell *) gestureRecognizer.view;
        [cell becomeFirstResponder];
        self.selectedID = cell.ID;
        //定义菜单
        UIMenuController *menu = [UIMenuController sharedMenuController];

        UIMenuItem *read;
        if([cell.read isEqual:@"true"])
            read = [[UIMenuItem alloc] initWithTitle:@"标记为未读" action:@selector(readAction)];
        else{
            read = [[UIMenuItem alloc] initWithTitle:@"标记为已读" action:@selector(readAction)];
        }
        
        UIMenuItem *delete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteAction)];
        //设定菜单显示的区域，显示再Rect的最上面居中
        //[menu setTargetRect:cell.frame inView:self.tableView];
        [menu showMenuFromView:self.tableView rect:cell.frame];
        [menu setMenuItems:@[read,delete]];
        //[menu setMenuVisible:YES animated:YES];
    }
}

- (void)readAction{
    NSLog(@"readAction");
    NSLog(@"%@",_selectedID);
    [[MessageData singleInstance] readAction:_selectedID];
    [_tableView reloadData];
}

- (void)deleteAction{
    NSLog(@"deleteAction");
    [[MessageData singleInstance] deleteAction:_selectedID];
    [_tableView reloadData];
}

@end
