//
//  CMViewFileViewController.m
//  CourseMate
//
//  Created by Gauhar Shakeel on 2014-11-16.
//  Copyright (c) 2014 Gauhar. All rights reserved.
//

#import "CMViewFileViewController.h"
#import "SecondViewController.h"

@interface CMViewFileViewController ()
{
    NSString *selectedFile;
    NSError *errorReading;
}
@property (strong, nonatomic) IBOutlet UITextView *viewTextFromFile;
@property (nonatomic, retain) SecondViewController *parentView;



@end

@implementation CMViewFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.parentView = [[SecondViewController alloc] init];
    
    //selectedFile = [self.parentView getSelectedFile];
    
    if(selectedFile)
    {
        NSArray *myText = [[NSString stringWithContentsOfFile:selectedFile encoding:NSUTF8StringEncoding  error:nil] componentsSeparatedByString:@"\n"];
        for(int i =0; i< [myText count]; i++)
        {
            self.viewTextFromFile.text = [myText objectAtIndex:i];
        }
    }
    
    
    
   // self.viewTextFromFile.text = @"Hi I am Text View";
    // Do any additional setup after loading the view.
}

-(void) setSelectedFile:(NSString *)filePath
{
    selectedFile = filePath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
