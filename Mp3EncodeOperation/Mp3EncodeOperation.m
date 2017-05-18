//
//  Mp3EncodeOperation.m
//  Mp3EncodeDemo
//
//  Created by hejinlai on 13-6-24.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//

#import "Mp3EncodeOperation.h"
#import "lame.h"


// 全局指针
lame_t lame;

@implementation Mp3EncodeOperation


- (id) init
{
    if ( self = [super init] )
    {
        [self initLame];
        _mp3Datas = [[NSMutableData alloc] init];
    }
    
    return self;
}

- (void) initLame
{
    if (lame == nil) {
        lame = lame_init();
        lame_set_num_channels(lame, 2);
        lame_set_in_samplerate(lame, 44100);
        lame_set_brate(lame, 32);
        lame_set_mode(lame, 1);
        lame_set_quality(lame, 7);
        lame_init_params(lame);
    }
}

- (void)encodePcmData:(void *)pcmBuffer withDataSize:(UInt32)pcmDataSize {
    
    if (!_setToStopped) {
        [self initLame];
        int mp3DataSize = pcmDataSize * 4;
        unsigned char mp3Buffer[mp3DataSize];
        int encodedBytes = lame_encode_buffer( lame, pcmBuffer, pcmBuffer, pcmDataSize, mp3Buffer, mp3DataSize );
        
        [_mp3Datas appendBytes:&mp3Buffer length:encodedBytes];
        
    }
}

- (void) writeToFile
{
    if (_setToStopped) {
        lame_close(lame);
    }
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"recording.mp3"];
    [_mp3Datas writeToFile:filePath atomically:YES];
    
}


@end
