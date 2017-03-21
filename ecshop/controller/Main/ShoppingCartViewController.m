//
//  ShoppingCartViewController.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/13.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "MyTabBarViewController.h"
@interface ShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = true;
    DebugLog(@"");
    
    MyTabBarViewController *myTbVC = (MyTabBarViewController *) self.navigationController.tabBarController;
    [myTbVC hideCustomTabbar:NO];
    
    
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    DebugLog(@"");
    
//    self.navigationController.navigationBar.hidden = false;
//    
//    
//    MyTabBarViewController *myTbVC = (MyTabBarViewController *) self.navigationController.tabBarController;
//    
//    [myTbVC hideCustomTabbar:YES];
}



-(void)initViews{
    

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    

    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
    
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
