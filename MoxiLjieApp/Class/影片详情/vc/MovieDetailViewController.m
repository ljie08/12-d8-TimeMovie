//
//  MovieDetailViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MovieDetailViewModel.h"
#import "MovieHeaderCell.h"//头视图
#import "StoryCell.h"//剧情
#import "PeopleCell.h"//导演、演员
#import "StillsItemTableCell.h"//剧照
#import "BoxOfficeCell.h"//票房
#import "CommentCell.h"//短评
#import "TrailerViewController.h"//预告片
#import "ActorViewController.h"//演员表
#import "StillsViewController.h"//剧照
#import "MovieCommentViewController.h"//短评

@interface MovieDetailViewController ()<UITableViewDelegate, UITableViewDataSource, RefreshTableViewDelegate, MovieDetailDelegate, TotalActorDelegate, StillsItemDelegate>

@property (nonatomic, strong) JJRefreshTabView *detailTable;
@property (nonatomic, strong) MovieDetailViewModel *viewmodel;

@property (nonatomic, assign) BOOL hasData;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hasData = NO;
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[MovieDetailViewModel alloc] init];
    [self loadData];
}

- (void)loadData {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getMovieDetailWithMovieID:self.movieId success:^(BOOL result) {
        [weakSelf hideWaiting];
        if (weakSelf.viewmodel.basic) {
            [weakSelf.detailTable dismissNoView];
            weakSelf.hasData = YES;
        } else {
            weakSelf.hasData = NO;
            [weakSelf.detailTable showNoView:@"没有数据，刷新试试吧" image:nil certer:CGPointZero];
        }
        [weakSelf.detailTable reloadData];
        
    } failure:^(NSString *errorStr) {
        [weakSelf hideWaiting];
        [weakSelf.detailTable dismissNoView];
        if (!weakSelf.hasData) {
            [weakSelf.detailTable showNoView:@"加载失败，刷新试试" image:nil certer:CGPointZero];
        } else {
            [weakSelf.detailTable dismissNoView];
        }
        
        [weakSelf showMassage:errorStr];
    }];
    [self showWaiting];
    [self.viewmodel getHotCommentWithMovieID:self.movieId success:^(BOOL result) {
        [weakSelf hideWaiting];
        if (weakSelf.viewmodel.hotArr.count) {
            [weakSelf.detailTable dismissNoView];
        }
        [weakSelf.detailTable reloadData];
        
    } failure:^(NSString *errorStr) {
        [weakSelf hideWaiting];
        [weakSelf.detailTable dismissNoView];
        [weakSelf.detailTable showNoView:@"加载失败，刷新试试" image:nil certer:CGPointZero];
        [weakSelf showMassage:errorStr];
    }];
}

#pragma mark - cell delegate
- (void)gotoTrailerVc {
    TrailerViewController *trailer = [[TrailerViewController alloc] init];
    trailer.movieID = self.movieId;
    [self.navigationController pushViewController:trailer animated:YES];
}

- (void)gotoActorVc {
    ActorViewController *actor = [[ActorViewController alloc] init];
    actor.movieID = self.movieId;
    [self.navigationController pushViewController:actor animated:YES];
}

- (void)gotoStillsVc {
    StillsViewController *stills = [[StillsViewController alloc] init];
    stills.movieID = self.movieId;
    [self.navigationController pushViewController:stills animated:YES];
}

#pragma mark - refresh
- (void)refreshTableViewHeader {
    [self loadData];
}

- (void)refreshTableViewFooter {
    [self loadData];
}

