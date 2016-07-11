//
//  GGBannerView.m
//  无限轮播
//
//  Created by GG on 16/6/2.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "GGBannerView.h"


#define kMaxSection 100

#define kNoTouchTime 2


@interface GGBannerView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    
    UIPageControl *pageControl;
    
    NSTimer *timer;
    
    UICollectionViewFlowLayout *layout;
}
@end

@implementation GGBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupCollectView:frame];
        
        [self setupPageControl:frame];
    }
    return self;
}

#pragma  mark private method
- (void)nextPage{
    
    NSIndexPath *currentIndexPath = [_collectionView.indexPathsForVisibleItems lastObject];
    
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:kMaxSection/2];
    
    [_collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = currentIndexPath.item+1;
    
    NSInteger nextSection = currentIndexPathReset.section;
    
    if (nextItem == self.sourceArray.count) {
        
        nextItem = 0;
        nextSection++;
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    [_collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}
- (void)click{
    
    if ([self.delegate respondsToSelector:@selector(bannerViewCurrentPage:)]) {
        
        [self.delegate bannerViewCurrentPage:pageControl.currentPage];
        
    }
    
}

#pragma mark layoutUI

- (void)setupPageControl:(CGRect)frame{
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,frame.size.height-20, frame.size.width, 20)];
    
    [self addSubview:pageControl];
    
}

- (void)setupCollectView:(CGRect)frame{
    
    layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.delegate =self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];

    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    
    //监听九宫格的点击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    
    [_collectionView addGestureRecognizer:tap];
    
}



#pragma mark UICollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return kMaxSection;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.sourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.sourceArray[indexPath.item]]];
    
    return cell;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    timer.fireDate = [NSDate distantFuture];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int page = (int) (scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.sourceArray.count;
    pageControl.currentPage =page;
}




#pragma mark lazyload

- (void)setSourceArray:(NSArray *)sourceArray{
    
    _sourceArray = sourceArray;
    
    pageControl.numberOfPages = self.sourceArray.count;
    
    [_collectionView reloadData];
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:kMaxSection/2] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)setIsTimer:(BOOL)isTimer{
    
    _isTimer = isTimer;
    
    if (_isTimer == YES) {
        
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        
        
    }
}
-(void)setFrame:(CGRect)frame{
    
    
    [super setFrame:frame];
    
    _collectionView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    layout.itemSize = frame.size;
    
    pageControl.frame = CGRectMake(0, frame.size.height-20, frame.size.width, 20);
    
    
    [_collectionView reloadData];
}


- (void)dealloc{
    
    [timer invalidate];
    
    timer = nil;
}
@end

