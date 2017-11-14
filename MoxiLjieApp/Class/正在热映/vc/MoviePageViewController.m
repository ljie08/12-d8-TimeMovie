//
//  MoviePageViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "MoviePageViewController.h"
#import "MovieViewController.h"
#import "SliderNavBar.h"

@interface MoviePageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource> {
    SliderNavBar *_navbar;//类型滑动控件
}

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *pageArr;//子VC数组
@property (nonatomic, assign) NSInteger currentIndex;//当前页面index

@end

@implementation MoviePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UIPageViewControllerDelegate & UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.pageArr indexOfObject:viewController];
    index --;
    if ((index < 0) || (index == NSNotFound)) {
        return nil;
    }
    return self.pageArr[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.pageArr indexOfObject:viewController];
    index ++;
    if (index >= self.pageArr.count) {
        return nil;
    }
    return self.pageArr[index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        MovieViewController *movie = pageViewController.viewControllers.firstObject;
        NSInteger index = [self.pageArr indexOfObject:movie];
        [_navbar moveToIndex:index];
        
        self.currentIndex = index;
    }
}

#pragma mark - UI
- (void)initUIView {
    [self initTitleViewWithTitle:@"精挑细选"];
    [self setBackButton:YES];
    [self setupSlider];
    [self initPage];
}

- (void)setupSlider {
    _navbar = [[SliderNavBar alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
    _navbar.buttonTitleArr = @[@"正在热映", @"即将上映"];
    _navbar.mode = BottomLineModeEqualBtn;
    _navbar.fontSize = 14;
    _navbar.backgroundColor = MyColor;
    _navbar.selectedColor = WhiteColor;
    _navbar.unSelectedColor = FontLightColor;
    _navbar.bottomLineColor = WhiteColor;
    _navbar.canScrollOrTap = YES;
    [self.view addSubview:_navbar];
}

- (void)initPage {
    // 设置UIPageViewController的配置项
    NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)};
    
    // 根据给定的属性实例化UIPageViewController
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    
    _pageArr = [NSMutableArray array];
    
    for (int i = 0; i < 2; i++) {
        MovieViewController *movie = [[MovieViewController alloc] init];
        movie.type = i;
        [_pageArr addObject:movie];
    }
    
    [_pageViewController setViewControllers:[NSArray arrayWithObject:_pageArr[self.currentIndex]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    _pageViewController.view.frame = CGRectMake(0, 44, Screen_Width, Screen_Height - 44);
    
    __weak typeof (_pageViewController)weakPageViewController = _pageViewController;
    __weak typeof (_pageArr)weakPageArr = _pageArr;
    @weakSelf(self);
    [_navbar setNavBarTapBlock:^(NSInteger index, UIPageViewControllerNavigationDirection direction) {
        [weakPageViewController setViewControllers:[NSArray arrayWithObject:weakPageArr[index]] direction:direction animated:YES completion:nil];
        weakSelf.currentIndex = index;
    }];
    
    // 在页面上，显示UIPageViewController对象的View
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [_navbar moveToIndex:self.currentIndex];
}

#pragma mark ----
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

