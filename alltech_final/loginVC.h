//
//  loginVC.h
//  Alltech
//
//  Created by Tejuino developers on 29/01/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "canvas.h"

@interface loginVC : UIViewController <UITextFieldDelegate> 

@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)loginButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *olvideMiContrasenaBlurView;


- (IBAction)olvideMiContrasenaButton:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *ingresaCorreoLabel;

@property (weak, nonatomic) IBOutlet UITextField *correoTexField;

@property (weak, nonatomic) IBOutlet UIButton *recuperarButton;

@property (weak, nonatomic) IBOutlet UILabel *enviadoLabel;

@property (weak, nonatomic) IBOutlet UILabel *enviadoCorreoLabel;

- (IBAction)regresarButton:(id)sender;

- (IBAction)recuperarButton:(id)sender;

@property (strong, nonatomic) IBOutlet CSAnimationView *loginConteiner;

@end
