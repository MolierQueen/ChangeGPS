//
//  AssetsCell.h
//  ChangeGPS
//
//  Created by 柴犬的Mini on 2021/8/2.
//

#import <UIKit/UIKit.h>
@class PHAssetCollection;
#define ItemWidth (SCREEN_WIDTH - 48) / 2
#define ItemHeightFroAlbutmType ItemWidth *1.5
#define ItemHeightFroAssetsType ItemWidth
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AssetsCellType) {
    AssetsCellType_Album,
    AssetsCellType_Assets,
};

@interface AssetsCell : UICollectionViewCell

/// 配置Cell
/// @param collection 相册
- (void) configCellWith:(PHAssetCollection *)collection;
@end

NS_ASSUME_NONNULL_END
