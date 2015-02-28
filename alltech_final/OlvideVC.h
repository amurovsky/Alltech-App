//
//  OlvideVC.h
//  Alltech
//
//  Created by Tejuino developers on 30/01/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OlvideVC : UIViewController < UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *IngresaLabel;

@property (weak, nonatomic) IBOutlet UITextField *mailTextField;

@property (weak, nonatomic) IBOutlet UIButton *recuperarButton;

- (IBAction)recuperarButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *enviadoLabel;
@property (weak, nonatomic) IBOutlet UILabel *correoLabel;

@property (weak, nonatomic) IBOutlet UIView *bluredView;



@end
