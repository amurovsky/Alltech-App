
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

-(void)setFotos:(NSArray *)fotos{

    int index;
    
    for (index=0; index<fotos.count; index++) {
       // self.previewImg =[UIImageView alloc]initWithImage:[UIImage imageNamed:@"%@",[fotos objectAtIndex:index]];
    }
   // NSLog(@"esto es lo que trae fotos: %@",fotos;

}

-(void)setPiedeFotoTextField:(UITextField *)piedeFotoTextField{
    
    self.piedeFotoTextField.delegate = self;

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    return [self.piedeFotoTextField resignFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self.piedeFotoTextField resignFirstResponder];
}
@end

