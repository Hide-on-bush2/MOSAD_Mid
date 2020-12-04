//
//  AddMoviesVC+_.m
//  ios_mid
//
//  Created by jinshlin on 2020/12/4.
//

#import "AddMoviesVC.h"
#import "UserInfo.h"
#import <MJRefresh.h>
#import "AFNetworking.h"
#import <Masonry.h>

@interface AddMoviesVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong, nonatomic)UITextField *detailt,*locationt,*subTitlet;
@property(strong, nonatomic)UILabel *detail,*location,*subTitle,*photo;
@property(strong, nonatomic)UIButton *send;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation AddMoviesVC 
- (void)viewDidLoad {
        [super viewDidLoad];
        self.navigationItem.title = @"添加";
        
        self.detail = [[UILabel alloc] initWithFrame:CGRectMake(20,120,50,25)];
        self.detail.text = @"描述";
        [self.view addSubview:self.detail];
        
        self.detailt = [[UITextField alloc] initWithFrame:CGRectMake(120,120,200,25)];
        [self.detailt setEnabled:YES];
        [self.detailt setPlaceholder:@"简单描述一下吧"];
        [self.detailt setKeyboardType:UIKeyboardTypeDefault];
        self.detailt.layer.borderWidth = 1;
        self.detailt.layer.borderColor = [UIColor grayColor].CGColor;
       
        
        [self.detailt setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0,0,10,0)]];
        [self.detailt setLeftViewMode:UITextFieldViewModeAlways];
        [self.view addSubview:self.detailt];
        
        self.location = [[UILabel alloc] initWithFrame:CGRectMake(20,180,50,25)];
        self.location.text = @"地点";
        [self.view addSubview:self.location];
        
        self.locationt = [[UITextField alloc] initWithFrame:CGRectMake(120,180,200,25)];
        [self.locationt setEnabled:YES];
        [self.locationt setPlaceholder:@"请输入地点"];
        [self.locationt setKeyboardType:UIKeyboardTypeDefault];
        self.locationt.layer.borderWidth = 1;
        self.locationt.layer.borderColor = [UIColor grayColor].CGColor;
        
        
        [self.locationt setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0,0,10,0)]];
        [self.locationt setLeftViewMode:UITextFieldViewModeAlways];
        [self.view addSubview:self.locationt];
        
        self.subTitle = [[UILabel alloc] initWithFrame:CGRectMake(20,300,80,25)];
        self.subTitle.text = @"主题";
        [self.view addSubview:self.subTitle];
    
        self.subTitlet = [[UITextField alloc] initWithFrame:CGRectMake(120,300,250,25)];
        [self.subTitlet setEnabled:YES];
        [self.subTitlet setPlaceholder:@"请输入主题"];
        [self.subTitlet setKeyboardType:UIKeyboardTypeDefault];
        self.subTitlet.layer.borderWidth = 1;
        self.subTitlet.layer.borderColor = [UIColor grayColor].CGColor;
    
    
        [self.subTitlet setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0,0,10,0)]];
        [self.subTitlet setLeftViewMode:UITextFieldViewModeAlways];
        [self.view addSubview:self.subTitlet];
    
        self.photo = [[UILabel alloc] initWithFrame:CGRectMake(20,450,50,30)];
        self.photo.text = @"配图";
        [self.view addSubview:self.photo];

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake((UIScreen.mainScreen.bounds.size.width - 240  )/ 3.0, 50);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(120, 450, 250, 200) collectionViewLayout:layout];
        [self.collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview: self.collectionView];
        
        self.send = [[UIButton alloc] initWithFrame:CGRectMake(280, 650, 80, 30)];
        [self.send setTitle:@"发布" forState:UIControlStateNormal];
        [self.send setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.send.layer.borderWidth = 2;
        self.send.layer.borderColor = [UIColor grayColor].CGColor;
        [self.send setBackgroundColor: [UIColor orangeColor]];
        self.send.layer.cornerRadius = 5;
        [self.send addTarget:self action:@selector(Sendit:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.send];
        [self.view addSubview:self.imageView];
        
        
    }

    -(UIImageView *)imageView {
            if(!_imageView) {
                _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 580, 50, 50)];
                _imageView.image = [UIImage imageNamed:@"add.jpg"];
                _imageView.userInteractionEnabled = YES;  //这个一定要设置为YES，默认的为NO，NO的时候不可发生用户交互动作
                UITapGestureRecognizer *clickTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseImage)];
                [_imageView addGestureRecognizer:clickTap];
            }
            return _imageView;
        }

    -(void)chooseImage {
            self.imagePicker = [[UIImagePickerController alloc] init];
            self.imagePicker.delegate = self;
            self.imagePicker.allowsEditing = YES;
            
        
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"从相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [self presentViewController:self.imagePicker animated:YES completion:nil];
                }
            }];
            
            UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:self.imagePicker animated:YES completion:nil];
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了取消");
            }];
            
            [actionSheet addAction:cameraAction];
            [actionSheet addAction:photoAction];
            [actionSheet addAction:cancelAction];
            
            [self presentViewController:actionSheet animated:YES completion:nil];
        }
        
    #pragma mark - UImagePickerControllerDelegate
    //获取选择的图片
        -(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
            [picker dismissViewControllerAnimated:YES completion:nil];
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            self.imageView.image = image;
        }
        

    //从相机或者相册界面弹出
        - (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
            [picker dismissViewControllerAnimated:YES completion:nil];
        }


    #pragma mark - UICollectionViewDataSource
    - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        return 6;
    }

    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    - (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class) forIndexPath:indexPath];
        return cell;
        
    }

    #pragma mark - UICollectionViewDelegate
    - (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
        cell.backgroundColor = [UIColor greenColor];
    }

    //发布
    -(void)Sendit:(id)sender{

        NSDictionary *parameters = @{@"title":_subTitlet.text,
                                     @"detail":_detailt.text,
                                     @"isPublic":@YES
        };
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manager POST:@"http://172.18.178.56/api/content/album" parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                [formData appendPartWithFormData:[[parameters objectForKey:@"title"] dataUsingEncoding:NSUTF8StringEncoding] name:@"title"];
                [formData appendPartWithFormData:[[parameters objectForKey:@"detail"] dataUsingEncoding:NSUTF8StringEncoding] name:@"detail"];
                /*
                NSArray *tmp = [parameters objectForKey:@"tags"];
                NSString *tags = [[NSString alloc]init];
                if(tmp.count>0){
                    tags = [tags stringByAppendingString:tmp[0]];
                }
                for(int i=1;i<tmp.count;i++){
                    tags = [tags stringByAppendingFormat:@"&&%@",tmp[i]];
                }
                [formData appendPartWithFormData:[tags dataUsingEncoding:NSUTF8StringEncoding] name:@"tags"];
                 */
                NSString *pub = [[parameters objectForKey:@"isPublic"] stringValue];
                [formData appendPartWithFormData:[pub dataUsingEncoding:NSUTF8StringEncoding] name:@"isPublic"];
                
                    NSData *imgData = UIImageJPEGRepresentation(self.imageView.image,1.0);
        //            UIImage *img = [UIImage imageWithData:tmp];
                    NSString *fileKey = [NSString stringWithFormat:@"file%d",1];
                    NSString *thumbKey = [NSString stringWithFormat:@"thumb%d",1];
            //        NSLog(@"fileKey: %@,  thumbKey: %@",fileKey,thumbKey);
                    [formData appendPartWithFileData:imgData name:fileKey fileName:@"image" mimeType:@"image/jpeg"];
                    [formData appendPartWithFileData:imgData name:thumbKey fileName:@"image" mimeType:@"image/jpeg"];
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"post content successfully");
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"responseObject:&@",JSON);
                [self dismissViewControllerAnimated:YES completion:nil];
            }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"post failed");
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
                
    }
 
@end
