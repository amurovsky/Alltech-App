//
//  ViewController.h
//  Alltech
//
//  Created by Tejuino developers on 26/01/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "productosVC.h"

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *programasTable;
@property (weak, nonatomic) IBOutlet UINavigationBar *programasNav;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightMenu;



@end

