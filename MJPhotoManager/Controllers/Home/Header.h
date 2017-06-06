//
//  Header.h
//  MJPhotoManager
//
//  Created by 马家俊 on 17/6/2.
//  Copyright © 2017年 MJJ. All rights reserved.
//

#ifndef Header_h
#define Header_h
@import UIKit;
@import AssetsLibrary;

#pragma mark -
typedef enum:NSUInteger
{
    //按照选择顺序
    ChoosePhotoQueueTypeDefault = 0,
    //按照相册顺序
    ChoosePhotoQueueTypeDate
} ChoosePhotoQueueType;

#pragma mark -
//选择照片block回调
typedef void (^ImagesBlock)(NSArray <UIImage*>*);

#pragma mark - 
typedef void(^AssetGroupBlock)(NSArray <ALAssetGroup*>*groups);
typedef void(^AssetPhotoBlock)(NSArray <ALAsset*>*photos);
typedef void(^AssetFailBlock) (NSString* error);

typedef void(^PhotoCollectionViewBlock)(void);
#endif /* Header_h */
