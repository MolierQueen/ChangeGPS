//
//  CommonHelper.h
//  ChangeGPS
//
//  Created by 柴犬的Mini on 2021/8/2.
//

#import <Foundation/Foundation.h>

#import <Masonry/Masonry.h>
#import <Photos/Photos.h>
#import <Photos/PHImageManager.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <CoreLocation/CoreLocation.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface CommonHelper : NSObject

/// 展示提示
/// @param title 标题
+ (void) showHUDWith:(NSString *)title;

/// 展示loading
/// @param title 标题
+ (MBProgressHUD *) showLoadingHUDWith:(NSString *)title;

/// 获取底部安全距离
+ (CGFloat)safeAreaBottom;

/// 获取顶部安全距离
+ (CGFloat)safeAreaTop;

/// 加载相册
+ (NSMutableArray<PHAssetCollection *> *)loadAlbumDate;
@end

NS_ASSUME_NONNULL_END
