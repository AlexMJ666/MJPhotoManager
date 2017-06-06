//
//  HomeViewController.m
//  MJPhotoManager
//
//  Created by 马家俊 on 17/5/16.
//  Copyright © 2017年 MJJ. All rights reserved.
//

#import "HomeViewController.h"
#import "Home.h"
#import <Photos/Photos.h>
@interface HomeViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong) IBOutlet Home* m_home;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.m_home refreshHomeView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addPhotoFromSystem:(id)sender
{
//    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
//    }
//    pickerImage.delegate = self;
//    pickerImage.allowsEditing = NO;
//    [self presentViewController:pickerImage animated:YES completion:^{
//        
//    }];
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusRestricted||status == PHAuthorizationStatusDenied) {
        NSLog(@"无访问权限");
    }else
    {
        NSLog(@"可以访问相册");
    }
    
    NSMutableArray* alubms = [NSMutableArray new];
    PHFetchOptions *fetchOptions =[[PHFetchOptions alloc]init];
    PHFetchResult *smartAlbumsFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:fetchOptions];
    [alubms addObject:[smartAlbumsFetchResult objectAtIndex:0]];
    PHFetchResult *smartAlbumsFetchResult1 = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:fetchOptions];//注意类型
    for(PHAssetCollection *sub in smartAlbumsFetchResult1){    //遍历到数组中
        [alubms addObject:sub];
    }

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
