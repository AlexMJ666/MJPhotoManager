//
//  ViewController.m
//  MJPhotoManager
//
//  Created by Mac on 2017/11/17.
//  Copyright © 2017年 MJJ. All rights reserved.
//

#import "ViewController.h"
#import "MJPhoto.h"
#import <UIImageView+WebCache.h>
@interface ViewController ()
@property(nonatomic,strong) UIImageView* m_mapImg;
@end

@implementation ViewController
@synthesize m_mapImg;
- (void)viewDidLoad {
    [super viewDidLoad];
    m_mapImg = [UIImageView new];
    m_mapImg.frame = CGRectMake(0, 20, 200, 220);
    m_mapImg.contentMode =  UIViewContentModeScaleAspectFill;
    m_mapImg.clipsToBounds  = YES;
    [m_mapImg setContentScaleFactor:[[UIScreen mainScreen] scale]];
    m_mapImg.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [m_mapImg setImage:[UIImage imageNamed:@"5"]];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(press)];
    m_mapImg.userInteractionEnabled = YES;
    [m_mapImg sd_setImageWithURL:[NSURL URLWithString:@"http://www.afwing.com/d/file/aircraft/usa/old-fighter/d39b51cdef465a5e0b1df18886c1cb1b.jpg"] placeholderImage:nil];
    [m_mapImg addGestureRecognizer:recognizer];
    [self.view addSubview:m_mapImg];
    // Do any additional setup after loading the view.
}

-(void)press
{
    NSMutableArray* mutable = [[NSMutableArray alloc]init];
    [mutable addObject:[NSURL URLWithString:@"http://www.afwing.com/d/file/aircraft/usa/old-fighter/d39b51cdef465a5e0b1df18886c1cb1b.jpg"]];
    [mutable addObject:[NSURL URLWithString:@"http://cdn.scratch.mit.edu/static/site/projects/thumbnails/1784/6634.png"]];
    MJPhoto* photo = [[MJPhoto alloc]initWithFrame:self.view.bounds];
    //[photo initImg:m_mapImg andSuperView:self.view andPosition:kPutItInWindow];
    [photo initImag:mutable andFirstImageView:m_mapImg andSuperView:self.view andPosition:kPutItInWindow];
    [self.view addSubview:photo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BillDetailDelegate
-(void)pressImg:(NSString*)url andImageView:(UIImageView*)imgV
{
    
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
