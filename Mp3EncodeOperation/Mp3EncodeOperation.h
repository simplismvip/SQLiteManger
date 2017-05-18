//
//  Mp3EncodeOperation.h
//  Mp3EncodeDemo
//
//  Created by hejinlai on 13-6-24.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Mp3EncodeOperation : NSObject
@property (nonatomic, assign) BOOL setToStopped;
@property (nonatomic, retain) NSMutableData *mp3Datas;

- (void)encodePcmData:(void *)pcmBuffer withDataSize:(UInt32)pcmDataSize;
- (void) writeToFile;

@end
