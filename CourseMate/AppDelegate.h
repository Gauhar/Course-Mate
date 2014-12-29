//
//  AppDelegate.h
//  CourseMate
//
//  Created by Gauhar Shakeel on 2014-11-16.
//  Copyright (c) 2014 Gauhar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MCManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong, nonatomic) MCManager *mcManager;
@end

