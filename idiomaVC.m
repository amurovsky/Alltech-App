//
//  idiomaVC.m
//  Alltech
//
//  Created by Tejuino developers on 19/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "idiomaVC.h"

@interface idiomaVC ()

@end

@implementation idiomaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //poner fondo al view
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondoSideMenu"]];
    
    //cambiamos el fondo de la barra de navegacion
    [self.idiomaNav setBackgroundImage:[UIImage imageNamed:@"fondoSideMenu"]
                           forBarPosition:UIBarPositionAny
                               barMetrics:UIBarMetricsDefault];
    
    [self.idiomaNav setShadowImage:[UIImage new]];
    
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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)returnButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
