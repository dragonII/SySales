//
//  AppPreference.m
//  SySales
//
//  Created by Wang Long on 1/26/15.
//  Copyright (c) 2015 Wang Long. All rights reserved.
//

#import "AppPreference.h"

static NSString *GlobalPreferenceFileName = @"preference.plist";

@implementation AppPreference

+ (NSString *)getFilePathWithName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *prefereceFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    
    return prefereceFilePath;
}

+ (NSMutableDictionary *) getDictionaryFilePreferenceFile:(NSString *)fileName
{
    NSString *filePath = [self getFilePathWithName:fileName];
    
    NSMutableDictionary *dict;
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        dict = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    } else {
        dict = [[NSMutableDictionary alloc] init];
    }
    
    return dict;
}

+ (NSDictionary *)loadUserNameAndPassword
{
    NSDictionary *dict = [self getDictionaryFilePreferenceFile:GlobalPreferenceFileName];
    
    NSDictionary *newDict;
    
    if([dict count] > 0)
    {
        newDict = @{@"username": dict[@"username"],
                    @"password": dict[@"password"]
                    };
        return newDict;
    }
    else
        return nil;
}

+ (void)saveUserName:(NSString *)username withPassword:(NSString *)password
{
    NSMutableDictionary *dict = [self getDictionaryFilePreferenceFile:GlobalPreferenceFileName];
    
    NSString *filePath = [self getFilePathWithName:GlobalPreferenceFileName];
    
    dict[@"username"] = username;
    dict[@"password"] = password;
    
    [dict writeToFile:filePath atomically:YES];
}

@end
