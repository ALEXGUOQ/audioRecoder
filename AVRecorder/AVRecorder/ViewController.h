//
//  ViewController.h
//  AVRecorder
//
//  Created by tag_mac_05 on 14-1-7.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController : UIViewController <AVAudioPlayerDelegate>
{
    AVAudioRecorder *recorder;
    IBOutlet UIView *statusView;
    
    AVAudioPlayer* audioPlayer;
}
@end
