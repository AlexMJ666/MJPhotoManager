//
//  Home.h
//  MJPhotoManager
//
//  Created by 马家俊 on 17/5/16.
//  Copyright © 2017年 MJJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeDelegate <NSObject>

@end
@interface Home : UIView
{
    __weak id<HomeDelegate> m_homeDelegate;
}
@property (nonatomic, weak) id<HomeDelegate> p_homeDelegate;

-(void)refreshHomeView;
@end
