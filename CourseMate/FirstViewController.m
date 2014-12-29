//
//  FirstViewController.h
//  CourseMate
//
//  Created by Gauhar Shakeel on 2014-11-16.
//  Copyright (c) 2014 Gauhar. All rights reserved.
//


#import "FirstViewController.h"

//#import "JSMessagesViewController.h"

@interface FirstViewController() <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textFieldToEnter;
@property (strong, nonatomic) IBOutlet UIButton *sendButtonLabel;
@property (strong, nonatomic) IBOutlet UITextView *txtView;
@property (strong, nonatomic) IBOutlet UIView *accessoryView;

// the pfquery for retrieving the data over the data base
@property (nonatomic, retain) PFQuery *query;


@end
#pragma mark - View lifecycle
@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"Message Forum";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // self.messageForum.hidden = NO;
    
    self.title = @"Message Forum";
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _textFieldToEnter.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
    
    
    // persistence storage
    _textViewObject = [PFObject objectWithClassName:@"textViewObject"];
    
//    _query = [PFQuery queryWithClassName:@"textViewObject"];
//    int textForTextView  = [[_textViewObject objectForKey:@"related_id"] intValue];
    
   
    _textViewObject[@"fooo"] = @"";
    _textViewObject[@"related_id"] = @1;
    [_textViewObject saveInBackground];
    
   
     PFQuery *query = [PFQuery queryWithClassName:@"textViewObject"];
    
    [query whereKey:@"related_id" equalTo:@1];
    NSArray *objeArr = [query findObjects];
    //NSLog(@"this %@", [[objeArr objectAtIndex:1] objectForKey:@"fooo"]);
    _txtView.text = [[objeArr objectAtIndex:[objeArr count]-1] objectForKey:@"fooo"];
    
    
    
    
    
    //  self.textFieldToEnter.inputAccessoryView = self.accessoryView;
    
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.textFieldToEnter becomeFirstResponder];
    
    
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendMessage:(id)sender {
    
    [self sendMyMessage];
    //  [self.textFieldToEnter resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textFieldToEnter resignFirstResponder];
    
    return YES;
}



-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    // [self.textFieldToEnter becomeFirstResponder];
    //if([_textFieldToEnter isFirstResponder])
    
    // _textFieldToEnter.inputAccessoryView = self.accessoryView;
    
    return YES;
}

-(void) sendMyMessage
{
    NSData *dataToSend = [_textFieldToEnter.text dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *allPeers = _appDelegate.mcManager.session.connectedPeers;
    NSError *error;
    
    [_appDelegate.mcManager.session sendData:dataToSend
                                     toPeers:allPeers
                                    withMode:MCSessionSendDataReliable
                                       error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    [_txtView setText:[_txtView.text stringByAppendingString:[NSString stringWithFormat:@"I wrote:\n%@\n\n", _textFieldToEnter.text]]];
    [_textFieldToEnter setText:@""];
    [_textFieldToEnter resignFirstResponder];
    
    NSString *strFromTextView = _txtView.text;
    NSLog(@"text is textview is %@",strFromTextView);
    
    
    _textViewObject[@"fooo"] = strFromTextView;
    _textViewObject[@"related_id"] = @1;
    [_textViewObject saveInBackground];
    
    
}

-(void)didReceiveDataWithNotification:(NSNotification *)notification{
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    [_txtView performSelectorOnMainThread:@selector(setText:) withObject:[_txtView.text stringByAppendingString:[NSString stringWithFormat:@"%@ wrote:\n%@\n\n", peerDisplayName, receivedText]] waitUntilDone:NO];
    
    NSString *strFromTextView = _txtView.text;
    NSLog(@"text is textview is %@",strFromTextView);
    
    
    _textViewObject[@"fooo"] = strFromTextView;
    _textViewObject[@"related_id"] = @1;
    [_textViewObject saveInBackground];
}



@end
