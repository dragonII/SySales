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
    NSString *filePath = [self preferenceFilePath];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [dict setObject:userName forKey:@"user"];
        [dict setObject:password forKey:@"password"];
        [dict writeToFile:filePath atomically:YES];
    } else {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:userName forKey:@"user"];
        [dict setObject:password forKey:@"password"];
        [dict writeToFile:filePath atomically:YES];
    }
    
}

+ (NSDictionary *)getUserPassword
{
    NSString *userKey = @"user";
    NSString *passKey = @"password";
    NSMutableDictionary *dict;
    NSString *filePath = [self preferenceFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSDictionary *dictFromFile = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[dictFromFile objectForKey:userKey] forKey:userKey];
        [dict setObject:[dictFromFile objectForKey:passKey] forKey:passKey];
        return dict;
    } else {
        return nil;
    }
}

+ (NSString *)getFirstLaunchValue
{
    NSString *filePath = [self preferenceFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        NSLog(@"Preference: %@", dict);
        return dict[@"firstLaunch"];
    } else {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict[@"firstLaunch"] = @"NO";
        [dict writeToFile:filePath atomically:YES];
        return @"YES";
    }
}

@end
