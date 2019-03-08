//
//  ZQImagePickerController.m
//  PursuitNetworkPro
//
//  Created by GTLand on 2018/11/24.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import "ZQImagePickerController.h"

@interface ZQImagePickerController ()

@end

@implementation ZQImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (instancetype)showWithMaxImagesCount:(NSInteger)maxImagesCount controller:(UIViewController *)controller finishPickingPhotosHandle:(void(^)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto))handle {
    ZQImagePickerController *imagePickerVc = [[ZQImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    imagePickerVc.allowTakeVideo = NO;
    [imagePickerVc setDidFinishPickingPhotosHandle:handle];
    [controller presentViewController:imagePickerVc animated:YES completion:nil];
    return imagePickerVc;
}
    

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
