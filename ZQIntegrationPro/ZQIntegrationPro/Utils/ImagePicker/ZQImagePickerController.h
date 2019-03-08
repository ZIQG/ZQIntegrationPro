//
//  ZQImagePickerController.h
//  PursuitNetworkPro
//
//  Created by hzq on 2018/11/24.
//  Copyright © 2018年 hzq. All rights reserved.
//

#import "TZImagePickerController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZQImagePickerController : TZImagePickerController

+ (instancetype)showWithMaxImagesCount:(NSInteger)maxImagesCount controller:(UIViewController *)controller finishPickingPhotosHandle:(void(^)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto))handle;

@end

NS_ASSUME_NONNULL_END
