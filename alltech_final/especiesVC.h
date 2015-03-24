//
//  especiesVC.h
//  alltech_final
//
//  Created by Jose Esteban Garibay Castillo on 05/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface especiesVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UINavigationBar *especiesNav;

@property (weak, nonatomic) IBOutlet UITableView *especiesTable;

@property (nonatomic, strong) NSString * nombredelProducto;

@property (nonatomic, strong) NSString * nombredelPrograma;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightMenu;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)returnButton:(id)sender;


@end



