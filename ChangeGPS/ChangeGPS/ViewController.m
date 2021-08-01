//
//  ViewController.m
//  ChangeGPS
//
//  Created by 柴犬的Mini on 2021/8/1.
//

#import "ViewController.h"
#import "AlbumViewController.h"
#import "CommonHelper.h"

#define LocationViewTitle @"位置信息:"
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) CLLocation *baseLocation;
@property (nonatomic, strong) UITextView *cityName;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backGround.JPG"]];
    [self.view addSubview:backImage];
    [backImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    // 选择基准照片
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *chooseBasePhotoBackView = [[UIVisualEffectView alloc] initWithEffect:blur];
    [self.view addSubview:chooseBasePhotoBackView];
    [chooseBasePhotoBackView.layer setCornerRadius:20];
    [chooseBasePhotoBackView setClipsToBounds:YES];
    [chooseBasePhotoBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo([CommonHelper safeAreaTop] + 10);
        make.leading.mas_equalTo(16);
        make.width.height.mas_equalTo((SCREEN_WIDTH - 48) / 2);
    }];
    UIButton *chooseBasePhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseBasePhotoBackView.contentView addSubview:chooseBasePhoto];
    [chooseBasePhoto mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(chooseBasePhotoBackView);
    }];
    [chooseBasePhoto setTitle:@"Choose Base Photo" forState:UIControlStateNormal];
    [chooseBasePhoto.titleLabel setNumberOfLines:0];
    [chooseBasePhoto setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [chooseBasePhoto.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [chooseBasePhoto addTarget:self action:@selector(basePhototAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIVisualEffectView *changePhotosLocationBackView = [[UIVisualEffectView alloc] initWithEffect:blur];
    [self.view addSubview:changePhotosLocationBackView];
    [changePhotosLocationBackView.layer setCornerRadius:20];
    [changePhotosLocationBackView setClipsToBounds:YES];
    [changePhotosLocationBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.mas_equalTo(chooseBasePhotoBackView);
        make.leading.mas_equalTo(chooseBasePhotoBackView.mas_trailing).offset(16);
    }];
    
    UIButton *changePhotosLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    [changePhotosLocationBackView.contentView addSubview:changePhotosLocation];
    [changePhotosLocation mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(changePhotosLocationBackView);
    }];
    [changePhotosLocation setTitle:@"Chose Photos need location" forState:UIControlStateNormal];
    [changePhotosLocation.titleLabel setNumberOfLines:0];
    [changePhotosLocation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changePhotosLocation.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [changePhotosLocation addTarget:self action:@selector(choosePhototsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.cityName = [[UITextView alloc] init];
    [self.cityName setFont:[UIFont boldSystemFontOfSize:16]];
    [self.cityName setContentInset:UIEdgeInsetsMake(0, 16, 0, 0)];
    [self.cityName setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [self.cityName.layer setCornerRadius:20];
    [self.cityName setTextColor:[UIColor whiteColor]];
    [self.cityName setText:LocationViewTitle];
    [self.view addSubview:self.cityName];
    [self.cityName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(chooseBasePhoto);
        make.trailing.mas_equalTo(changePhotosLocation);
        make.top.mas_equalTo(chooseBasePhoto.mas_bottom).offset(40);
        make.height.mas_equalTo(200);
    }];
}

#pragma mark - 选择照片
- (void)basePhototAction:(UIButton *)sender {
    UIImagePickerControllerSourceType pickerSourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    UIImagePickerController *imagePick =  [[UIImagePickerController alloc] init];
    imagePick.sourceType = pickerSourceType;
    imagePick.delegate = self;
    [self presentViewController:imagePick animated:YES completion:nil];
}

- (void)choosePhototsAction:(UIButton *)sender {
//    if ([self.cityName.text isEqualToString:LocationViewTitle]) {
//        [CommonHelper showHUDWith:@"没有位置信息，请重新选择图片"];
//        return;
//    }
    AlbumViewController *album = [[AlbumViewController alloc] init];
    [self presentViewController:album animated:YES completion:nil];
}

#pragma mark - delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    PHAsset *assets = [info objectForKey:UIImagePickerControllerPHAsset];
    if (assets.location) {
        self.baseLocation = assets.location;
        [self getCity];
    } else {
        [CommonHelper showHUDWith:@"不包含位置信息，轻重新选择"];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    [CommonHelper showHUDWith:@"Canceled..."];
}

- (void)getCity {
    [self.cityName setText:LocationViewTitle];
    MBProgressHUD *loading = [CommonHelper showLoadingHUDWith:@"定位中..."];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:self.baseLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark * placemark in placemarks) {
            NSString *guo = [NSString stringWithFormat:@"\n国家：%@",placemark.country];
            self.cityName.text = [self.cityName.text stringByAppendingString:guo];
            NSString *sheng = [NSString stringWithFormat:@"\n省份：%@",placemark.administrativeArea];
            self.cityName.text = [self.cityName.text stringByAppendingString:sheng];
            NSString *shi = [NSString stringWithFormat:@"\n城市：%@",placemark.locality];
            self.cityName.text = [self.cityName.text stringByAppendingString:shi];
            NSString *qu = [NSString stringWithFormat:@"\n行政区域：%@",placemark.subLocality];
            self.cityName.text = [self.cityName.text stringByAppendingString:qu];
            NSString *zone = [NSString stringWithFormat:@"\n社区：%@",placemark.areasOfInterest.count?placemark.areasOfInterest.firstObject:@""];
            self.cityName.text = [self.cityName.text stringByAppendingString:zone];
            NSString *road = [NSString stringWithFormat:@"\n街道：%@",placemark.thoroughfare];
            self.cityName.text = [self.cityName.text stringByAppendingString:road];
            [loading hideAnimated:YES];
            } if (error == nil && [placemarks count] == 0) {
                 [CommonHelper showHUDWith:@"无法确定当前位置..."];
                [loading hideAnimated:YES];
             } else if (error != nil) {
                 [CommonHelper showHUDWith:@"定位发生错误..."];
                 [loading hideAnimated:YES];
             }
    }];
}
@end
