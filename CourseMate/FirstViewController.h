//
//  FirstViewController.h
//  CourseMate
//
//  Created by Gauhar Shakeel on 2014-11-16.
//  Copyright (c) 2014 Gauhar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface FirstViewController : UIViewController
{
    BOOL keyboardIsShown;
    BOOL data;
}

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, retain)
PFObject *textViewObject;
-(void) sendMyMessage;
-(void)didReceiveDataWithNotification:(NSNotification *)notification;

@end

