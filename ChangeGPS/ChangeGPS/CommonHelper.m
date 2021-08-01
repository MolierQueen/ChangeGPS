//
//  CommonHelper.m
//  ChangeGPS
//
//  Created by 柴犬的Mini on 2021/8/2.
//

#import "CommonHelper.h"
#import "AppDelegate.h"
@implementation CommonHelper

+ (void) showHUDWith:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = title;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1];
}

+ (MBProgressHUD *) showLoadingHUDWith:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = title;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1];
    return hud;
}

//获取底部安全距离
+ (CGFloat)safeAreaBottom {
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        return mainWindow.safeAreaInsets.bottom;
    }
    return 0;
}

//获取顶部安全距离
+ (CGFloat)safeAreaTop {
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        return mainWindow.safeAreaInsets.top;
    }
    return 0;
}

#pragma mark - 加载相册
+ (NSMutableArray <PHAssetCollection *> *)loadAlbumDate {
    // 获得所有的自定义相簿
    NSMutableArray<PHAssetCollection *> *tmpArr = [[NSMutableArray alloc] init];
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    for (PHAssetCollection *assetCollection in assetCollections) {
        [tmpArr addObject:assetCollection];
    }
    
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].firstObject;
    [tmpArr insertObject:cameraRoll atIndex:0];
    return tmpArr;
        // 遍历相机胶卷,获取大图
    //    [self enumerateAssetsInAssetCollection:cameraRoll original:YES];
}

@end
