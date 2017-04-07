//
//  LoginVC.m
//  ecshop
//
//  Created by 吴狄 on 2017/4/5.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITextField *userNameTextFiled;


@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    [self initViews];
    
}


-(void)initViews{
    
    
    _myTableView = ({
       
        UITableView *tableView = [[UITableView alloc]initWithFrame:UIScreen.mainScreen.bounds style:UITableViewStylePlain];
        
        [self.view addSubview:tableView];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //tableView.backgroundView =
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.edges.equalTo(self.view);

        }];
        

        tableView;
    });
    
    
    
    _myTableView.tableHeaderView = ({
        
        UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/3)];
        
        tableHeaderView;
    });
    
    _myTableView.tableFooterView = ({
        
        UIView *tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/3)];
        
        
        tableFooterView;
    });

    
    
    self.userNameTextFiled =({
        
        UITextField *textField = [UITextField new];
        
        
        textField;
    });

    
    
    
    [self initNavigationBar];
    
}



-(void)initNavigationBar{
    
    //
    self.navigationController.navigationBar.hidden = YES;
    
    //自定义导航栏
    UINavigationBar *bar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    
    [self.view addSubview:bar];
    
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    
    [leftButton setImage:[UIImage imageNamed:@"nav_arrow.png"]forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(leftButton_Action:) forControlEvents:UIControlEventTouchUpInside];
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc]initWithTitle:@"登录"];
    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [bar pushNavigationItem:navigationItem animated:YES];
    
    
}


#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    

    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [UITableViewCell new];;
    
}





-(void)leftButton_Action:(UIButton *)sender{
    
    
    if (self.navigationController.viewControllers.count >1) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
