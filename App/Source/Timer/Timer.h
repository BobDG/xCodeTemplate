//
//  Timer.h
//  PijnMonitor
//
//  Created by Bob de Graaf on 21-07-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Constants.h"

@interface Timer : NSObject
{
    
}

+(Timer *)sharedTimer;

@property(nonatomic,copy) void (^timerTicked)(void);

@end