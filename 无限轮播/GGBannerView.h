//
//  GGBannerView.h
//  无限轮播
//
//  Created by GG on 16/6/2.
//  Copyright © 2016年 GG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GGBannerViewDelegate <NSObject>

- (void)bannerViewCurrentPage:(NSInteger)currentPage;

@end

@interface GGBannerView : UIView

@property (nonatomic,weak) id <GGBannerViewDelegate> delegate;

@property (nonatomic,strong) NSArray *sourceArray;

@property (nonatomic,assign) BOOL isTimer;

@end
