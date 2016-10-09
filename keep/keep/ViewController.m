//
//  ViewController.m
//  keep
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "NextViewController.h"

@interface ViewController ()

@property (nonatomic,strong)MPMoviePlayerController *moviePlayer;

@property (nonatomic,strong)UIView *alpaView;

@property (nonatomic,strong)AVAudioSession *avaudioSession;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置其他音乐软件播放的音乐不被打断
    self.avaudioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    [self.avaudioSession setCategory:AVAudioSessionCategoryAmbient error:&error];
    

    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"1.mp4" ofType:nil]];
    _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [_moviePlayer play];
    [_moviePlayer.view setFrame:self.view.bounds];
    //将视频view添加上去
    [self.view addSubview:_moviePlayer.view];
    
    _moviePlayer.shouldAutoplay = YES;
    _moviePlayer.controlStyle = MPMovieControlStyleNone;
    _moviePlayer.fullscreen = YES;
    
    _moviePlayer.repeatMode = MPMovieRepeatModeOne;
    
    //kvo
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateChanged) name:MPMoviePlayerPlaybackStateDidChangeNotification object:_moviePlayer];
    
    _alpaView = [[UIView alloc] initWithFrame:self.view.bounds];
    [_moviePlayer.view addSubview:_alpaView];
    
    
    UIButton *button =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    button.backgroundColor = [UIColor colorWithRed:1.000 green:0.868 blue:0.877 alpha:1.000];
    button.center = _alpaView.center;
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alpaView addSubview:button];
    
    
    
    
}

- (void)playbackStateChanged{
    
    //取得目前状态
    MPMoviePlaybackState playbackState = [_moviePlayer playbackState];
    //状态类型
    switch (playbackState) {
        case MPMoviePlaybackStateStopped:
            [_moviePlayer play];
            break;
        case MPMoviePlaybackStatePlaying:
            NSLog(@"播放中");
            break;
        case MPMoviePlaybackStatePaused:
            [_moviePlayer play];
            break;
        case MPMoviePlaybackStateInterrupted:
            NSLog(@"播放被中断");
            break;
        case MPMoviePlaybackStateSeekingForward:
            NSLog(@"往前快转");
            break;
        case MPMoviePlaybackStateSeekingBackward:
            NSLog(@"往后快转");
            break;
            
        default:
            NSLog(@"无法辨别的状态");
            break;
    }
    
    
    
}

- (void)buttonClick:(UIButton *)button{
    
    NextViewController *next = [[NextViewController alloc] init];
    [self presentViewController:next animated:YES completion:nil];
    
}





















@end
