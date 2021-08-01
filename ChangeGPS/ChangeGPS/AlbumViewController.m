//
//  AlbumViewController.m
//  ChangeGPS
//
//  Created by 柴犬的Mini on 2021/8/1.
//

#import "AlbumViewController.h"
#import "CommonHelper.h"
#import "AssetsCell.h"
#import "AssetsViewController.h"

@interface AlbumViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *mainCollection;
@property (nonatomic, strong) NSMutableArray<PHAssetCollection *> *albumDataSource;
@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.albumDataSource = [NSMutableArray arrayWithArray:[CommonHelper loadAlbumDate]];
    
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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(ItemWidth, ItemHeightFroAlbutmType);
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
        make.top.mas_equalTo(backBtn.mas_bottom).offset(16);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.bottom.mas_equalTo(-[CommonHelper safeAreaBottom]);
    }];
}

-(void)backAction:(UIButton *)sender {
    [self  dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <##>collectiionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.albumDataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AssetsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AssetsCell" forIndexPath:indexPath];
    [cell configCellWith:[self.albumDataSource objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AssetsViewController *assets = [[AssetsViewController alloc] init];
    [self presentViewController:assets animated:YES completion:nil];
}

@end