#pragma mark - table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.hasData) {
        return 6;
    } else {
        return 0;
    }
    //    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 5) {
        return self.viewmodel.hotArr.count+1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//头视图
        return 240;
    } else if (indexPath.section == 1) {//剧情
        CGFloat height = [StoryCell cellHeightWithString:self.viewmodel.basic.story];
        return height;
        //        return 100;
    } else if (indexPath.section == 2) {//演员
        return 210;
    } else if (indexPath.section == 3) {//剧照
        return 120;
    } else if (indexPath.section == 4) {//排名、票房
        return 80;
    } else {//短评
        if (indexPath.row == self.viewmodel.hotArr.count) {
            return 40;
        }
        ShortComment *comment = self.viewmodel.hotArr[indexPath.row];
        CGFloat height = [CommentCell cellHeightWithString:comment.content];
        return height;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section) {
        return 10;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 5) {
        return 10;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {//头视图
        MovieHeaderCell *cell = [MovieHeaderCell myCellWithTableview:tableView];
        cell.delegate = self;
        if (self.viewmodel.basic) {
            [cell setDataWithModel:self.viewmodel.basic];
        }
        
        return cell;
        
    } else if (indexPath.section == 1) {//剧情
        StoryCell *cell = [StoryCell myCellWithTableview:tableView];
        if (self.viewmodel.basic) {
            [cell setDataWithModel:self.viewmodel.basic];
        }
        
        return cell;
        
    } else if (indexPath.section == 2) {//演员
        PeopleCell *cell = [PeopleCell myCellWithTableview:tableView withPeopleArr:self.viewmodel.actorArr];
        cell.delegate = self;
        
        [cell.peopleCollectionview reloadData];
        
        return cell;
        
    } else if (indexPath.section == 3) {//剧照
        NSArray *imgArr = [Stills mj_objectArrayWithKeyValuesArray:[self.viewmodel.basic.stageImg objectForKey:@"list"]];
        StillsItemTableCell *cell = [StillsItemTableCell myCellWithTableview:tableView withStillsArr:imgArr];
        cell.delegate = self;
        [cell.stillsCollectionview reloadData];
        return cell;
        
    } else if (indexPath.section == 4) {//排名、票房
        BoxOfficeCell *cell = [BoxOfficeCell myCellWithTableview:tableView];
        if (self.viewmodel.boxOffice) {
            [cell setDataWithModel:self.viewmodel.boxOffice];
        }
        
        return cell;
        
    } else {//短评
        if (indexPath.row == self.viewmodel.hotArr.count) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            UILabel *commentLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
            commentLab.textColor = RedColor;
            commentLab.textAlignment = NSTextAlignmentCenter;
            commentLab.text = @"查看全部短评";
            commentLab.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:commentLab];
            
            return cell;
        } else {
            CommentCell *cell = [CommentCell myCellWithTableview:tableView];
            [cell setHotCommentWithModel:self.viewmodel.hotArr[indexPath.row]];
            
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//头视图
        
    } else if (indexPath.section == 1) {//剧情
        
    } else if (indexPath.section == 2) {//演员
        
    } else if (indexPath.section == 3) {//剧照
        
    } else if (indexPath.section == 4) {//排名、票房
        
    } else {//短评
        if (indexPath.row == self.viewmodel.hotArr.count) {
            MovieCommentViewController *comment = [[MovieCommentViewController alloc] init];
            comment.movieID = self.movieId;
            
            [self.navigationController pushViewController:comment animated:YES];
        }
    }
}

#pragma mark - ui
- (void)initUIView {
    [self setBackButton:YES];
    [self initTitleViewWithTitle:NSLocalizedString(@"电影详情", nil)];
    
    [self setupTable];
}

- (void)setupTable {
    self.detailTable = [[JJRefreshTabView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64) style:UITableViewStyleGrouped];
    self.detailTable.delegate = self;
    self.detailTable.dataSource = self;
    //    self.detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.detailTable];
    
    self.detailTable.refreshDelegate = self;
    self.detailTable.CanRefresh = YES;
    self.detailTable.lastUpdateKey = NSStringFromClass([self class]);
    self.detailTable.isShowMore = NO;
    
    self.detailTable.tableFooterView = [UIView new];
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

