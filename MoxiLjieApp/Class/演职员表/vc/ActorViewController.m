//
//  ActorViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "ActorViewController.h"
#import "ActorCell.h"
#import "ActorViewModel.h"

@interface ActorViewController ()<UITableViewDelegate, UITableViewDataSource, RefreshTableViewDelegate>

@property (nonatomic, strong) JJRefreshTabView *actorTable;
@property (nonatomic, strong) ActorViewModel *viewmodel;

@property (nonatomic, assign) BOOL hasData;

@end

@implementation ActorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hasData = NO;
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[ActorViewModel alloc] init];
    [self loadData];
}

- (void)loadData {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getActorListWithMovieID:self.movieID success:^(BOOL result) {
        [weakSelf hideWaiting];
        if (weakSelf.viewmodel.actorArr.count) {
            [weakSelf.actorTable dismissNoView];
            weakSelf.hasData = YES;
        } else {
            weakSelf.hasData = NO;
            [weakSelf.actorTable showNoView:@"没有数据，刷新试试吧" image:nil certer:CGPointZero];
        }
        [weakSelf.actorTable reloadData];
    } failure:^(NSString *errorStr) {
        [weakSelf hideWaiting];
        if (!weakSelf.hasData) {
            [weakSelf.actorTable showNoView:@"加载失败，刷新试试" image:nil certer:CGPointZero];
        } else {
            [weakSelf.actorTable dismissNoView];
        }
        //        [weakSelf.actorTable showNoView:@"加载失败，刷新试试" image:nil certer:CGPointZero];
        [weakSelf showMassage:errorStr];
    }];
}

#pragma mark - refresh
- (void)refreshTableViewHeader {
    [self loadData];
}

#pragma mark - table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewmodel.actorArr.count;
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
    ActorCell *cell = [ActorCell myCellWithTableview:tableView];
    if (self.viewmodel.actorArr.count) {
        [cell setDataWithModel:self.viewmodel.actorArr[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - ui
- (void)initUIView {
    [self setBackButton:YES];
    [self initTitleViewWithTitle:NSLocalizedString(@"演员表", nil)];
    
    [self setupTable];
}

- (void)setupTable {
    self.actorTable = [[JJRefreshTabView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64) style:UITableViewStyleGrouped];
    self.actorTable.delegate = self;
    self.actorTable.dataSource = self;
    [self.view addSubview:self.actorTable];
    
    self.actorTable.refreshDelegate = self;
    self.actorTable.CanRefresh = YES;
    self.actorTable.lastUpdateKey = NSStringFromClass([self class]);
    self.actorTable.isShowMore = NO;
    
    self.actorTable.tableFooterView = [UIView new];
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

