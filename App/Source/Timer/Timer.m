//
//  Timer.m
//  PijnMonitor
//
//  Created by Bob de Graaf on 21-07-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "Timer.h"

@interface Timer ()
{
    
}

@property(nonatomic,strong) NSTimer *updateTimer;

@end

@implementation Timer
SINGLETON_GCD(Timer);

#pragma mark - Init

-(instancetype)init
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    //Notifications
    [NOTIFICATION_CENTER addObserver:self selector:@selector(stopTimer) name:UIApplicationWillResignActiveNotification object:nil];
    [NOTIFICATION_CENTER addObserver:self selector:@selector(startTimer) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    //Start
    [self setupUpdateTimer];
    
    return self;
}

#pragma mark - Timer

-(void)setupUpdateTimer
{
    [self startTimer];
    [self timerTick];
}

-(void)timerTick
{
    if(self.timerTicked) {
        self.timerTicked();
    }
}

-(void)startTimer
{
    [self stopTimer];
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerTick) userInfo:nil repeats:TRUE];
}

-(void)stopTimer
{
    if(self.updateTimer && [self.updateTimer isValid]) {
        [self.updateTimer invalidate];
    }
    self.updateTimer = nil;
}

#pragma mark Dealloc

-(void)dealloc
{
    [NOTIFICATION_CENTER removeObserver:self];
}



@end
