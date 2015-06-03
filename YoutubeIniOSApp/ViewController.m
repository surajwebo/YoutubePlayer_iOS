//
//  ViewController.m
//  YoutubeIniOSApp
//
//  Created by Suraj on 03/06/15.
//  Copyright (c) 2015 Suraj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *videoId = @"Xk1zfQOklJY";
    NSDictionary *playerVars = @{@"controls" : @0,
                                 @"playsinline" : @1,
                                 @"autohide" : @1,
                                 @"showinfo" : @0,
                                 @"modestbranding" : @1};
    self.youtubePlayerView.delegate = self;
    [self.youtubePlayerView loadWithVideoId:videoId playerVars:playerVars];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedPlaybackStartedNotification:)
                                                 name:@"Playback started"
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playerView:(YTPlayerView *)ytPlayerView didChangeToState:(YTPlayerState)state {
    NSLog(@"%@",[NSString stringWithFormat:@"Player state changed: %ld\n", (long)state]);
}

- (void)playerView:(YTPlayerView *)playerView didPlayTime:(float)playTime {
    float progress = playTime/self.youtubePlayerView.duration;
    [self.slider setValue:progress];
    [self.lblStartTime setText:[NSString stringWithFormat:@"%.2f",self.youtubePlayerView.currentTime/60]];
    [self.lblDuration  setText:[NSString stringWithFormat:@"%.2f",self.youtubePlayerView.duration/60]];
}

- (IBAction)onSliderChange:(id)sender {
    float seekToTime = self.youtubePlayerView.duration * self.slider.value;
    [self.youtubePlayerView seekToSeconds:seekToTime allowSeekAhead:YES];
    //[self appendStatusText:[NSString stringWithFormat:@"Seeking to time: %.0f seconds\n", seekToTime]];
}

- (IBAction)buttonPressed:(id)sender {
    if (sender == self.playButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Playback started" object:self];
        [self.youtubePlayerView playVideo];
    } else if (sender == self.stopButton) {
        [self.youtubePlayerView stopVideo];
        [self.slider setValue:0];
        [self.lblStartTime setText:@"0.0"];
        [self.lblDuration  setText:@"0.0"];
    } else if (sender == self.pauseButton) {
        [self.youtubePlayerView pauseVideo];
    }
}

- (void)receivedPlaybackStartedNotification:(NSNotification *) notification {
    if([notification.name isEqual:@"Playback started"] && notification.object != self) {
        [self.youtubePlayerView pauseVideo];
    }
}


@end
