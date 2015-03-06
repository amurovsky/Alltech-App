//
//  productosVC.h
//  alltech_final
//
//  Created by Tejuino developers on 04/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface productosVC : UIViewController <UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong) NSString * nombreDelPrograma;
@property(nonatomic,strong) NSString * programaID;

@property (weak, nonatomic) IBOutlet UINavigationBar *productosNav;

@property (weak, nonatomic) IBOutlet UITableView *productosTable;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightMenu;

@property (weak, nonatomic) IBOutlet UIImageView *segundaBarraImg;

@property (weak, nonatomic) IBOutlet UILabel *programaLabel;


- (IBAction)returnButton:(id)sender;

@end
