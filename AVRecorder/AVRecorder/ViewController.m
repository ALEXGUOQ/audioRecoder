//
//  ViewController.m
//  AVRecorder
//
//  Created by tag_mac_05 on 14-1-7.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session requestRecordPermission:^(BOOL granted) {
        
    }];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    [session setActive:YES error:nil];
    
    
    
    
    NSMutableDictionary *settings;
    settings = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithFloat:44100],                  AVSampleRateKey,
                [NSNumber numberWithInt:kAudioFormatAppleIMA4],
                                AVFormatIDKey,
                              [NSNumber numberWithInt: 2],                              AVNumberOfChannelsKey,
                              [NSNumber numberWithInt: AVAudioQualityMedium],                       AVEncoderAudioQualityKey,
                              nil];
    NSURL *url = [NSURL URLWithString:[self recordPath]];
    NSError* error = nil;
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    statusView.backgroundColor = [UIColor redColor];
}


-(NSString*)recordPath
{
    NSString *path = [NSString stringWithFormat:@"%@/Documents/record.caf",NSHomeDirectory()];
    return path;
}


-(IBAction)record:(id)sender
{
    [recorder prepareToRecord];
    recorder.meteringEnabled = YES;
    BOOL flag = [recorder record];
    if (flag) {
        NSLog(@"recording");
        statusView.backgroundColor = [UIColor greenColor];
    }
}

-(IBAction)play:(id)sender
{
    [recorder stop];
    statusView.backgroundColor = [UIColor redColor];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    

    NSURL *url = [NSURL URLWithString:[self recordPath]];
    
    NSError *error = nil;

    
    
    
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = 0;

    if (error) {
        NSLog(@"%@",error);
    }

    [audioPlayer play];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
