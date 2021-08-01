//
//  AssetsViewController.m
//  ChangeGPS
//
//  Created by 柴犬的Mini on 2021/8/2.
//

#import "AssetsViewController.h"
#import "AssetsCell.h"
#import "CommonHelper.h"
@interface AssetsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *mainCollection;

@end

@implementation AssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *backView = [[UIVisualEffectView alloc] initWithEffect:blur];
    [self.view addSubview:backView];
    [backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];

    /// 返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backBtn];
    [backBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(16);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(40);
    }];
    [backBtn setTitle:@"  Back  " forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    /// 确定按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:sureBtn];
    [sureBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-16);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(40);
    }];
    [sureBtn setTitle:@"  Next  " forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [sureBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(ItemWidth, ItemHeightFroAssetsType);
    layout.minimumLineSpacing = 16;
    layout.minimumInteritemSpacing = 16;
    self.mainCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.mainCollection setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.mainCollection];
    [self.mainCollection setContentInset:UIEdgeInsetsMake(0, 16, 0, 16)];
    [self.mainCollection registerClass:[AssetsCell class] forCellWithReuseIdentifier:@"AssetsCell"];
    [self.mainCollection setDelegate:self];
    [self.mainCollection setDataSource:self];
    [self.mainCollection mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sureBtn.mas_bottom).offset(16);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.bottom.mas_equalTo(-[CommonHelper safeAreaBottom]);
    }];
}

-(void)backAction:(UIButton *)sender {
    [self  dismissViewControllerAnimated:YES completion:nil];
}

-(void)nextAction:(UIButton *)sender {
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"开始刷新");
    }];
    
    UIAlertAction *cancelActioin = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sure?" message:@"点击确定会更新所选照片的地理位置信息" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:sureAction];
    [alert addAction:cancelActioin];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - <##>collectiionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AssetsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AssetsCell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
