//
//  ViewController.h
//  YoutubeIniOSApp
//
//  Created by Suraj on 03/06/15.
//  Copyright (c) 2015 Suraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface ViewController : UIViewController <YTPlayerViewDelegate> {
    
}

@property(nonatomic, strong) IBOutlet YTPlayerView *youtubePlayerView;
@property(nonatomic, weak) IBOutlet UISlider *slider;
@property(nonatomic, weak) IBOutlet UIButton *playButton;
@property(nonatomic, weak) IBOutlet UIButton *pauseButton;
@property(nonatomic, weak) IBOutlet UIButton *stopButton;
@property(nonatomic, weak) IBOutlet UILabel  *lblStartTime;
@property(nonatomic, weak) IBOutlet UILabel  *lblDuration;

- (IBAction)onSliderChange:(id)sender;
- (IBAction)buttonPressed:(id)sender;

@end

