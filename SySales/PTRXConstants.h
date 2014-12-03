//
//  PTRXConstants.h
//  SySales
//
//  Created by Wang Long on 12/2/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTRXConstants : NSObject

@property (readonly, nonatomic) NSString *PTRX_S_LOGIN_URL;

@property (readonly, nonatomic) NSArray *PTRX_LOGIN_STRINGS;
@property (readonly, nonatomic) NSDictionary *PTRX_LOGIN_INFO_DICT;

+(instancetype)sharedConstants;

@end
