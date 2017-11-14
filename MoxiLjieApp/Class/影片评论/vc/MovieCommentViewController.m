//
//  MovieCommentViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "MovieCommentViewController.h"
#import "CommentViewModel.h"
#import "CommentCell.h"

@interface MovieCommentViewController ()<UITableViewDelegate, UITableViewDataSource, RefreshTableViewDelegate>

@property (nonatomic, strong) JJRefreshTabView *commentTable;
@property (nonatomic, strong) CommentViewModel *viewmodel;

@property (nonatomic, assign) BOOL hasData;

@end

@implementation MovieCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hasData = NO;
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[CommentViewModel alloc] init];
    [self loadDataRefresh:YES];
}

- (void)loadDataRefresh:(BOOL)isRefresh {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getCommentListWithMovieID:self.movieID success:^(BOOL result) {
        if (weakSelf.viewmodel.commentArr.count) {
            [weakSelf.commentTable dismissNoView];
            weakSelf.hasData = YES;
        } else {
            weakSelf.hasData = NO;
            [weakSelf.commentTable showNoView:@"没有数据，刷新试试吧" image:nil certer:CGPointZero];
        }
        [weakSelf.commentTable reloadData];
        
    } failure:^(NSString *errorStr) {
        [weakSelf hideWaiting];
        if (!weakSelf.hasData) {
            [weakSelf.commentTable showNoView:@"加载失败，刷新试试" image:nil certer:CGPointZero];
        } else {
            [weakSelf.commentTable dismissNoView];
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
    return self.viewmodel.commentArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Comment *model = self.viewmodel.commentArr[indexPath.row];
    CGFloat height = [CommentCell cellHeightWithString:model.ce];
    return height;
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
    CommentCell *cell = [CommentCell myCellWithTableview:tableView];
    if (self.viewmodel.commentArr.count) {
        [cell setShortCommentWithModel:self.viewmodel.commentArr[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - ui
- (void)initUIView {
    [self setBackButton:YES];
    [self initTitleViewWithTitle:NSLocalizedString(@"短评", nil)];
    
    [self setupTable];
}

- (void)setupTable {
    self.commentTable = [[JJRefreshTabView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64) style:UITableViewStylePlain];
    self.commentTable.delegate = self;
    self.commentTable.dataSource = self;
    [self.view addSubview:self.commentTable];
    
    self.commentTable.tableFooterView = [UIView new];
    
    self.commentTable.refreshDelegate = self;
    self.commentTable.CanRefresh = YES;
    self.commentTable.lastUpdateKey = NSStringFromClass([self class]);
    self.commentTable.isShowMore = NO;
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

