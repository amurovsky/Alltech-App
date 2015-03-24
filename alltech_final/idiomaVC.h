//
//  idiomaVC.h
//  Alltech
//
//  Created by Tejuino developers on 19/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface idiomaVC : UIViewController 



@property (weak, nonatomic) IBOutlet UINavigationBar *idiomaNav;

@property (weak, nonatomic) IBOutlet UIButton *espanolButton;
@property (weak, nonatomic) IBOutlet UIButton *ingelsButton;
@property (weak, nonatomic) IBOutlet UIButton *portuguesButton;
@property (weak, nonatomic) IBOutlet UILabel *segundaBarraLabel;
@property (weak, nonatomic) IBOutlet UINavigationItem *tituloNav;

- (IBAction)portuguesButton:(id)sender;

- (IBAction)inglesButton:(id)sender;

- (IBAction)espanolButton:(id)sender;

- (IBAction)returnButton:(id)sender;

@end
