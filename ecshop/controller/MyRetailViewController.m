//
//  MyRetailViewController.m
//  ecshop
//
//  Created by 吴狄 on 2017/2/5.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "MyRetailViewController.h"

@interface MyRetailViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *myWebView;
@property (nonatomic,strong) UIButton *backButton;
@end

@implementation MyRetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initViews];
}


-(void)initViews{
    
    _myWebView = ({
        
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        [webView loadRequest:[[NSURLRequest alloc]initWithURL:[[NSURL alloc]initWithString:retailURLStr]]];
        
        webView.delegate = self;
        
        [self.view addSubview:webView];
        
        webView;
    });
    
    
    
    _backButton = ({
        
        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        
        UIImage *img = [UIImage imageNamed:@"back.png"];
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 20, 20)];
        imgView.image = img;
        [backButton addSubview:imgView];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:backButton];
        
        backButton;
    });
    
    
    
}


-(void)backAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- UIWebViewDelegate -- start

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    
    NSString *absoluteString = request.URL.absoluteString;
    
    if ([absoluteString containsString:retailURLStr]) {
        
        self.backButton.hidden  = NO;
        
    }else{
        
        self.backButton.hidden  = YES;
    }
    
    
    return YES;
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

#pragma mark -- UIWebViewDelegate -- end 

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
