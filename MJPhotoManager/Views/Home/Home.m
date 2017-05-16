//
//  Home.m
//  MJPhotoManager
//
//  Created by 马家俊 on 17/5/16.
//  Copyright © 2017年 MJJ. All rights reserved.
//

#import "Home.h"
#import "HomeCellCollectionViewCell.h"
@interface Home()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) IBOutlet UICollectionView* m_homeCollectionView;

@end
@implementation Home
@synthesize p_homeDelegate = m_homeDelegate;

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

-(void)refreshHomeView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(self.frame.size.width, 100);
    self.m_homeCollectionView.backgroundColor = [UIColor clearColor];
//    [self.m_homeCollectionView registerClass:[HomeCellCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCellId"];
    self.m_homeCollectionView.delegate = self;
    self.m_homeCollectionView.dataSource = self;
}
#pragma Mark    --ColloctionView Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCellCollectionViewCell *cell = (HomeCellCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCellId" forIndexPath:indexPath];
    cell.homeCellLab.text = [NSString stringWithFormat:@"20170517"];
    
    cell.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width/2-20, self.frame.size.width/2-20);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}
@end
