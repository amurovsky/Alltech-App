//
//  OlvideVC.m
//  Alltech
//
//  Created by Tejuino developers on 30/01/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "OlvideVC.h"

@interface OlvideVC ()

@end

@implementation OlvideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [_mailTextField setDelegate:self];
    

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



-(BOOL) textFieldShouldReturn:(UITextField *)textField{

    [_mailTextField resignFirstResponder];
    
    return YES;
}
- (IBAction)recuperarButton:(id)sender {
    
    //_enviarMailView.hidden = NO;
    
    _enviadoLabel.hidden = NO;
    
    _correoLabel.hidden = NO;
    
    _mailTextField.hidden = YES;
    
    _IngresaLabel.hidden = YES;
    
    _recuperarButton.hidden = YES;
    
   
        
    _correoLabel.text = _mailTextField.text;
    
    [_mailTextField resignFirstResponder];
  
    
}




- (IBAction)regresarButton:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
