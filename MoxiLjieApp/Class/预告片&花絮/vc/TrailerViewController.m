//
//  TrailerViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "TrailerViewController.h"
#import "TrailerCell.h"
#import "TrailerViewModel.h"
#import "PlayVideoViewController.h"

@interface TrailerViewController ()<UITableViewDelegate, UITableViewDataSource, RefreshTableViewDelegate>

@property (nonatomic, strong) JJRefreshTabView *trailerTable;
@property (nonatomic, strong) TrailerViewModel *viewmodel;

@property (nonatomic, assign) BOOL hasData;

@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hasData = NO;
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[TrailerViewModel alloc] init];
    [self loadDataRefresh:YES];
}

- (void)loadDataRefresh:(BOOL)isRefresh {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getTrailerListWithMovieID:self.movieID success:^(BOOL result) {
        [weakSelf hideWaiting];
        if (weakSelf.viewmodel.trailerArr.count) {
            weakSelf.hasData = YES;
            [weakSelf.trailerTable dismissNoView];
        } else {
            weakSelf.hasData = NO;
            [weakSelf.trailerTable showNoView:@"没有数据，刷新试试吧" image:nil certer:CGPointZero];
        }
        [weakSelf.trailerTable reloadData];
    } failure:^(NSString *errorStr) {
        [weakSelf hideWaiting];
        if (!weakSelf.hasData) {
            [weakSelf.trailerTable showNoView:@"加载失败，刷新试试" image:nil certer:CGPointZero];
        } else {
            [weakSelf.trailerTable dismissNoView];
        }
        [weakSelf showMassage:errorStr];
    }];
}

#pragma mark - refresh
- (void)refreshTableViewHeader {
    [self loadDataRefresh:YES];
}

- (void)refreshTableViewFooter {
    [self loadDataRefresh:NO];
}

#pragma mark - table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return 10;
    return self.viewmodel.trailerArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TrailerCell *cell = [TrailerCell myCellWithTableview:tableView];
    if (self.viewmodel.trailerArr.count) {
        [cell setDataWithModel:self.viewmodel.trailerArr[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayVideoViewController *play = [[PlayVideoViewController alloc] init];
    
    Trailer *model = self.viewmodel.trailerArr[indexPath.row];
    
    play.videoUrl = model.hightUrl;
    
    [self.navigationController pushViewController:play animated:YES];
}

#pragma mark - ui
- (void)initUIView {
    [self setBackButton:YES];
    [self initTitleViewWithTitle:NSLocalizedString(@"预告片&花絮", nil)];
    
    [self setupTable];
}

- (void)setupTable {
    self.trailerTable = [[JJRefreshTabView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64) style:UITableViewStyleGrouped];
    self.trailerTable.delegate = self;
    self.trailerTable.dataSource = self;
    [self.view addSubview:self.trailerTable];
    
    self.trailerTable.tableFooterView = [UIView new];
    
    self.trailerTable.refreshDelegate = self;
    self.trailerTable.CanRefresh = YES;
    self.trailerTable.lastUpdateKey = NSStringFromClass([self class]);
    self.trailerTable.isShowMore = NO;
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

