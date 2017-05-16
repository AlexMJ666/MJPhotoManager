//
//  Home.m
//  MJPhotoManager
//
//  Created by 马家俊 on 17/5/16.
//  Copyright © 2017年 MJJ. All rights reserved.
//

#import "Home.h"

@interface Home()
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
