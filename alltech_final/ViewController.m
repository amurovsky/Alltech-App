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


@interface ViewController () <UIGestureRecognizerDelegate, SWRevealViewControllerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) NSMutableArray *programas2;

@end

@implementation ViewController{
    
    
    NSArray *imgProgramas;
    NSArray *programas;
    
    CGRect screenBound;
    CGSize screenSize;
    CGFloat screenWidth;
    CGFloat screenHeight;
    CGFloat porcentaje;
    CGFloat resultadoPorcentaje;


}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"sessid"    : @"6cd36smnggp3efmeub0kfsrp51"
                                
                                 };
    [manager.requestSerializer setValue:@"sinspf34niufww44ib53ufds" forHTTPHeaderField:@"apikey"];
    [manager.requestSerializer setValue:@"dfaiun45vfogn234@" forHTTPHeaderField:@"password"];
    [manager.requestSerializer setValue:@"get_programs" forHTTPHeaderField:@"opt"];
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    [manager POST:@"http://192.168.15.101:7000/ws" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"JSON: %@",responseObject);
        //_getprograms = [responseObject objectForKey:@"programs"];
        for(_getprograms in [responseObject objectForKey:@"programs"])
        {
            [_programas2 addObject: @"fuck"];
            NSLog(@"title es: %@", [_getprograms objectForKey:@"title"]);
            
        }NSLog(@"veamos si por fin: %@",_programas2);
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"Error: %@",error);
            
          }];
    
    
    NSLog(@"veamos si por fin: %@",_programas2);
    
    
    //Inicializamos las variables para recoger las dimensiones de la pantalla
    
    screenBound = [[UIScreen mainScreen] bounds];
    screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;

    
    // Arreglos de los programas con sus respectivas imagenes
    
    //programas = [NSArray arrayWithObjects:@"Manejo de Minerales",@"Manejo de Salud Intestinal",@"Manejo de Micotoxinas",@"Manejo de Eficiencia Alimenticia",@"Manejo de Algas",@"Manejo de Proteinas",@"Otros productos",nil];
    imgProgramas =[NSArray arrayWithObjects:@"img1.png",@"img2.png",@"img3.png",@"img4.png",@"img5.png",@"img6.png",@"mas.png", nil];
    
    
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
        
//        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.revealViewController action:@selector(rightRevealToggle:)];
//        [self.view addGestureRecognizer:self.tapGestureRecognizer];
//        self.tapGestureRecognizer.enabled = NO;
//
//        [self.view addGestureRecognizer:revealViewController.panGestureRecognizer];
        
    }
    
    
    }


-(void)viewWillAppear:(BOOL)animated{

    
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

    return [programas count];
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
    
    cell.textLabel.text = [programas objectAtIndex:indexPath.row];
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
        
        if (indexPath.row >= 6) {
            
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-SemiBold" size:25.0];
            
        }else {
            
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:25.0];
        }
        
        
    }
    
    // iphone 6 plus
    if (screenWidth == 414 && screenHeight == 736) {
        
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(0, 15, 49, 49)];
        itemSize = CGSizeMake(40, 40);
        
        if (indexPath.row >= 6) {
            
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-SemiBold" size:19];
            
        }else {
            
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];
        }
        
    }
    
    // iphone 6
    if (screenWidth == 375 && screenHeight == 667) {
        
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(0, 15, 49, 49)];
        itemSize = CGSizeMake(40, 40);
        
        if (indexPath.row >= 6) {
            
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-SemiBold" size:19];
            
        }else {
            
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];
        }

        
    }
    // iphone 5, 5c, 5s, touch 5
    else if (screenWidth == 320 && screenHeight == 568){
        
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(0, 10, 40, 40)];
        itemSize = CGSizeMake(30, 30);
        
        if (indexPath.row >= 6) {
            
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-SemiBold" size:17];
            
        }else {
            
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:17.0];
        }

        
    }
    // iphone 4, 4s, touch 4
    else if (screenWidth == 320 && screenHeight == 480){
        
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(0, 10, 40, 40)];
        itemSize = CGSizeMake(30, 30);
        
        if (indexPath.row >= 6) {
            
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-SemiBold" size:17];
            
        }else {
            
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:17.0];
        }

        
    }


    
    
    imgView.image = [UIImage imageNamed:[imgProgramas objectAtIndex:indexPath.row] ];
    imgView.contentMode = UIViewContentModeCenter;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
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




// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.programasTable indexPathForSelectedRow];
    //UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    //destViewController.title = [[programas objectAtIndex:indexPath.row] capitalizedString];
    
    /*
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"mostrarProductos"]) {
        UINavigationController *navController = segue.destinationViewController;
        productosVC * photoController = [navController childViewControllers].firstObject;
        NSString *photoFilename = [NSString stringWithFormat:@"%@", [programas objectAtIndex:indexPath.row]];
        photoController.nombreDelPrograma = photoFilename;
    }
    
    */
    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"mostrarProductos"]) {
        //UINavigationController *navController = segue.destinationViewController;
        productosVC * productosController = segue.destinationViewController;
        NSString *nombreDelPrograma = [NSString stringWithFormat:@"%@", [programas objectAtIndex:indexPath.row]];
        productosController.nombreDelPrograma = nombreDelPrograma;
    }
    
}




@end
