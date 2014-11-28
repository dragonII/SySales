//
//  PTRXDataPersistence.m
//  SySales
//
//  Created by Wang Long on 11/28/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import "PTRXDataPersistence.h"

@implementation PTRXDataPersistence

+ (NSString *)preferenceFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return [documentDirectory stringByAppendingString:@"/preference.plist"];
}

+ (void)savePreference
{
    NSString *filePath = [self preferenceFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        //saving data
    }
}

+ (void)saveUserName:(NSString *)userName andPassword:(NSString *)password
{
    //NSString *filePath = [self preferenceFilePath];
    
}

+ (NSString *)getFirstLaunchValue
{
    NSString *filePath = [self preferenceFilePath];
    NSLog(@"filePath: %@", filePath);
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        NSLog(@"Found: %@", dict[@"firstLaunch"]);
        return dict[@"firstLaunch"];
    } else {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict[@"firstLaunch"] = @"NO";
        [dict writeToFile:filePath atomically:YES];
        NSLog(@"Not Found, return YES, and saving");
        return @"YES";
    }
}

@end
