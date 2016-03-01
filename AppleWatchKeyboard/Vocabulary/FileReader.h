//
//  FileReader.h
//  SkiAlgorithm
//
//  Created by Shekhar Sasikumar on 6/12/15.
//  Copyright (c) 2015 Myaango. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileReader : NSObject
{
    NSString * filePath;
    
    NSFileHandle * fileHandle;
    unsigned long long currentOffset;
    unsigned long long totalFileLength;
    
    NSString * lineDelimiter;
    NSUInteger chunkSize;
}

@property (nonatomic, copy) NSString * lineDelimiter;
@property (nonatomic) NSUInteger chunkSize;

- (id) initWithFilePath:(NSString *)aPath;

- (NSString *) readLine;
- (NSString *) readTrimmedLine;

#if NS_BLOCKS_AVAILABLE
- (void) enumerateLinesUsingBlock:(void(^)(NSString*, BOOL *))block;
#endif

@end
