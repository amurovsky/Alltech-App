//
//  especiesVC.m
//  alltech_final
//
//  Created by Jose Esteban Garibay Castillo on 05/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "especiesVC.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import <AFNetworking.h>
#import "galeriasVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "loginVC.h"

@interface especiesVC ()

@end

@implementation especiesVC{
    NSMutableArray *especieID;
    NSMutableArray * especies;
    NSMutableArray * imgEspecies;
    
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
    especieID = [[NSMutableArray alloc]init];
    especies = [[NSMutableArray alloc]init];
    imgEspecies = [[NSMutableArray alloc]init];
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *programaID = [NSString stringWithFormat:@"%@", appDelegate.userSession.programaID];
    if ([programaID  isEqual: @"7"]) {
        
        [self.activityIndicator stopAnimating];
       
    }else{

        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{
                                     @"sessid"    : appDelegate.userSession.sesionID,
                                     @"id_product": appDelegate.userSession.productoID,
                                     @"opt"       : @"get_animals"
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

            [self.activityIndicator startAnimating];
            for(NSDictionary *tempDic in [responseObject objectForKey:@"animals"])
            {
                [especies addObject:[tempDic objectForKey:@"title"]];
//                [imgEspecies addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:
//                                                               [NSURL URLWithString:
//                                                                [NSString stringWithFormat:@"%@",[tempDic valueForKey:@"image"]]]]]];
                [imgEspecies addObject:[tempDic objectForKey:@"image"]];
                [especieID addObject:[tempDic objectForKey:@"id"]];
                NSLog(@"title es: %@", [tempDic valueForKey:@"title"]);
                
            }[self.especiesTable reloadData];
            NSLog(@"JSON: %@",responseObject);
            NSLog(@"array title: %@",especies);
            [self.activityIndicator stopAnimating];
        }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  
                  NSLog(@"Error: %@",error);
                  
              }];

    }
    
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
        imageView.frame = CGRectMake(screenWidth/2-60, 5, 125, 40);;
        
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
        
        porcentaje = 25;
        
    }
    // iphone 5, 5c, 5s, touch 5
    else if (screenWidth == 320 && screenHeight == 568){
        
        imageView.frame = CGRectMake(100, 5, 115, 30);
        porcentaje = 25;
        
    }
    // iphone 4, 4s, touch 4
    else if (screenWidth == 320 && screenHeight == 480){
        
        imageView.frame = CGRectMake(100, 5, 115, 30);
        porcentaje = 25;
        
    }
    
    
    // Sacamos el porcentaje asignado al sideMenu
    resultadoPorcentaje = (porcentaje * screenWidth) / 100;
    
    [self.especiesNav addSubview:imageView];
    
    
    //poner fondo al view
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    
    
    
    //cambiamos el fondo de la barra de navegacion
    [self.especiesNav setBackgroundImage:[UIImage imageNamed:@"fondo"]
                           forBarPosition:UIBarPositionAny
                               barMetrics:UIBarMetricsDefault];
    
    [self.especiesNav setShadowImage:[UIImage new]];
    
    
    
    
    //Slide-out right Menu
    
    SWRevealViewController * revealViewController = self.revealViewController;
    if (revealViewController) {
        
        
        [self.rightMenu setTarget: self.revealViewController];
        [self.rightMenu setAction: @selector( rightRevealToggle:)];
        revealViewController.rightViewRevealWidth= resultadoPorcentaje;
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

}

-(void)viewWillAppear:(BOOL)animated{


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
    
    // Return the number of rows in the section.
    
    return [especies count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath   {

    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    
    // declaramos la imagen lateral de los programas
    
    UIImageView *imgView;
    CGSize itemSize;
    
    //Redimencion de imagenes respecto a tamaño del dispositivo
    
    // ipad 2, ipad mini, ipad retina
    if (screenWidth == 768 && screenHeight == 1024) {
        
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(30, 18, 69, 69)];
        itemSize = CGSizeMake(100, 70);
        cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:25.0];
    }
    
    // iphone 6 plus
    if (screenWidth == 414 && screenHeight == 736) {
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(60, 15, 49, 49)];
        itemSize = CGSizeMake(100, 80);
        cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];

    }
    
    // iphone 6
    if (screenWidth == 375 && screenHeight == 667) {
        
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(40, 15, 49, 49)];
        itemSize = CGSizeMake(80, 80);
        cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];
        
        
    }
    // iphone 5, 5c, 5s, touch 5
    else if (screenWidth == 320 && screenHeight == 568){
        
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(30, 10, 40, 40)];
        itemSize = CGSizeMake(60, 50);
        cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:17.0];

        
    }
    // iphone 4, 4s, touch 4
    else if (screenWidth == 320 && screenHeight == 480){
        
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(35, 10, 40, 40)];
        itemSize = CGSizeMake(65, 30);
        cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:17.0];
        
    }
    
    
    //imgView.image =[imgEspecies objectAtIndex:indexPath.row];
    [imgView sd_setImageWithURL:[imgEspecies objectAtIndex:indexPath.row]
               placeholderImage:[UIImage imageNamed:@"photoEspecies"]];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [cell addSubview:imgView];
    
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    cell.textLabel.text = [especies objectAtIndex:indexPath.row];
    // cambiamos el color de la celda a transparente
    cell.backgroundColor = [UIColor clearColor];

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
    
    appDelegate.userSession.especieID = [especieID objectAtIndex:indexPath.row];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
NSIndexPath *indexPath = [self.especiesTable indexPathForSelectedRow];
    
    if ([segue.identifier isEqualToString:@"mostrarGalerias"]) {
        galeriasVC * galeria = segue.destinationViewController;
        NSString *nombreEspecie = [NSString stringWithFormat:@"%@", [especies objectAtIndex:indexPath.row]];
        galeria.nombrePrograma = self.nombredelPrograma;
        galeria.nombreProducto = self.nombredelProducto;
        galeria.nombreEspecie = nombreEspecie;
    }

}
- (IBAction)returnButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
    
}
@end
