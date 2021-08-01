//
//  AssetsCell.m
//  ChangeGPS
//
//  Created by 柴犬的Mini on 2021/8/2.
//

#import "AssetsCell.h"
#import "CommonHelper.h"
@interface AssetsCell ()
@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UILabel *albumName;
@property (nonatomic, strong) UILabel *albumPhotoNumber;
@end

@implementation AssetsCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

#pragma mark - 配置UI
- (void)configUI {
    self.photoView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.photoView];
    [self.photoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self.contentView);
        make.width.mas_equalTo(self.photoView.mas_height);
    }];
    [self.photoView setBackgroundColor:[UIColor yellowColor]];
    
    self.albumName = [[UILabel alloc] init];
    [self.contentView addSubview:self.albumName];
    [self.albumName setTextColor:[UIColor whiteColor]];
    [self.albumName setFont:[UIFont systemFontOfSize:14]];
    [self.albumName setText:@"  相册名"];
    [self.albumName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoView.mas_bottom);
        make.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo((self.contentView.frame.size.height - ItemWidth) / 2);
    }];
    
    self.albumPhotoNumber = [[UILabel alloc] init];
    [self.contentView addSubview:self.albumPhotoNumber];
    [self.albumPhotoNumber setTextColor:[UIColor lightGrayColor]];
    [self.albumPhotoNumber setText:@"  100张"];
    [self.albumPhotoNumber setFont:[UIFont systemFontOfSize:12]];
    [self.albumPhotoNumber mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.albumName.mas_bottom);
        make.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo((self.contentView.frame.size.height - ItemWidth) / 2);
    }];
}

#pragma mark - 配置Cell
- (void) configCellWith:(PHAssetCollection *)collection {
    [self.albumName setText:collection.localizedTitle];
    [self.albumPhotoNumber setText:[NSString stringWithFormat:@"%ld",collection.estimatedAssetCount]];
}

@end
