//
//  selecAlbumTV.m
//  Alltech
//
//  Created by Tejuino developers on 20/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "selecAlbumTV.h"
#import "crearAlbumVC.h"
#import "Albums.h"
#import "AppDelegate.h"

@interface selecAlbumTV ()

@end

@implementation selecAlbumTV{

    NSMutableArray *nombreAlbum;
    NSMutableArray *imgAlbums;
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
    nombreAlbum = [[NSMutableArray alloc]init];
    imgAlbums = [[NSMutableArray alloc]init];
    
    //nombreAlbum = [[NSMutableArray alloc]initWithObjects:@"Pelaje bovino en Feria del ganado Guanajuato.",@"Alltech FEI World Equestrian Games™",@"Resultados en Avicultura",@"Eficencia Alimenticia Porcina",@"VIRBAC Bovinos Carne 2014",@"Congreso Mundial de Ganadería Tropical",nil];
    //ponemos fondo al View y a la barra de navegacion
    
    self.view.backgroundColor = [UIColor colorWithRed:0.969 green:0.976 blue:0.98 alpha:1]; /*#f7f9fa*/
    self.selectAlbumNav.barTintColor = [UIColor orangeColor];
    
    //agregar view para poner color de fondo al status bar
    UIView *statusBarView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 22)];
    statusBarView.backgroundColor  =  [UIColor orangeColor];
    [self.view addSubview:statusBarView];
    
    NSLog(@"estas son las imagenes que el usuario selecciono en SelecAlbumTV: %@",self.selectedImages);
    
    [self.selectAlbumTable setTableFooterView:[UIView new]];
    
    AppDelegate *appDelegateContext =
    [[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Albums" inManagedObjectContext:appDelegateContext.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *result = [appDelegateContext.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error, error .localizedDescription);
        
    } else {
        NSLog(@"%@", result);
        if (result.count > 0) {
            for (int i = 0; i < result.count; i++) {
            
                NSManagedObject *Nombre = (NSManagedObject *)[result objectAtIndex:i];
                NSLog(@"%@ %@", [Nombre valueForKey:@"nombre"], [Nombre valueForKey:@"descripcion"]);
                [nombreAlbum addObject:[Nombre valueForKey:@"nombre"]];
                
            }
        }[self.selectAlbumTable reloadData];
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 1)
        return [nombreAlbum count];
    return 1;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell;
    UIImageView *imgView;
    CGSize itemSize;
    
    
    //CELDA STATICA
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"crearNuevoAlbum" forIndexPath:indexPath];
        
        //Redimencion de imagenes respecto a tamaño del dispositivo
        
        // ipad 2, ipad mini, ipad retina
        if (screenWidth == 768 && screenHeight == 1024) {
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(20, 15, 69, 69)];
            itemSize = CGSizeMake(70, 70);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:25.0];
        }
        
        // iphone 6 plus
        if (screenWidth == 414 && screenHeight == 736) {
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(20, 15, 49, 49)];
            itemSize = CGSizeMake(40, 40);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];
        }
        
        // iphone 6
        if (screenWidth == 375 && screenHeight == 667) {
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(20, 15, 49, 49)];
            itemSize = CGSizeMake(40, 40);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];
        }
        // iphone 5, 5c, 5s, touch 5
        else if (screenWidth == 320 && screenHeight == 568){
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(20, 10, 40, 40)];
            itemSize = CGSizeMake(30, 30);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:17.0];
        }
        // iphone 4, 4s, touch 4
        else if (screenWidth == 320 && screenHeight == 480){
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(20, 10, 40, 40)];
            itemSize = CGSizeMake(30, 30);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:17.0];
        }

        imgView.image = [UIImage imageNamed:@"mas"];
        cell.textLabel.text = @"Crear nuevo álbum";
        cell.imageView.image = [UIImage imageNamed:@"mas"];

    //CELDAS DINAMICAS
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleTableItem" forIndexPath:indexPath];
    
        cell.textLabel.text = [nombreAlbum objectAtIndex:indexPath.row];
        cell.textLabel.numberOfLines = 2;
        cell.detailTextLabel.text = @"Última modificación 19/02/16";
    
        //Redimencion de imagenes respecto a tamaño del dispositivo
        
        // ipad 2, ipad mini, ipad retina
        if (screenWidth == 768 && screenHeight == 1024) {
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(20, 15, 69, 69)];
            itemSize = CGSizeMake(70, 70);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:25.0];
        }
        
        // iphone 6 plus
        if (screenWidth == 414 && screenHeight == 736) {
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(20, 15, 49, 49)];
            itemSize = CGSizeMake(40, 40);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];
        }
        
        // iphone 6
        if (screenWidth == 375 && screenHeight == 667) {
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(30, 15, 49, 49)];
            itemSize = CGSizeMake(40, 40);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];
        }
        // iphone 5, 5c, 5s, touch 5
        else if (screenWidth == 320 && screenHeight == 568){
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(20, 10, 40, 40)];
            itemSize = CGSizeMake(30, 30);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:17.0];
        }
        // iphone 4, 4s, touch 4
        else if (screenWidth == 320 && screenHeight == 480){
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(20, 10, 40, 40)];
            itemSize = CGSizeMake(30, 30);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:17.0];
        }

        
        imgView.image = [UIImage imageNamed:@"albumIcon"];
        cell.backgroundColor = [UIColor colorWithRed:0.969 green:0.976 blue:0.98 alpha:1]; /*#f7f9fa*/

        cell.imageView.image = [UIImage imageNamed:@"albumIcon"];
    }
    
    imgView.contentMode = UIViewContentModeCenter;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    //[cell addSubview:imgView];
    
    
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //fondo transparente a la celda
    
    
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return NO;
    }return YES;

}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [nombreAlbum removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     //Get the new view controller using [segue destinationViewController].
     //Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"crearAlbum"]) {
        crearAlbumVC *crearAlbum = (crearAlbumVC *) segue.destinationViewController;
        crearAlbum.selectedImages = self.selectedImages;
    }
    if ([segue.identifier isEqualToString:@"crearNuevoAlbum"]) {
        nuevoAlbum *crearNuevoAlbum = (nuevoAlbum *) segue.destinationViewController;
        crearNuevoAlbum.selectedImages = self.selectedImages;
    }
    
    
}



-(UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;
    
}

- (IBAction)returnButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
    
}
@end
