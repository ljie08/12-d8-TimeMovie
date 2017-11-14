//
//  HomeViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/10/10.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewModel.h"
#import <CoreLocation/CoreLocation.h>
#import "MainHomeCell.h"
#import "MoviePageViewController.h"
#import "MovieDetailViewController.h"

@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, RefreshCollectionViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) LLRefreshCollectionView *mainCollection;
//@property (nonatomic, strong) UICollectionView *mainCollection;
@property (nonatomic, strong) HomeViewModel *viewmodel;

@property (nonatomic, strong) NSString *cityNameStr;//当前城市
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *localCity;//定位到的城市
@property (nonatomic, strong) NSString *localCityID;//定位到的城市id

@property (nonatomic, assign) BOOL hasData;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hasData = NO;
    [self startLocationCity];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[HomeViewModel alloc] init];
    [self loadData];
}

//- (void)loadCities {
//    @weakSelf(self);
//    [self.viewmodel getCitySuccess:^(BOOL result) {
//        weakSelf.localCityID = [weakSelf.viewmodel getLocalCityIDWithCityName:weakSelf.cityNameStr];
//
//        [weakSelf loadDataRefresh:YES];
//    } failure:^(NSString *errorStr) {
//        [weakSelf showMassage:errorStr];
//    }];
//}

- (void)loadData {
    @weakSelf(self);
    [weakSelf showWaiting];
    [self.viewmodel getMovieWithSuccess:^(BOOL result) {
        [weakSelf hideWaiting];
        
        if (weakSelf.viewmodel.movieArr.count) {
            [weakSelf.mainCollection dismissNoView];
            weakSelf.hasData = YES;
        } else {
            weakSelf.hasData = NO;
            [weakSelf.mainCollection showNoView:@"没有数据，刷新试试吧" image:nil certer:CGPointZero];
        }
        
        [weakSelf.mainCollection reloadData];
        
    } failure:^(NSString *errorStr) {
        [weakSelf hideWaiting];
        if (!weakSelf.hasData) {
            [weakSelf.mainCollection showNoView:@"加载失败，刷新试试" image:nil certer:CGPointZero];
        } else {
            [weakSelf.mainCollection dismissNoView];
        }
        [weakSelf showMassage:errorStr];
    }];
}

#pragma mark - 跳转
- (void)gotoHotVC {
    MoviePageViewController *movie = [[MoviePageViewController alloc] init];
    [self.navigationController pushViewController:movie animated:YES];
}

#pragma mark - refresh
- (void)refreshCollectionViewHeader {
    //    [self loadDataRefresh:YES];
    [self loadData];
}

#pragma mark - collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //        return 10;
    return self.viewmodel.movieArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(Screen_Width, CGFLOAT_MIN);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(Screen_Width, CGFLOAT_MIN);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainHomeCell" forIndexPath:indexPath];
    if (self.viewmodel.movieArr.count) {
        [cell setDataWithModel:self.viewmodel.movieArr[indexPath.row]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieDetailViewController *movie = [[MovieDetailViewController alloc] init];
    Movie *model = self.viewmodel.movieArr[indexPath.row];
    movie.movieId = model.movieId;
    
    [self.navigationController pushViewController:movie animated:YES];
}


#pragma mark - 定位
//开始定位
- (void)startLocationCity {
    if ([CLLocationManager locationServicesEnabled]){
        //        CLog(@"--------开始定位");
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self; //控制定位精度,越高耗电量越
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer; // 总是授权
        //        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        
        if (IOS8_OR_LATER) {
            //使用应用程序期间允许访问位置数据
            [self.locationManager requestWhenInUseAuthorization];
        }
        
        [self.locationManager startUpdatingLocation];
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        [self showMassage:@"访问被拒绝"];
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        [self showMassage:@"无法获取位置信息"];
        NSLog(@"无法获取位置信息");
    }
}
//定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self showWaitingWithMessage:@"定位中"];
    
    CLLocation *newLocation = locations[0];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            //获取城市
            self.cityNameStr = placemark.locality;
            self.cityNameStr = [self.cityNameStr stringByReplacingOccurrencesOfString:@"市" withString:@""];
            
            if (!self.cityNameStr) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                self.cityNameStr = placemark.administrativeArea;
            }
            NSLog(@"city定位城市 %@", self.cityNameStr);
            
            //            self.cityNameStr = [LJUtil currentLanguageIsChinese]
            
            //定位成功，获取城市的id，更新导航栏显示的城市
            //            [self loadCities];
            [self setNav];
            [self hideWaiting];
            [self showMassage:@"定位成功"];
            
        } else if (error == nil && [array count] == 0) {
            NSLog(@"No results were returned.");
            [self hideWaiting];
            [self showMassage:@"No results were returned."];
        } else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
            [self hideWaiting];
            [self showMassage:error.localizedDescription];
        }
    }];
    [self hideWaiting];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}


#pragma mark - ui
- (void)initUIView {
    //    [self setBackButton:YES];
    [self initTitleViewWithTitle:NSLocalizedString(@"大家都在看", nil)];
    
    [self setCollectionviewLayout];
    [self setNav];
}

//collectionview相关
- (void)setCollectionviewLayout {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //    flow.minimumLineSpacing = 10;
    //    flow.minimumInteritemSpacing = 10;
    
    CGFloat width = (Screen_Width-40)/2;
    flow.itemSize = CGSizeMake(width, width*9/5);
    
    self.mainCollection = [[LLRefreshCollectionView alloc] initWithFrame:CGRectMake(10, 0, Screen_Width-20, Screen_Height-64) collectionViewLayout:flow];
    NSLog(@"%f", self.mainCollection.frame.size.height);
    self.mainCollection.backgroundColor = [UIColor clearColor];
    self.mainCollection.delegate = self;
    self.mainCollection.dataSource = self;
    
    self.mainCollection.refreshCDelegate = self;
    self.mainCollection.CanRefresh = YES;
    self.mainCollection.isShowMore = NO;
    self.mainCollection.lastUpdateKey = NSStringFromClass([self class]);
    
    self.mainCollection.showsHorizontalScrollIndicator = NO;
    self.mainCollection.showsVerticalScrollIndicator = NO;
    [self.mainCollection registerNib:[UINib nibWithNibName:@"MainHomeCell" bundle:nil] forCellWithReuseIdentifier:@"MainHomeCell"];
    [self.view addSubview:self.mainCollection];
}

- (void)setNav {
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 100, 30);
    
    [leftBtn setTitle:self.cityNameStr.length?self.cityNameStr:@"定位" forState:UIControlStateNormal];
    
    UIImage *leftImg = [UIImage imageNamed:@"location"];
    leftImg = [leftImg imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
    
    [leftBtn setImage:leftImg forState:UIControlStateNormal];
    [leftBtn setTintColor:WhiteColor];
    
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -leftBtn.imageView.frame.size.width-5, 0, leftBtn.imageView.frame.size.width)];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, leftBtn.titleLabel.frame.size.width, 0, -leftBtn.titleLabel.frame.size.width)];
    
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    [leftBtn addTarget:self action:@selector(startLocationCity) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn setImage:[UIImage imageNamed:@"something"] forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    [rightBtn addTarget:self action:@selector(gotoHotVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    [self addNavigationWithTitle:nil leftItem:leftItem rightItem:rightItem titleView:nil];
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

