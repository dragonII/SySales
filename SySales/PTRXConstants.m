//
//  PTRXConstants.m
//  SySales
//
//  Created by Wang Long on 12/2/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import "PTRXConstants.h"

@interface PTRXConstants ()

@property (strong, nonatomic) NSString *PTRX_S_LOGIN_SUCCESS;
@property (strong, nonatomic) NSString *PTRX_S_LOGIN_WRONG_PASS;
@property (strong, nonatomic) NSString *PTRX_S_LOGIN_ACCOUNT_LOCK;
@property (strong, nonatomic) NSString *PTRX_S_LOGIN_LOGIN_WARNING;
@property (strong, nonatomic) NSString *PTRX_S_LOGIN_NO_ACCOUNT;

@property (strong, nonatomic) NSArray *PTRX_LOGIN_STRINGS;
@property (strong, nonatomic) NSDictionary *PTRX_LOGIN_INFO_DICT;

@end

@implementation PTRXConstants

- (void)initValues
{
    self.PTRX_LOGIN_STRINGS =
    @[@"<sysxml><rest name=\"rest\">1</rest></sysxml>",
      @"<sysxml><rest name=\"rest\">2</rest></sysxml>",
      @"<sysxml><rest name=\"rest\">3</rest></sysxml>",
      @"<sysxml><rest name=\"rest\">5</rest></sysxml>",
      @"<sysxml><rest name=\"rest\">0</rest></sysxml>"
      ];
    
    self.PTRX_LOGIN_INFO_DICT = @{
                                  @"1": @"Login Success",
                                  @"2": @"Wrong Password",
                                  @"3": @"Account Locked",
                                  @"5": @"Warning Login",
                                  @"0": @"No Account"
                                    };
}

+(instancetype)sharedConstants
{
    static PTRXConstants *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
        
        [shared initValues];
    });
    return shared;
}

@end
