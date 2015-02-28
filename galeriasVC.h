//
//  galeriasVC.h
//  Alltech
//
//  Created by Tejuino developers on 09/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import "MWCaptionView.h"

@interface galeriasVC : UIViewController <UITableViewDelegate, UITableViewDataSource,MWPhotoBrowserDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *galeriasNav;

@property (weak, nonatomic) IBOutlet UITableView *galeriasTable;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightMenu;

@property (nonatomic, strong) NSMutableArray *photos;

- (IBAction)returnButton:(id)sender;



@end






