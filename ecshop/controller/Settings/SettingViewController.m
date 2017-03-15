//
//  SettingViewController.m
//  ecshop
//
//  Created by Jin on 15/12/7.
//  Copyright © 2015年 jsyh. All rights reserved.
//设置

#import "SettingViewController.h"
#import "SettingViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "AboutViewController.h"
#import "SettingGesturePasswordViewController.h"
#import "SettingUnlockTableViewCell.h"

#define kColorBack [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0]


@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,SettingUnlockTableViewCellDelegate>

@property(nonatomic,strong)UITableView *tableview;


@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];

}
-(void)initViews{
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"更多";
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
   
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = kColorBack;
    _tableview.scrollEnabled = NO;
    
    [self.view addSubview:_tableview];
  
}
#pragma mark tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    if (section == 0) {
        
        return 2;
        
    }else if (section ==1){
        
        return 2;
    }
    
    return 0;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = kColorBack;
    
    return view;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (indexPath.section == 0) {
        
        
        static NSString *string = @"SettingViewCell";
        SettingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingViewCell" owner:self options:nil]lastObject];
            DebugLog(@"%@",indexPath);
    
        }
    
        if (indexPath.row == 0) { //关于我们
            
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            // app名称
            NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
            // app版本
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            // app build版本
            NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
            
            cell.textLabel.text = @"关于我们";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.detailTextLabel.text = app_Version;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            
        }else if (indexPath.row == 1){ //清楚本地缓存
            
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(0, 0, self.view.frame.size.width, cell.frame.size.height);
            [but addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:but];
            
            cell.textLabel.text = @"清除本地缓存";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            NSString *path = [paths lastObject];
            NSString *str = [NSString stringWithFormat:@"缓存%.1fM", [self folderSizeAtPath:path]];
            cell.detailTextLabel.text = str;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            
        }
        
        return cell;
        
    }else if (indexPath.section == 1){
        
        static NSString *str = @"SettingUnlockTableViewCell";
        
        SettingUnlockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        

        if (cell ==nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"SettingUnlockTableViewCell" owner:self options:nil]lastObject];
        }
        
        cell.delegate = self;
        
        if (indexPath.row == 0) {
            
            //cell.textLabel.text = @"手势解锁";
            cell.myLabel.text = @"手势解锁";
            
        }else if (indexPath.row == 1){
            
            //cell.textLabel.text = @"指纹解锁";
            cell.myLabel.text = @"指纹解锁";
            
        }
        
        return cell;

        
    }
    
    
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        AboutViewController *aboutView = [AboutViewController new];
        [self.navigationController pushViewController:aboutView animated:YES];
        
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) { //手势解锁
            
            SettingGesturePasswordViewController *sgpVC = [SettingGesturePasswordViewController new];
            //sgpVC.automaticallyAdjustsScrollViewInsets = NO;
            
            sgpVC.promptStr = @"设置手势密码";
            
            [self.navigationController pushViewController:sgpVC animated:YES];
            
            
        }else if (indexPath.row == 1){ //指纹解锁
            

            
            
        }
        
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark -- SettingUnlockTableViewCellDelegate
-(void)SettingUnlockTableViewCell:(SettingUnlockTableViewCell *)cell switchValueChanged:(BOOL)on{
    
    NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
    
    DebugLog(@"%@",indexPath);
    
    if (indexPath.section == 1){
        
        if (indexPath.row == 0) { //手势解锁
        
            if (on) {
                
                
            }else{
                
                
            }

            
        }else if (indexPath.row == 1){ //指纹解锁
            
            if (on) {
                
                
            }else{
                
                
            }
            
        }
    }
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -缓存


- (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        
    }
    
    return 0;
    
}



//遍历文件夹获得文件夹大小，返回多少M

- (float ) folderSizeAtPath:(NSString*) folderPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    
    return folderSize/(1024.0*1024.0);
    
}
- (void)action:(id)sender

{
    
   
    //彻底清除缓存第一种方法
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"确定要清除缓存吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *okAction =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIButton * button = sender;
        
        [button setTitle:@"清理完毕" forState:UIControlStateNormal];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        
        NSString *path = [paths lastObject];
        
        
        
        NSString *str = [NSString stringWithFormat:@"缓存已清除%.1fM", [weakSelf folderSizeAtPath:path]];
        
        NSLog(@"%@",str);
        
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
        
        for (NSString *p in files) {
            
            NSError *error;
            
            NSString *Path = [path stringByAppendingPathComponent:p];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:Path]) {
                
                [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];
                
            }
            
        }
         [weakSelf.tableview reloadData];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
    
}



@end
