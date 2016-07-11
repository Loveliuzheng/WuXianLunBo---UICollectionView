//
//  ViewController.m
//  无限轮播
//
//  Created by GG on 16/6/3.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "ViewController.h"
#import "GGBannerView.h"
@interface ViewController ()<GGBannerViewDelegate>{
    
    GGBannerView *bannerView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    UIBarButtonItem *delete = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self  action:@selector(clickBtn)];
    
    UIBarButtonItem *Add = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self  action:@selector(clickBtm)];
    
    self.navigationItem.rightBarButtonItems =@[delete];
    
    self.navigationItem.leftBarButtonItems =@[Add];
    
    
    //给tableView设置一个跟轮播图同样高的表头，避免cell显示在轮播图上面
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    view.userInteractionEnabled = NO;
    
    bannerView = [[GGBannerView alloc]initWithFrame:CGRectMake(0,-64, 414, 200)];
    
    bannerView.isTimer = YES;
    bannerView.delegate =self;
    
    bannerView.sourceArray = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    
    [self.tableView addSubview:bannerView];
    
}

-(void)clickBtn{
    
    
    
}
-(void)clickBtm{
    
    
}
- (void)bannerViewCurrentPage:(NSInteger)currentPage{
    
    NSLog(@"%ld",currentPage);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y<0) {
        
        
        CGRect initFrame = bannerView.frame;
        
        initFrame.origin.y = scrollView.contentOffset.y;
        
        initFrame.size.height = 200 - scrollView.contentOffset.y;
        
        bannerView.frame = initFrame;
        
        
         }
   }
@end
