//
//  UserGuideViewController.m
//  lihuibang
//
//  Created by Jin on 15/12/10.
//  Copyright (c) 2015年 jsyh. All rights reserved.
//启动页

#import "UserGuideViewController.h"
#import "UIColor+Hex.h"
#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "H5ViewController.h"
//#define imagViewNo 3
@interface UserGuideViewController ()<UIScrollViewDelegate>
{
    UIPageControl *pageCtr;
    
}


@property (nonatomic,strong) NSMutableArray <NSURL *> *urlArray;

@property(nonatomic,strong)UIViewController *rootViewController;

@end

@implementation UserGuideViewController


-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    
    self = [super init];

    if (self) {
        
        _rootViewController = rootViewController;
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.urlArray = [NSMutableArray new];
    
    
    [self requestData];
    
}


-(void)requestData{
    
    
    [[Ditiy_NetAPIManager sharedManager]request_WelcomeGuidePicBlock:^(id data, NSError *error) {
        
        if (data) {
            
            NSArray *arr = data[@"data"];
            
            for (int i =0; i < arr.count; i++) {
                
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",baseURLStr,arr[i]]];\
                
                [self.urlArray addObject:url];
                
                [self initViews];
                
                
            }
            
        }
        
        
        
        
        
    }];
    
}

-(void)initViews{
    
    NSUInteger imagViewNo = self.urlArray.count;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    scrollView.delegate = self;
    [scrollView setContentSize:CGSizeMake(kScreenWidth*imagViewNo, 0)];
    [scrollView setPagingEnabled:YES];  //视图整页显示
    //    [scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
    
    
    for (int i = 0; i < imagViewNo; i++) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
        
        imageview.userInteractionEnabled = YES;    //打开imageview3的用户交互;否则下面的button无法响应
        scrollView.userInteractionEnabled = YES;
        [scrollView addSubview:imageview];
        
        if (i == imagViewNo -1) {
            UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [button1 setTitle:@"立即进入" forState:UIControlStateNormal];
            button1.frame = CGRectMake(20, kScreenHeight - 80, kScreenWidth - 40  , 40);
            [button1 addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
            button1.backgroundColor = [UIColor whiteColor];
            [button1 setTitleColor:RGB(0xff, 0x49, 0x81) forState:UIControlStateNormal];
            [imageview addSubview:button1];
            
        }
        
        [imageview sd_setImageWithURL:self.urlArray[i] placeholderImage:[UIImage imageNamed:@"loading1"]];
        
    }
    
    scrollView.showsVerticalScrollIndicator = FALSE;
    scrollView.showsHorizontalScrollIndicator = FALSE;
    [self.view addSubview:scrollView];
    pageCtr = [[UIPageControl alloc]initWithFrame:CGRectMake(50, kScreenHeight-40, kScreenWidth-100, 20)];
    pageCtr.currentPage = 0;
    pageCtr.numberOfPages = imagViewNo;
    pageCtr.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self.view addSubview:pageCtr];
    
    
}
-(void)push:(id)sender{

    
    [UIView animateWithDuration:0.5 animations:^{
      
        if (_rootViewController) {
            
            [UIApplication sharedApplication].keyWindow.rootViewController = _rootViewController;
        }
        
    }];
    
    
    
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
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    pageCtr.currentPage = scrollView.contentOffset.x/kScreenWidth;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
@end
