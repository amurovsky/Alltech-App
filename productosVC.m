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


@interface productosVC ()

@end

@implementation productosVC{
    
    NSMutableArray * productos;
    NSArray * productosMinerales;
    NSArray * productosSaludIntestinal;
    NSArray * productosMicotoxinas;
    NSArray * productosEficienciaAlimenticia;
    NSArray * productosAlgas;
    NSArray * productosProteinas;
    NSArray * productosotros;
    CGRect screenBound;
    CGSize screenSize;
    CGFloat screenWidth;
    CGFloat screenHeight;

    CGFloat porcentaje;
    CGFloat resultadoPorcentaje;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    
    //Inicializamos las variables para recoger las dimensiones de la pantalla
    
    screenBound = [[UIScreen mainScreen] bounds];
    screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;

    
    
    NSLog(@"programas nos manda : %@",_nombreDelPrograma);
    
    productosMinerales = @[@"Bioplex",@"Selplex",@"Elonomase"];
    productosSaludIntestinal = @[@"Actigen",@"Bio-Mos",@"Acid Pak",@"Yea-Sacc"];
    productosMicotoxinas = @[@"Mycosorb"];
    productosEficienciaAlimenticia = @[@"Allzyme SSF",@"Allzyme VegPro"];
    productosAlgas = @[@"All-G-Rich",@"LG Max"];
    productosProteinas =@[@"NuPRO",@"Optigen"];
    productosotros = @[@"Advantage Packs",@"Yea-Sacc"];
    
    productos = [[NSMutableArray alloc] init];
    
    
    [productos addObject:productosMinerales];
    [productos addObject:productosSaludIntestinal];
    [productos addObject:productosMicotoxinas];
    [productos addObject:productosEficienciaAlimenticia];
    [productos addObject:productosAlgas];
    [productos addObject:productosProteinas];
    [productos addObject:productosotros];
    
    
    NSLog(@"Este es mi arreglo con arreglos Anidados: %@",productos);
    
    
    
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
    
    
    //cambiar imagen de la segunda barra segun el programa seleccionado
    
    if ([_nombreDelPrograma  isEqual: @"Manejo de Minerales"]) {
        self.segundaBarraImg.image =[UIImage imageNamed:@"Manejo_Minerales-logo"];
  
    }else if ([_nombreDelPrograma  isEqual: @"Manejo de Salud Intestinal"]){
        self.segundaBarraImg.image =[UIImage imageNamed:@"Salud_Intestinal-logo"];
    }else if ([_nombreDelPrograma  isEqual: @"Manejo de Micotoxinas"]){
        self.segundaBarraImg.image =[UIImage imageNamed:@"Manejo_Micotoxinas-logo"];
    }else if ([_nombreDelPrograma  isEqual: @"Manejo de Eficiencia Alimenticia"]){
        self.segundaBarraImg.image =[UIImage imageNamed:@"Eficiencia_Alimenticia-logo"];
    }else if ([_nombreDelPrograma  isEqual: @"Manejo de Algas"]){
        self.segundaBarraImg.image =[UIImage imageNamed:@"Manejo_Algas-logo"];
    }else if ([_nombreDelPrograma  isEqual: @"Manejo de Proteinas"]){
        self.segundaBarraImg.image =[UIImage imageNamed:@"Manejo_Proteinas-logo"];
    }else if ([_nombreDelPrograma  isEqual: @"Otros productos"]){
        self.segundaBarraImg.image =[UIImage imageNamed:@"Manejo_Minerales-logo"];
    }

    
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
    
    // Return the number of rows in the section.
    
    
    
    
    
    if ([_nombreDelPrograma  isEqual: @"Manejo de Minerales"]) {
        
        
        
        return [productos[0] count];
        
        
        
    }else if ([_nombreDelPrograma  isEqual: @"Manejo de Salud Intestinal"]){
        
        
        
        return [productos[1] count];
        
        
        
    }else if ([_nombreDelPrograma  isEqual: @"Manejo de Micotoxinas"]){
        
        
        
        return [productos[2] count];
        
        
        
    }else if ([_nombreDelPrograma  isEqual: @"Manejo de Eficiencia Alimenticia"]){
        
        
        
        return [productos[3] count];
        
        
        
    }else if ([_nombreDelPrograma  isEqual: @"Manejo de Algas"]){
        
        
        
        return [productos[4] count];
        
        
        
    }else if ([_nombreDelPrograma  isEqual: @"Manejo de Proteinas"]){
        
        
        
        return [productos[5] count];
        
        
        
    }else if ([_nombreDelPrograma  isEqual: @"Otros productos"]){
        
        
        
        return [productos[6] count];
        
        
        
    }
    
    return [productos count];
    

    
}







- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    
    
    
    if ([_nombreDelPrograma  isEqual: @"Manejo de Minerales"]) {
        
        
        
        cell.textLabel.text = [productos[0] objectAtIndex:indexPath.row];
        
        
        
    }else if ([_nombreDelPrograma  isEqual: @"Manejo de Salud Intestinal"]){
        
        
        
        cell.textLabel.text = [productos[1] objectAtIndex:indexPath.row];
        
        
        
    }else if ([_nombreDelPrograma  isEqual: @"Manejo de Micotoxinas"]){
        
        
        
        cell.textLabel.text = [productos[2] objectAtIndex:indexPath.row];
        
        
        
    }else if ([_nombreDelPrograma  isEqual: @"Manejo de Eficiencia Alimenticia"]){
        
        
        
        cell.textLabel.text = [productos[3] objectAtIndex:indexPath.row];
        
        
        
    }else if ([_nombreDelPrograma  isEqual: @"Manejo de Algas"]){
        
        
        
        cell.textLabel.text = [productos[4] objectAtIndex:indexPath.row];
        
        
        
    }else if ([_nombreDelPrograma  isEqual: @"Manejo de Proteinas"]){
        
        
        
        cell.textLabel.text = [productos[5] objectAtIndex:indexPath.row];
        
        
        
    }else if ([_nombreDelPrograma  isEqual: @"Otros productos"]){
        
        
        
        cell.textLabel.text = [productos[6] objectAtIndex:indexPath.row];
        
        
        
    }
    
    // separador de celadas
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separatorCell"]];

    
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



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.productosTable indexPathForSelectedRow];
   // UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    //destViewController.title = [[productos objectAtIndex:indexPath.row] capitalizedString];
    
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
    if ([segue.identifier isEqualToString:@"mostrarEspecies"]) {
        //UINavigationController *navController = segue.destinationViewController;
        especiesVC * productosController = segue.destinationViewController;
        NSString *photoFilename = [NSString stringWithFormat:@"%@", [productos objectAtIndex:indexPath.row]];
        productosController.nombreDeLaEspecie = photoFilename;
    }

    
    
}


- (IBAction)returnButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
    
    
}
@end
