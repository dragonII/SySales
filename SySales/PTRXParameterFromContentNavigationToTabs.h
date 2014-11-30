//
//  PTRXParameterFromContentNavigationToTabs.h
//  SySales
//
//  Created by Wang Long on 11/30/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTRXParameterFromContentNavigationToTabs : NSObject

@property (copy, nonatomic) NSString *barButtonOneName;
@property (copy, nonatomic) NSString *barButtonTwoName;
@property (copy, nonatomic) NSString *urlStringForWebView;

+(instancetype)sharedParameter;

@end
