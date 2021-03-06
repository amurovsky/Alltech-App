//
//  ViewController.m
//  Alltech
//
//  Created by Tejuino developers on 26/01/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "productosVC.h"
#import "session.h"
#import <AFNetworking.h>
#import "AppDelegate.h"
#import <MBProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "loginVC.h"
#import "Reachability.h"
#import "galeriasVC.h"

@interface ViewController () <UIGestureRecognizerDelegate, SWRevealViewControllerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) NSMutableArray *programas;

@end

@implementation ViewController{

    NSMutableArray *imgProgramas;
    NSMutableArray *programaID;
    CGRect screenBound;
    CGSize screenSize;
    CGFloat screenWidth;
    CGFloat screenHeight;
    CGFloat porcentaje;
    CGFloat resultadoPorcentaje;
    AppDelegate *appDelegate;
    BOOL internet;
    NSMutableDictionary *programasGuardados;
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    //Inicializamos las variables para recoger las dimensiones de la pantalla
    
    screenBound = [[UIScreen mainScreen] bounds];
    screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    _programas = [[NSMutableArray alloc]init];
    imgProgramas = [[NSMutableArray alloc]init];
    programaID = [[NSMutableArray alloc]init];
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        internet = NO;
        //No internet
        NSLog(@"No Internet");
        [_uiActivator stopAnimating];
//        [_programas addObject:@"Programas Offline"];
//        UILabel *offline = [[UILabel  alloc]init];
//        [offline setFrame:CGRectMake(0, screenHeight - 40, screenWidth, 20)];
//        offline.textAlignment = NSTextAlignmentCenter;
//        offline.text = @"OFFLINE MODE";
//        offline.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];
//        [self.view insertSubview:offline aboveSubview:self.programasTable];
        programasGuardados = [appDelegate.userSession.settings objectForKey:@"programas"];
        for (NSDictionary *tempDic in programasGuardados) {
            [_programas addObject: [tempDic objectForKey:@"title"]];
            
            [imgProgramas addObject:[tempDic valueForKey:@"image"]];
            
            [programaID addObject:[tempDic valueForKey:@"id"]];
        }
        
    }else{
        internet = YES;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{
                                     @"sessid"  : appDelegate.userSession.sesionID,
                                     @"opt"     : @"get_programs"
                                     };

        [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
        [manager POST:appDelegate.userSession.Url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
            NSLog(@"Respuesta Programas: %@",responseObject);
            programasGuardados = [responseObject objectForKey:@"programs"];
            if ([[responseObject objectForKey:@"error"] isEqualToString:@"session_expired"]) {
                loginVC *login = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
                [appDelegate.userSession.settings setBool:NO forKey:@"logged"];
                UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Session Expired" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alerta show];
                [self presentViewController:login animated:YES completion:nil];
            }
            //zxxif (![[responseObject objectForKey:@"programs"] count] == [[appDelegate.userSession.settings objectForKey:@"programas"] count]) {
                //comparamos el diccionario guardado con el de respuesta si son iguales carga el guardado si no carga la actualizacion del server
                NSLog(@"Entro a Diferente server y guardado");
                NSLog(@"Idioma: %@",[appDelegate.userSession.settings objectForKey:@"lang"]);
                [_uiActivator startAnimating];

                for(NSDictionary *tempDic in [responseObject objectForKey:@"programs"])
                {
                    [_programas addObject: [tempDic objectForKey:@"title"]];

                    [imgProgramas addObject:[tempDic valueForKey:@"image"]];
                    
                    [programaID addObject:[tempDic valueForKey:@"id"]];
                    
                    NSLog(@"imagenes : %@",imgProgramas);
                    
                }
                [appDelegate.userSession.settings setObject:programasGuardados forKey:@"programas"];
                [self.programasTable reloadData];
                NSLog(@"JSON: %@",responseObject);
                NSLog(@"array title: %@",_programas);
                NSLog(@"array imagen: %@",imgProgramas);
            
                [_uiActivator stopAnimating];
//            }else{
//                [_uiActivator stopAnimating];
//                programasGuardados = [appDelegate.userSession.settings objectForKey:@"programas"];
//                for (NSDictionary *tempDic in programasGuardados) {
//                    [_programas addObject: [tempDic objectForKey:@"title"]];
//                    [imgProgramas addObject:[tempDic valueForKey:@"image"]];
//                    [programaID addObject:[tempDic valueForKey:@"id"]];
//                    
//                    NSLog(@"imagenes : %@",imgProgramas);
//                }[self.programasTable reloadData];
//                
//            }
            
        }
        
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  
                  NSLog(@"Error: %@",error);
                
              }];
        
    }


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
    else if (screenWidth == 414 && screenHeight == 736) {
        
        //Imagen del logo de Alltech
        imageView.frame = CGRectMake(150, 5, 125, 40);
        porcentaje =25;
    }
    
    // iphone 6
    else if (screenWidth == 375 && screenHeight == 667) {
        
        //Imagen del logo de Alltech
        imageView.frame = CGRectMake(125, 5, 125, 40);
        
        porcentaje = 25;
        
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
    
    //Agregamos a la vista el icono de menu y el logo de alltech

    [self.programasNav addSubview:imageView];
    
    
    //poner fondo al view
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    
    
    
    //cambiamos el fondo de la barra de navegacion
    [self.programasNav setBackgroundImage:[UIImage imageNamed:@"fondo"]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    
    [self.programasNav setShadowImage:[UIImage new]];
    
    
    
    
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
    [self.programasTable reloadData];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_programas count];
    
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



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [_programas objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.textLabel.numberOfLines=2;

    // declaramos la imagen lateral de los programas
    
    UIImageView *imgView;
    CGSize itemSize;
    
    
    //Redimencion de imagenes respecto a tamaño del dispositivo
    
    // ipad 2, ipad mini, ipad retina
    if (screenWidth == 768 && screenHeight == 1024) {
        
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(0, 15, 69, 69)];
        itemSize = CGSizeMake(70, 70);
        cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:25.0];

    }
    
    // iphone 6 plus
    if (screenWidth == 414 && screenHeight == 736) {
        
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(20, 15, 49, 49)];
        itemSize = CGSizeMake(60 , 40);
        cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];

    }
    
    // iphone 6
    if (screenWidth == 375 && screenHeight == 667) {
        
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(0, 15, 49, 49)];
        itemSize = CGSizeMake(40, 40);
        cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];
 
    }
    // iphone 5, 5c, 5s, touch 5
    else if (screenWidth == 320 && screenHeight == 568){
        
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(10, 10, 40, 40)];
        itemSize = CGSizeMake(40, 30);
        cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:17.0];
    }
    // iphone 4, 4s, touch 4
    else if (screenWidth == 320 && screenHeight == 480){
        
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(10, 10, 40, 40)];
        itemSize = CGSizeMake(40, 30);
        cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:17.0];
    }
    
    [imgView sd_setImageWithURL:[imgProgramas objectAtIndex:indexPath.row]
                   placeholderImage:[UIImage imageNamed:@"photo.jpg"]];

    
    //imgView.image = [imgProgramas objectAtIndex:indexPath.row];
    
    
    //imgView.image = [UIImage imageNamed:[imgProgramas objectAtIndex:indexPath.row] ];
    //imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[imgProgramas objectAtIndex:indexPath.row]]]];
    
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.layer.cornerRadius = imgView.frame.size.width/2;
    imgView.clipsToBounds = YES;
    [cell addSubview:imgView];
    
    
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    
    // cambiamos el color de la celda a transparente
    cell.backgroundColor = [UIColor clearColor];


    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *segueName = nil;
    if (internet == YES) {
        segueName = @"mostrarProductos";
        appDelegate.userSession.programaID = [programaID objectAtIndex:indexPath.row];
    }else segueName = @"galeriasOffline";
    
    
    [self performSegueWithIdentifier: segueName sender: self];

    
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.programasTable indexPathForSelectedRow];
    NSString *nombreDelPrograma = [NSString stringWithFormat:@"%@", [_programas objectAtIndex:indexPath.row]];
    if ([segue.identifier isEqualToString:@"mostrarProductos"]) {
        productosVC * productosController = segue.destinationViewController;
        
        productosController.nombreDelPrograma = nombreDelPrograma;
        
    }else if ([segue.identifier isEqualToString:@"galeriasOffline"]){
        galeriasVC * galerias = segue.destinationViewController;
        galerias.nombrePrograma = nombreDelPrograma;
    }
    
}




@end
