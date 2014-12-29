//
//  ConnectionsViewController.h
//  comp3601CourseMate
//
//  Created by Gauhar Shakeel on 2014-10-29.
//  Copyright (c) 2014 Gauhar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "AppDelegate.h"

@interface ConnectionsViewController : UIViewController<MCBrowserViewControllerDelegate, UITextFieldDelegate, UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain) AppDelegate *appDelegate;

@property(nonatomic, retain) NSMutableArray *arr_connected_devices;


@property (strong, nonatomic) IBOutlet UITextField *txt_field_for_connec_name;
@property (strong, nonatomic) IBOutlet UISwitch *switch_visible;

@property (strong, nonatomic) IBOutlet UIButton *browse_for_devices;

@property (strong, nonatomic) IBOutlet UITableView *tble_view_for_connected_devices;

@property (strong, nonatomic) IBOutlet UIButton *disconnect_button_label;


-(void)peerDidChangeStateWithNotification:(NSNotification *)notification;

@end
