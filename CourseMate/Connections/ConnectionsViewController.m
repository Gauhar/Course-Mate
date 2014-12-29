//
//  ConnectionsViewController.m
//  comp3601CourseMate
//
//  Created by Gauhar Shakeel on 2014-10-29.
//  Copyright (c) 2014 Gauhar. All rights reserved.
//

#import "ConnectionsViewController.h"

@interface ConnectionsViewController ()

@end

@implementation ConnectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[_appDelegate mcManager] setupPeerAndSessionWithDisplayName:[UIDevice currentDevice].name];
    [[_appDelegate mcManager] advertiseSelf:self.switch_visible.isOn];
    
    [self.txt_field_for_connec_name setDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(peerDidChangeStateWithNotification:)
                                                 name:@"MCDidChangeStateNotification"
                                               object:nil];
    
    self.arr_connected_devices = [[NSMutableArray alloc]init];
    
    [self.tble_view_for_connected_devices setDelegate:self];
    [self.tble_view_for_connected_devices setDataSource:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// browse devices Action
- (IBAction)browseDevices:(id)sender {
    
    [[_appDelegate mcManager] setupMCBrowser];
    [[[_appDelegate mcManager] browser] setDelegate:self];
    [self presentViewController:[[_appDelegate mcManager] browser] animated:YES completion:nil];
    
    
}


-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController{
    [_appDelegate.mcManager.browser dismissViewControllerAnimated:YES completion:nil];
}


-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    [_appDelegate.mcManager.browser dismissViewControllerAnimated:YES completion:nil];
}


// toogle Button
- (IBAction)toogleButton:(id)sender {
    
    [self.appDelegate.mcManager advertiseSelf:self.switch_visible.isOn];
}

// disconnect button action
- (IBAction)disconnectButton:(id)sender {
    
    [_appDelegate.mcManager.session disconnect];
    
    self.txt_field_for_connec_name.enabled = YES;
    
    [_arr_connected_devices removeAllObjects];
    [_tble_view_for_connected_devices reloadData];
}


// the txtfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.txt_field_for_connec_name resignFirstResponder];
    
    _appDelegate.mcManager.peerID = nil;
    _appDelegate.mcManager.session = nil;
    _appDelegate.mcManager.browser = nil;
    
    if ([self.switch_visible isOn]) {
        [self.appDelegate.mcManager.advertiser stop];
    }
    _appDelegate.mcManager.advertiser = nil;
    
    
    [self.appDelegate.mcManager setupPeerAndSessionWithDisplayName:self.txt_field_for_connec_name.text];
    [self.appDelegate.mcManager setupMCBrowser];
    [self.appDelegate.mcManager advertiseSelf:self.switch_visible.isOn];
    
    return YES;
}

// for notification

-(void)peerDidChangeStateWithNotification:(NSNotification *)notification{
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    MCSessionState state = [[[notification userInfo] objectForKey:@"state"] intValue];
    
    if (state != MCSessionStateConnecting) {
        if (state == MCSessionStateConnected) {
            [self.arr_connected_devices addObject:peerDisplayName];
        }
        else if (state == MCSessionStateNotConnected){
            if ([self.arr_connected_devices count] > 0) {
                int indexOfPeer = [self.arr_connected_devices indexOfObject:peerDisplayName];
                [self.arr_connected_devices removeObjectAtIndex:indexOfPeer];
            }
        }
        
        [self.tble_view_for_connected_devices reloadData];
        
        BOOL peersExist = ([[_appDelegate.mcManager.session connectedPeers] count] == 0);
        [self.disconnect_button_label setEnabled:!peersExist];
        [self.txt_field_for_connec_name setEnabled:peersExist];
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arr_connected_devices count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    
    cell.textLabel.text = [_arr_connected_devices objectAtIndex:indexPath.row];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
