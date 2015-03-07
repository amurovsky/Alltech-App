
//
//  previewCell.m
//  Alltech
//
//  Created by Tejuino developers on 25/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "previewCell.h"

@interface previewCell()



@end


@implementation previewCell

-(void)awakeFromNib{

    _piedeFotoTextField.delegate = self;
    self.backgroundColor = [UIColor blackColor];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    return [self.piedeFotoTextField resignFirstResponder];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.piedeFotoTextField resignFirstResponder];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([[UIScreen mainScreen] bounds].size.width != 768) {
        [self animateTextField:textField up:YES];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([[UIScreen mainScreen] bounds].size.width != 768) {
        [self animateTextField:textField up:YES];
    }
}


-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = 255; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    //self.contentView.bounds = CGRectOffset(self.contentView.bounds, 0, movement);
    [[self.contentView superview] superview].bounds =CGRectOffset([[self.contentView superview] superview].bounds, 0, movement);
    [UIView commitAnimations];
    
    
}

@end

