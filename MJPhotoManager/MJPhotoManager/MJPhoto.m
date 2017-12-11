//
//  MJPhoto.m
//  MJPhotoManager
//
//  Created by Mac on 2017/11/17.
//  Copyright © 2017年 MJJ. All rights reserved.
//

#import "MJPhoto.h"
#import <MBProgressHUD.h>
#import <UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>

#define kMaxSCale 3.0  //最大缩放比例
#define kMinScale 1.0  //最小缩放比例
#define kMainScreen_Height [UIScreen mainScreen].bounds.size.height
#define kMainScreen_Width [UIScreen mainScreen].bounds.size.width

@interface MJPhoto()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    CGRect orginRect;
    UIScrollView* m_scrollView;
    UIPanGestureRecognizer* panGes;
}
@property (nonatomic,assign) CGFloat totalScale;
@property (nonatomic,strong) UIScrollView* p_scrollView;
@property (nonatomic,strong) UIPageControl* pageControl;
@end

@implementation MJPhoto
@synthesize readyForZoomImg;
@synthesize p_scrollView = m_scrollView;

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0;
        self.p_scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height)];
        self.backgroundColor = [UIColor blackColor];
        self.p_scrollView.scrollEnabled = YES;
        self.p_scrollView.bounces = YES;
        self.p_scrollView.delegate = self;
        self.p_scrollView.pagingEnabled = YES;
        self.p_scrollView.userInteractionEnabled = YES;
        self.p_scrollView.contentSize = CGSizeMake(kMainScreen_Width, kMainScreen_Height);
        self.p_scrollView.minimumZoomScale = kMinScale;
        self.p_scrollView.maximumZoomScale = kMaxSCale;
        [self addSubview:self.p_scrollView];
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(kMainScreen_Width/2-50, kMainScreen_Height-64, 100, 20);//指定位置大小
        [self addSubview:_pageControl];
        
    }
    return self;
}

-(void)initImag:(NSMutableArray*)smallImgArrays andFirstImageView:(UIImageView*)smallImgV andSuperView:(UIView*)superV andPosition:(MJPhotoBrowerPosition)position
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    self.p_scrollView.contentSize = CGSizeMake( kMainScreen_Width*smallImgArrays.count, kMainScreen_Height);
    _pageControl.numberOfPages = smallImgArrays.count;
    switch (position) {
        case kPutItInWindow:
            orginRect =[smallImgV convertRect: smallImgV.bounds toView:window];
            break;
        case kPutItInView:
            orginRect =[smallImgV convertRect: smallImgV.bounds toView:superV];
            break;
        default:
            break;
    }
    
    if (!readyForZoomImg) {
        readyForZoomImg = [[UIImageView alloc]initWithFrame:orginRect];
        readyForZoomImg.image = smallImgV.image;
        readyForZoomImg.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
        readyForZoomImg.userInteractionEnabled = YES;
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carImgTap:)];
        
        //点击的次数
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [readyForZoomImg addGestureRecognizer:singleRecognizer];
        [self.p_scrollView addSubview:readyForZoomImg];
    }
    [self  touchSmallImg:readyForZoomImg];
    
    for (int i = 1; i < smallImgArrays.count; i++) {
        UIImageView* tempImg = [[UIImageView alloc]initWithFrame:CGRectMake(kMainScreen_Width*i, kMainScreen_Height/2-9*kMainScreen_Width/32.0f, kMainScreen_Width, 9*kMainScreen_Width/16.0f)];
        tempImg.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
        tempImg.userInteractionEnabled = YES;
        [tempImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",smallImgArrays[i]]] placeholderImage:nil];
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carImgTap:)];
        //点击的次数
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [tempImg addGestureRecognizer:singleRecognizer];
        [self.p_scrollView addSubview:tempImg];
    }
}

-(void)initImg:(UIImageView*) smallImgV andSuperView:(UIView*)superV andPosition:(MJPhotoBrowerPosition)position
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    switch (position) {
        case kPutItInWindow:
            orginRect =[smallImgV convertRect: smallImgV.bounds toView:window];
            break;
        case kPutItInView:
            orginRect =[smallImgV convertRect: smallImgV.bounds toView:superV];
            break;
        default:
            break;
    }
    
    if (!readyForZoomImg) {
        readyForZoomImg = [[UIImageView alloc]initWithFrame:orginRect];
        readyForZoomImg.image = smallImgV.image;
        readyForZoomImg.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
        readyForZoomImg.userInteractionEnabled = YES;
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carImgTap:)];
        //点击的次数
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [readyForZoomImg addGestureRecognizer:singleRecognizer];
        [self.p_scrollView addSubview:readyForZoomImg];
    }
    [self touchSmallImg:readyForZoomImg];
    [window addSubview:self];
}

-(void)touchSmallImg:(UIImageView*)imgV
{
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 1;
        [imgV setFrame:CGRectMake(0, 0, kMainScreen_Width, 9*kMainScreen_Width/16.0f)];
        imgV.center = self.center;
    }];
}

//缩放过程中的图像
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    for(UIView* subView in scrollView.subviews)
    {
        return subView;
    }
    return nil;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    [readyForZoomImg setCenter:CGPointMake(xcenter, ycenter)];
}
//缩放结束
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
}

//缩放中
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = page;
}

-(void)carImgTap:(UIGestureRecognizer*)ges
{
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
