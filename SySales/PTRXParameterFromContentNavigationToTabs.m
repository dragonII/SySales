//
//  PTRXParameterFromContentNavigationToTabs.m
//  SySales
//
//  Created by Wang Long on 11/30/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import "PTRXParameterFromContentNavigationToTabs.h"

@implementation PTRXParameterFromContentNavigationToTabs

+(instancetype)sharedParameter
{
    static PTRXParameterFromContentNavigationToTabs *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

@end
