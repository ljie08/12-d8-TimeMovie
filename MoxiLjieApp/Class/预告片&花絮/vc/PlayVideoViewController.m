//
//  PlayVideoViewController.m
//  MoxiLjieApp
//
//  Created by 0.0 on 2017/11/6.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "PlayVideoViewController.h"

@interface PlayVideoViewController ()<ZFPlayerDelegate>

@property (nonatomic, strong) ZFPlayerView *playerView;

@property (nonatomic, strong) UIView *videoView;

@end

@implementation PlayVideoViewController

- (ZFPlayerView *)playerView{
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc] init];
        _playerView.delegate = self;
        _playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    }
    return _playerView;
}

- (UIView *)videoView {
    if (!_videoView) {
        _videoView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_videoView];
        [_videoView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(0);
            make.center.equalTo(self.view);
            make.leading.trailing.mas_equalTo(0);
            // 这里宽高比16：9,可自定义宽高比
            make.height.mas_equalTo(_videoView.mas_width).multipliedBy(9.0f/16.0f);
        }];
    }
    return _videoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)initViewModelBinding {
    ZFPlayerControlView  *controlView = [[ZFPlayerControlView alloc] init];
    //初始化播放器模型
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
    playerModel.videoURL = [NSURL URLWithString:self.videoUrl];
    
//    playerModel.placeholderImageURLString = [KBaseIDPicURL stringByAppendingString:content.kanPic];
    
    playerModel.fatherView = self.videoView;
    
    [self.playerView playerControlView:controlView playerModel:playerModel];
    //自动播放
    [self.playerView autoPlayTheVideo];
}

- (void)initUIView {
    [self setBackButton:YES];
    [self initTitleViewWithTitle:@"预告片&花絮"];
    self.view.backgroundColor = MyColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
