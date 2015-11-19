//
//  LuaConsole.m
//  HelloWax
//
//  Created by duanqinglun on 15/11/16.
//  Copyright © 2015年 duanqinglun. All rights reserved.
//

#import "LuaConsole.h"
#import <wax/wax.h>

#define LOG_FILE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"stdout.log"]

@implementation LuaConsole

+ (LuaConsole *)instance
{
    static LuaConsole *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self instance];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (instancetype)init
{
    if (self = [super init])
    {
//        NSLog(@"%@\n", LOG_FILE_PATH);
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:LOG_FILE_PATH]) {
            [fileManager createFileAtPath:LOG_FILE_PATH contents:nil attributes:nil];
        }
        
        freopen([LOG_FILE_PATH UTF8String], "a+", stderr);
        freopen([LOG_FILE_PATH UTF8String], "a+", stdout);
    }
    return self;
}

- (NSString *)run:(NSString *)code
{
    [@"" writeToFile:LOG_FILE_PATH atomically:NO encoding:NSUTF8StringEncoding error:NULL];
    wax_runLuaString([code UTF8String]);
    fflush(stdout);
    fflush(stderr);
    return [NSString stringWithContentsOfFile:LOG_FILE_PATH encoding:NSUTF8StringEncoding error:NULL];
}

@end