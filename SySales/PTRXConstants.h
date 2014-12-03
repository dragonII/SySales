//
//  PTRXConstants.h
//  SySales
//
//  Created by Wang Long on 12/2/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTRXConstants : NSObject

@property (strong, nonatomic) NSString *PTRX_S_LOGIN_URL;

@property (strong, nonatomic) NSArray *PTRX_LOGIN_STRINGS;
@property (strong, nonatomic) NSDictionary *PTRX_LOGIN_INFO_DICT;

@property (strong, nonatomic) NSString *userKey;
@property (strong, nonatomic) NSString *passKey;

+(instancetype)sharedConstants;

@end
