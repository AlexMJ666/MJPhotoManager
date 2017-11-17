//
//  MJPhoto.h
//  MJPhotoManager
//
//  Created by Mac on 2017/11/17.
//  Copyright © 2017年 MJJ. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    kPutItInView,
    kPutItInWindow,
} MJPhotoBrowerPosition;
@interface MJPhoto : UIView
{
    UIImageView* readyForZoomImg;
}
@property(nonatomic,strong) UIImageView* readyForZoomImg;

/**
 单张图片

 @param smallImgV 原始图
 @param superV 父视图
 @param position 位置
 */
-(void)initImg:(UIImageView*) smallImgV andSuperView:(UIView*)superV andPosition:(MJPhotoBrowerPosition)position;


/**
 多张图片

 @param smallImgArrays 图片url数组
 @param smallImgV 原始图
 @param superV 父视图
 @param position 位置
 */
-(void)initImag:(NSMutableArray*)smallImgArrays andFirstImageView:(UIImageView*)smallImgV andSuperView:(UIView*)superV andPosition:(MJPhotoBrowerPosition)position;
@end
