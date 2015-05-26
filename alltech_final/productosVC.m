//
//  productosVC.m
//  alltech_final
//
//  Created by Tejuino developers on 04/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "productosVC.h"
#import "especiesVC.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>
#import "AppDelegate.h"
#import "galeriasVC.h"
#import "loginVC.h"


@interface productosVC ()

@end

@implementation productosVC{
    
    NSMutableArray *productos;
    NSMutableArray *productoID;
    CGRect screenBound;
    CGSize screenSize;
    CGFloat screenWidth;
    CGFloat screenHeight;
    CGFloat porcentaje;
    CGFloat resultadoPorcentaje;
    AppDelegate *appDelegate;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    productos = [[NSMutableArray alloc]init];
    productoID = [[NSMutableArray alloc]init];
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _programaID = [NSString stringWithFormat:@"%@", appDelegate.userSession.programaID];
    NSLog(@"Programa ID: %@",_programaID);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"sessid"    : appDelegate.userSession.sesionID,
                                 @"id_program": appDelegate.userSession.programaID,
                                 @"opt"       : @"get_products"
                                 };

    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    [manager POST:appDelegate.userSession.Url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        if ([[responseObject objectForKey:@"error"] isEqualToString:@"session_expired"]) {
            loginVC *login = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
            [appDelegate.userSession.settings setBool:NO forKey:@"logged"];
            UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Session Expired" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alerta show];
            [self presentViewController:login animated:YES completion:nil];
        }
 
        for(NSDictionary *tempDic in [responseObject objectForKey:@"products"])
        {
            [productos addObject: [tempDic objectForKey:@"title"]];
            [productoID addObject: [tempDic objectForKey:@"id"]];
            NSLog(@"title es: %@", [tempDic valueForKey:@"title"]);
            
        }[self.productosTable reloadData];
        NSLog(@"JSON: %@",responseObject);
        NSLog(@"array title: %@",productos);
        NSLog(@"array ID: %@",productoID);
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"Error: %@",error);
              
          }];
    
    //Inicializamos las variables para recoger las dimensiones de la pantalla
    
    screenBound = [[UIScreen mainScreen] bounds];
    screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;

    // Poner logo de Altech en barra de navegacion
    
    UIImage *image = [UIImage imageNamed:@"alltech_logo_naranja"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //redimensionar logo  y icono de menu de la barra de navegacion dependiendo del tamaño del dispositivo
    
    // ipad 2, ipad Air, ipad retina
    
    if (screenWidth == 768 && screenHeight == 1024) {
        
        
        //Imagen del logo de Alltech
        imageView.frame = CGRectMake(screenWidth/2-60, 5, 125, 40);
        
        porcentaje = 15;
        
        
    }
    
    // iphone 6 plus
    if (screenWidth == 414 && screenHeight == 736) {
        
        //Imagen del logo de Alltech
        imageView.frame = CGRectMake(150, 5, 125, 40);
        porcentaje =25;
        
    }
    
    // iphone 6
    if (screenWidth == 375 && screenHeight == 667) {
        
        //Imagen del logo de Alltech
        imageView.frame = CGRectMake(125, 5, 125, 40);
        
        porcentaje =25;
        
    }
    // iphone 5, 5c, 5s, touch 5
    else if (screenWidth == 320 && screenHeight == 568){
        
        imageView.frame = CGRectMake(100, 5, 115, 30);
        porcentaje =25;
        
    }
    // iphone 4, 4s, touch 4
    else if (screenWidth == 320 && screenHeight == 480){
        
        imageView.frame = CGRectMake(100, 5, 115, 30);
        porcentaje =25;
        
    }
    
    
    // Sacamos el porcentaje asignado al sideMenu
    resultadoPorcentaje = (porcentaje * screenWidth) / 100;


    
    [self.productosNav addSubview:imageView];
    
    //poner fondo al view
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    
    
    
    //cambiamos el fondo de la barra de navegacion
    [self.productosNav setBackgroundImage:[UIImage imageNamed:@"fondo"]
                           forBarPosition:UIBarPositionAny
                               barMetrics:UIBarMetricsDefault];
    
    [self.productosNav setShadowImage:[UIImage new]];
    
    
    
    //cambiamos el label de la segunda barra
    
    _programaLabel.text = [_nombreDelPrograma uppercaseString];
    self.programaLabel.adjustsFontSizeToFitWidth = YES;
    
    //Slide-out right Menu
    
    SWRevealViewController * revealViewController = self.revealViewController;
    if (revealViewController) {
        

        
        [self.rightMenu setTarget: self.revealViewController];
        [self.rightMenu setAction: @selector( rightRevealToggle:)];
        revealViewController.rightViewRevealWidth= resultadoPorcentaje;
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
        
        
    }

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    // Return the number of sections.
    
    return 1;
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [productos count];

}







- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
      cell.textLabel.text = [productos objectAtIndex:indexPath.row];
    
    // separador de celadas
    UIView *imgView = [[UIView alloc] init];
    imgView.backgroundColor = [UIColor orangeColor];

    
    // ipad 2 , ipad mini, ipad retina
    if (screenWidth == 768 && screenHeight == 1024) {

        imgView.frame = CGRectMake(0, 114, screenWidth, 1);
    }
    
    // iphone 6 plus
    if (screenWidth == 414 && screenHeight == 736) {
    
        imgView.frame = CGRectMake(0, 85, screenWidth, 1);
    }
    
    // iphone 6
    if (screenWidth == 375 && screenHeight == 667) {
 
        imgView.frame = CGRectMake(0, 73, screenWidth, 1);
    }
    // iphone 5, 5c, 5s, touch 5
    else if (screenWidth == 320 && screenHeight == 568){

        imgView.frame = CGRectMake(0, 63, screenWidth, 1);
    }
    // iphone 4, 4s, touch 4
    else if (screenWidth == 320 && screenHeight == 480){
     
        imgView.frame = CGRectMake(0, 53, screenWidth, 1);
    }

    [cell.contentView addSubview:imgView];
    
    // cambiamos el color de la celda a transparente
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font=[UIFont fontWithName:@"Aileron-Light" size:20.0];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
    
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *segueName = nil;
    NSString *programaID = [NSString stringWithFormat:@"%@", appDelegate.userSession.programaID];
    if ([programaID  isEqual: @"7"]) {
        segueName = @"mostrarGalerias";
    }else segueName = @"mostrarEspecies";
    
    appDelegate.userSession.productoID = [productoID objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier: segueName sender: self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
NSIndexPath *indexPath = [self.productosTable indexPathForSelectedRow];
    
    if ([segue.identifier isEqualToString:@"mostrarEspecies"]) {
        //UINavigationController *navController = segue.destinationViewController;
        especiesVC * productosController = segue.destinationViewController;
        NSString *nombredelProducto = [NSString stringWithFormat:@"%@", [productos objectAtIndex:indexPath.row]];
        productosController.nombredelProducto = nombredelProducto;
        productosController.nombredelPrograma = self.nombreDelPrograma;
    }else if ([segue.identifier isEqualToString:@"mostrarGalerias"]){
    
        galeriasVC *galerias = segue.destinationViewController;
        appDelegate.userSession.productoID = [productoID objectAtIndex:indexPath.row];
        appDelegate.userSession.especieID = @"1";
        galerias.nombrePrograma = self.nombreDelPrograma;
        galerias.nombreProducto = [NSString stringWithFormat:@"%@", [productos objectAtIndex:indexPath.row]];
        galerias.nombreEspecie = @"";
        //[[self navigationController ] pushViewController:galerias animated:YES];
        //[self.navigationController pushViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }

    
    
}


- (IBAction)returnButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
    
    
}
@end
