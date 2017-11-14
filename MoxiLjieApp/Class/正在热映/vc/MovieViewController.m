//
//  MovieViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieViewModel.h"
#import "MovieCell.h"
#import "MovieDetailViewController.h"

@interface MovieViewController ()<UITableViewDelegate, UITableViewDataSource, RefreshTableViewDelegate>

@property (nonatomic, strong) JJRefreshTabView *movieTable;
@property (nonatomic, strong) MovieViewModel *viewmodel;

@property (nonatomic, assign) BOOL hasData;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hasData = NO;
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[MovieViewModel alloc] init];
    [self loadData];
}

- (void)loadData {
    @weakSelf(self);
    [self showWaiting];
    if (self.type) {
        [self.viewmodel getNewMovieWithSuccess:^(BOOL result) {
            [weakSelf hideWaiting];
            if (weakSelf.viewmodel.newcomingArr.count) {
                [weakSelf.movieTable dismissNoView];
                weakSelf.hasData = YES;
            } else {
                weakSelf.hasData = NO;
                [weakSelf.movieTable showNoView:@"没有数据，刷新试试吧" image:nil certer:CGPointZero];
            }
            
            [weakSelf.movieTable reloadData];
            
        } failure:^(NSString *errorStr) {
            [weakSelf hideWaiting];
            if (!weakSelf.hasData) {
                [weakSelf.movieTable showNoView:@"加载失败，刷新试试" image:nil certer:CGPointZero];
            } else {
                [weakSelf.movieTable dismissNoView];
            }
            [weakSelf showMassage:errorStr];
        }];
    } else {
        [self.viewmodel getHotMovieWithSuccess:^(BOOL result) {
            [weakSelf hideWaiting];
            if (weakSelf.viewmodel.hotArr.count) {
                [weakSelf.movieTable dismissNoView];
                weakSelf.hasData = YES;
            } else {
                weakSelf.hasData = NO;
                [weakSelf.movieTable showNoView:@"没有数据，刷新试试吧" image:nil certer:CGPointZero];
            }
            
            [weakSelf.movieTable reloadData];
        } failure:^(NSString *errorStr) {
            [weakSelf hideWaiting];
            if (!weakSelf.hasData) {
                [weakSelf.movieTable showNoView:@"加载失败，刷新试试" image:nil certer:CGPointZero];
            } else {
                [weakSelf.movieTable dismissNoView];
            }
            [weakSelf showMassage:errorStr];
        }];
    }
}

#pragma mark - refresh
- (void)refreshTableViewHeader {
    [self loadData];
}

- (void)refreshTableViewFooter {
    [self loadData];
}

#pragma mark - table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.type) {
        return self.viewmodel.newcomingArr.count;
    } else {
        return self.viewmodel.hotArr.count;
    }
    //    return 10;
    //    return self.viewmodel.homeList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
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
    MovieCell *cell = [MovieCell myCellWithTableview:tableView];
    if (self.type) {
        if (self.viewmodel.newcomingArr.count) {
            [cell setNewDataWithModel:self.viewmodel.newcomingArr[indexPath.row]];
        }
    } else {
        if (self.viewmodel.hotArr.count) {
            [cell setHotDataWithModel:self.viewmodel.hotArr[indexPath.row]];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieDetailViewController *movie = [[MovieDetailViewController alloc] init];
    if (self.type) {
        NewMovie *model = self.viewmodel.newcomingArr[indexPath.row];
        movie.movieId = model.newid;
    } else {
        HotMovie *model = self.viewmodel.hotArr[indexPath.row];
        movie.movieId = model.hotID;
    }
    
    [self.navigationController pushViewController:movie animated:YES];
}

#pragma mark - ui
- (void)initUIView {
    [self setBackButton:YES];
    //    [self initTitleViewWithTitle:NSLocalizedString(@"历史记录", nil)];
    
    [self setupTable];
}

- (void)setupTable {
    self.movieTable = [[JJRefreshTabView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-44-64) style:UITableViewStylePlain];
    self.movieTable.delegate = self;
    self.movieTable.dataSource = self;
    [self.view addSubview:self.movieTable];
    
    self.movieTable.tableFooterView = [UIView new];
    
    self.movieTable.refreshDelegate = self;
    self.movieTable.CanRefresh = YES;
    self.movieTable.lastUpdateKey = NSStringFromClass([self class]);
    self.movieTable.isShowMore = NO;
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

