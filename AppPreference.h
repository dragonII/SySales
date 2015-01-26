//
//  AppPreference.h
//  SySales
//
//  Created by Wang Long on 1/26/15.
//  Copyright (c) 2015 Wang Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppPreference : NSObject

+ (void)saveUserName:(NSString *)username withPassword:(NSString *)password;
+ (NSDictionary *)loadUserNameAndPassword;

@end
