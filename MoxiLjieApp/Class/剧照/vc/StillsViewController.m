//
//  StillsViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "StillsViewController.h"
#import "StillsCell.h"
#import "StillsViewModel.h"

@interface StillsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, RefreshCollectionViewDelegate>

@property (nonatomic, strong) LLRefreshCollectionView *stillsCollection;
@property (nonatomic, strong) StillsViewModel *viewmodel;

@property (nonatomic, strong) UIView *picBgview;
@property (nonatomic, strong) UIImageView *picview;

@property (nonatomic, assign) BOOL hasData;

@end

@implementation StillsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hasData = NO;
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[StillsViewModel alloc] init];
    [self loadData];
}

- (void)loadData {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getStillsListWithMovieID:self.movieID success:^(BOOL result) {
        [weakSelf hideWaiting];
        if (weakSelf.viewmodel.stillsArr.count) {
            [weakSelf.stillsCollection dismissNoView];
            weakSelf.hasData = YES;
        } else {
            weakSelf.hasData = NO;
            [weakSelf.stillsCollection showNoView:@"没有数据，刷新试试吧" image:nil certer:CGPointZero];
        }
        [weakSelf.stillsCollection reloadData];
    } failure:^(NSString *errorStr) {
        [weakSelf hideWaiting];
        if (!weakSelf.hasData) {
            [weakSelf.stillsCollection showNoView:@"加载失败，刷新试试" image:nil certer:CGPointZero];
        } else {
            [weakSelf.stillsCollection dismissNoView];
        }
        [weakSelf showMassage:errorStr];
    }];
    
}

#pragma mark - refresh
- (void)refreshTableViewHeader {
    [self loadData];
}

- (void)refreshTableViewFooter {
    [self loadData];
}

#pragma mark - collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewmodel.stillsArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(Screen_Width, CGFLOAT_MIN);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(Screen_Width, CGFLOAT_MIN);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StillsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StillsCell" forIndexPath:indexPath];
    if (self.viewmodel.stillsArr.count) {
        [cell setStillDataWithModel:self.viewmodel.stillsArr[indexPath.row]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Stills *model = self.viewmodel.stillsArr[indexPath.row];
    
    NSData *imgdata = [NSData  dataWithContentsOfURL:[NSURL URLWithString:model.image]];
    UIImage *myimage =  [UIImage imageWithData:imgdata];
    
    self.picBgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    self.picBgview.tag = 161219;
    self.picBgview.backgroundColor = MyColor;
    [CurrentKeyWindow addSubview:self.picBgview];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(picdismiss)];
    [self.picBgview addGestureRecognizer:tap];
    
    CGFloat height = myimage.size.height*Screen_Width/myimage.size.width;
    //
    self.picview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.picview.center = CurrentKeyWindow.center;
    self.picview.tag = 161226;
    [UIView animateWithDuration:0.5 animations:^{
        self.picview.frame= CGRectMake(0, 0, Screen_Width, height);
        self.picview.center = CurrentKeyWindow.center;
    }];
    [self.picview sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:SmallPlaceholderImage];
    //    UILongPressGestureRecognizer *serv= [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressImageView:)];
    //    imageView.alpha = 1;
    //    [bgview addGestureRecognizer:serv];
    [self.picBgview addSubview:self.picview];
}

- (void)picdismiss {
    [UIView animateWithDuration:0.5 animations:^{
        self.picview.frame = CGRectMake(0, 0, 0, 0);
        self.picview.center = CurrentKeyWindow.center;
    } completion:^(BOOL finished) {
        [self.picBgview removeFromSuperview];
    }];
}

#pragma mark - ui
- (void)initUIView {
    [self setBackButton:YES];
    self.view.backgroundColor = MyColor;
    [self initTitleViewWithTitle:NSLocalizedString(@"剧照&海报", nil)];
    
    [self setCollectionviewLayout];
}

//collectionview相关
- (void)setCollectionviewLayout {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //    flow.minimumLineSpacing = 10;
    //    flow.minimumInteritemSpacing = 10;
    
    CGFloat width = (Screen_Width-20)/2;
    flow.itemSize = CGSizeMake(width, width);
    
    self.stillsCollection = [[LLRefreshCollectionView alloc] initWithFrame:CGRectMake(5, 0, Screen_Width-10, Screen_Height-64) collectionViewLayout:flow];
    NSLog(@"%f", self.stillsCollection.frame.size.height);
    self.stillsCollection.backgroundColor = MyColor;
    self.stillsCollection.delegate = self;
    self.stillsCollection.dataSource = self;
    
    self.stillsCollection.refreshCDelegate = self;
    self.stillsCollection.CanRefresh = YES;
    self.stillsCollection.isShowMore = NO;
    self.stillsCollection.lastUpdateKey = NSStringFromClass([self class]);
    
    self.stillsCollection.showsHorizontalScrollIndicator = NO;
    self.stillsCollection.showsVerticalScrollIndicator = NO;
    [self.stillsCollection registerNib:[UINib nibWithNibName:@"StillsCell" bundle:nil] forCellWithReuseIdentifier:@"StillsCell"];
    [self.view addSubview:self.stillsCollection];
}

#pragma mark - dealloc
- (void)dealloc {
    [self.viewmodel cancelAllHTTPRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

