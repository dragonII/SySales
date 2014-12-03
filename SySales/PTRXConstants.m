//
//  PTRXConstants.m
//  SySales
//
//  Created by Wang Long on 12/2/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import "PTRXConstants.h"

@interface PTRXConstants ()


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
                                  @"1": NSLocalizedString(@"Login Success", @"Login Success"),
                                  @"2": NSLocalizedString(@"Wrong Password", @"Wrong password"),
                                  @"3": NSLocalizedString(@"Account Locked", @"Account Locked"),
                                  @"5": NSLocalizedString(@"Warning Login", @"Warning login"),
                                  @"0": NSLocalizedString(@"No Such Account", @"No Such Account")
                                    };
    self.PTRX_S_LOGIN_URL = @"http://scs3.syslive.cn/interface_mb/login_mb/login.ds";
    
    self.userKey = @"user";
    self.passKey = @"password";
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
