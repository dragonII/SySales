//
//  PTRXDataPersistence.h
//  SySales
//
//  Created by Wang Long on 11/28/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTRXDataPersistence : NSObject

+ (NSString *)getFirstLaunchValue;

+ (void)saveUserName:(NSString *)userName andPassword:(NSString *)password;
+ (NSDictionary *)getUserPassword;

@end
