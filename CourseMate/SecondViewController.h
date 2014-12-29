//
//  SecondViewController.h
//  CourseMate
//
//  Created by Gauhar Shakeel on 2014-11-16.
//  Copyright (c) 2014 Gauhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
{
    
}

@property (strong, nonatomic) IBOutlet UITableView *tblFiles;
-(NSString *) getSelectedFile;
@end

