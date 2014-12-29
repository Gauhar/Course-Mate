//
//  CMViewPictureViewController.m
//  CourseMate
//
//  Created by Gauhar Shakeel on 2014-11-17.
//  Copyright (c) 2014 Gauhar. All rights reserved.
//

#import "CMViewPictureViewController.h"

@interface CMViewPictureViewController ()
{
    NSString *selectedFile;
    NSError *errorReading;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CMViewPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(selectedFile)
    {
        UIImage *image = [UIImage imageWithContentsOfFile:selectedFile];
        
//        self.imageView = [[UIImageView alloc] initWithImage: image];
        self.imageView.image = image;
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setPicturePath:(NSString *)filePath
{
    selectedFile = filePath;
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
