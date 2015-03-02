//
//  sideMenu.m
//  Alltech
//
//  Created by Tejuino developers on 19/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "sideMenu.h"

@interface sideMenu ()

@end

@implementation sideMenu{

    CGRect screenBound;
    CGSize screenSize;
    CGFloat screenWidth;
    CGFloat screenHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //Inicializamos las variables para recoger las dimensiones de la pantalla
    
    screenBound = [[UIScreen mainScreen] bounds];
    screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    
    CGRect frameIpad = CGRectMake(90, 25, 60, 60);
    CGRect frameIphone = CGRectMake(85, 15, 40, 40);
    
    
    // ipad
    if (screenWidth == 768 && screenHeight == 1024) {

        _camaraImg.frame = frameIpad;
        _idiomaImg.frame = frameIpad;
        _logoutImg.frame = frameIpad;
        [_separatorImg[0] setFrame:CGRectMake(75, 115, 90, 2)];
        [_separatorImg[1] setFrame:CGRectMake(75, 115, 90, 2)];
        [_separatorImg[2] setFrame:CGRectMake(75, 115, 90, 2)];
        
    }
    // iphone 6 plus
    else if (screenWidth == 414 && screenHeight == 736) {
        _camaraImg.frame = frameIphone;
        _idiomaImg.frame = frameIphone;
        _logoutImg.frame = frameIphone;
        [_separatorImg[0] setFrame:CGRectMake(75, 72, 60, 1)];
        [_separatorImg[1] setFrame:CGRectMake(75, 72, 60, 1)];
        [_separatorImg[2] setFrame:CGRectMake(75, 72, 60, 1)];
    }
    // Iphone 6
    else if (screenWidth == 375 && screenHeight == 667) {
        
        _camaraImg.frame = frameIphone;
        _idiomaImg.frame = frameIphone;
        _logoutImg.frame = frameIphone;
        [_separatorImg[0] setFrame:CGRectMake(75, 72, 60, 1)];
        [_separatorImg[1] setFrame:CGRectMake(75, 72, 60, 1)];
        [_separatorImg[2] setFrame:CGRectMake(75, 72, 60, 1)];
        
        // iphone 5, 5c, 5s, touch 5
    }else if (screenWidth == 320 && screenHeight == 568){
        
        [_separatorImg[0] setFrame:CGRectMake(75, 115, 90, 2)];
        _camaraImg.frame = frameIphone;
        _idiomaImg.frame = frameIphone;
        _logoutImg.frame = frameIphone;
        [_separatorImg[0] setFrame:CGRectMake(75, 72, 60, 1)];
        [_separatorImg[1] setFrame:CGRectMake(75, 72, 60, 1)];
        [_separatorImg[2] setFrame:CGRectMake(75, 72, 60, 1)];
    }
  
    
    //poner fondo al view
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondoSideMenu"]];
    

}

-(void)viewDidAppear:(BOOL)animated{

 //[[UIApplication sharedApplication] setStatusBarHidden:YES];

}

-(void)viewWillDisappear:(BOOL)animated{

 //[[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self hideStatusBar];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 3;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Redimension de celdas respecto al tamaño del dispositivo
    
    // ipad 2 , ipad mini, ipad retina
    if (screenWidth == 768 && screenHeight == 1024) {
        
        return 115;
    }
    
    // iphone 6 plus
    if (screenWidth == 414 && screenHeight == 736) {
        
        return 84;
        
    }
    
    // iphone 6
    if (screenWidth == 375 && screenHeight == 667) {
        
        return 74;
    }
    // iphone 5, 5c, 5s, touch 5
    else if (screenWidth == 320 && screenHeight == 568){
        
        return 64;
        
    }
    // iphone 4, 4s, touch 4
    else if (screenWidth == 320 && screenHeight == 480){
        
        return 54;
        
    }
    
    return 54;
    
}


////Cambiamos a blanco el color de la status Bar
//
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}
#pragma mark - Hide statusbar

-(void)hideStatusBar {
    
    [self setNeedsStatusBarAppearanceUpdate];

    //[[UIApplication sharedApplication] setStatusBarHidden:NO];

}

- (BOOL)prefersStatusBarHidden {

    if (self.isViewLoaded) {
        return YES;
    }return NO;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
