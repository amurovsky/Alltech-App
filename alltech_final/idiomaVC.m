//
//  idiomaVC.m
//  Alltech
//
//  Created by Tejuino developers on 19/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "idiomaVC.h"
#import "AppDelegate.h"
#import <AFNetworking.h>
#import "SWRevealViewController.h"

@interface idiomaVC (){

    AppDelegate *appDelegate;
    UIImageView *check;
    NSInteger margen;

}

@end

@implementation idiomaVC

- (void)viewDidLoad {
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //poner fondo al view
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondoSideMenu"]];
    
    //cambiamos el fondo de la barra de navegacion
    [self.idiomaNav setBackgroundImage:[UIImage imageNamed:@"fondoSideMenu"]
                           forBarPosition:UIBarPositionAny
                               barMetrics:UIBarMetricsDefault];
    
    [self.idiomaNav setShadowImage:[UIImage new]];
    
    check =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check"]];
    
    margen = 60;
    
    NSLog(@"guardado en nsuserdefaults: %@",[appDelegate.userSession.settings objectForKey:@"lang"]);
   
    
    
    [self.view addSubview:check];
    
    
}

-(void)viewDidLayoutSubviews{
    NSString *lenguaje = appDelegate.userSession.lenguaje;
    if ([lenguaje  isEqual: @"es"]){
        [self.espanolButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        check.center = CGPointMake(self.espanolButton.bounds.size.width - margen, self.espanolButton.center.y);
        self.tituloNav.title = @"Ajustes";
        self.segundaBarraLabel.text = @"Cambiar Idioma";
    }else if ([lenguaje  isEqual: @"en"]){
        [self.ingelsButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        check.center = CGPointMake(self.ingelsButton.bounds.size.width - margen, self.ingelsButton.center.y);
        self.tituloNav.title = @"Settings";
        self.segundaBarraLabel.text = @"Change Language";
    }else if ([lenguaje  isEqual: @"pt"]){
        [self.portuguesButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        check.center = CGPointMake(self.portuguesButton.bounds.size.width - margen, self.portuguesButton.center.y);
        self.tituloNav.title = @"definições";
        self.segundaBarraLabel.text = @"mudar idioma";
    }

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

- (IBAction)portuguesButton:(id)sender {
    

    [self.portuguesButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.espanolButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.ingelsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    appDelegate.userSession.lenguaje = @"pt";
    check.center = CGPointMake(self.portuguesButton.bounds.size.width - margen, self.portuguesButton.center.y);
    [self cambiarIdioma];
    self.tituloNav.title = @"definições";
    self.segundaBarraLabel.text = @"mudar idioma";
    [appDelegate.userSession.settings setObject:@"pt" forKey:@"lang"];
    [appDelegate.userSession.settings synchronize];
}

- (IBAction)inglesButton:(id)sender {
    [self.ingelsButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.espanolButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.portuguesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    appDelegate.userSession.lenguaje = @"en";
    check.center = CGPointMake(self.ingelsButton.bounds.size.width - margen, self.ingelsButton.center.y);
    self.tituloNav.title = @"Settings";
    self.segundaBarraLabel.text = @"Change Language";
    [self cambiarIdioma];
    [appDelegate.userSession.settings setObject:@"en" forKey:@"lang"];
    [appDelegate.userSession.settings synchronize];
}
- (IBAction)espanolButton:(id)sender {
    [self.espanolButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.portuguesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.ingelsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    appDelegate.userSession.lenguaje = @"es";
    check.center = CGPointMake(self.espanolButton.bounds.size.width - margen, self.espanolButton.center.y);
    self.tituloNav.title = @"Ajustes";
    self.segundaBarraLabel.text = @"Cambiar Idioma";
    [self cambiarIdioma];
    [appDelegate.userSession.settings setObject:@"es" forKey:@"lang"];
    [appDelegate.userSession.settings synchronize];
}

-(void)cambiarIdioma{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"sessid" : appDelegate.userSession.sesionID,
                                 @"lang"   : appDelegate.userSession.lenguaje,
                                 @"opt"    : @"set_lang"
                                 };
    [manager.requestSerializer setValue:@"sinspf34niufww44ib53ufds" forHTTPHeaderField:@"apikey"];
    [manager.requestSerializer setValue:@"dfaiun45vfogn234@" forHTTPHeaderField:@"password"];
    [manager.requestSerializer setValue:@"set_lang" forHTTPHeaderField:@"opt"];
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    [manager POST:appDelegate.userSession.Url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSLog(@"JSON: %@",responseObject);
        
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"Error: %@",error);
              
          }];

}

- (IBAction)returnButton:(id)sender {
    
        SWRevealViewController *revealcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    [self presentViewController:revealcontroller animated:YES completion:nil];
    
}
@end
