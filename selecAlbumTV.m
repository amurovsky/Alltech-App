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
#import "repositoriodeAlbums.h"
#import "AppDelegate.h"

@interface selecAlbumTV ()

@end

@implementation selecAlbumTV{

    NSMutableArray *nombreAlbum;
    NSMutableArray *imgAlbums;
    NSMutableArray *descripcionAlbum;
    CGRect screenBound;
    CGSize screenSize;
    CGFloat screenWidth;
    CGFloat screenHeight;
    NSString *crearAlbum;
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
    descripcionAlbum = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.969 green:0.976 blue:0.98 alpha:1]; /*#f7f9fa*/
    self.selectAlbumNav.barTintColor = [UIColor orangeColor];
    
    //agregar view para poner color de fondo al status bar
    UIView *statusBarView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 22)];
    statusBarView.backgroundColor  =  [UIColor orangeColor];
    [self.view addSubview:statusBarView];
    
    
    [self.selectAlbumTable setTableFooterView:[UIView new]];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *idioma = appDelegate.userSession.lenguaje;
    if ([idioma isEqual:@"es"]) {
        crearAlbum = @"Crear nuevo álbum";
        self.misAlbumsNavItem.title = @"Mis Álbums";
        
    }else if ([idioma isEqual:@"en"]) {
        crearAlbum = @"Create new album";
        self.misAlbumsNavItem.title = @"My Albums";
    }else if ([idioma isEqual:@"pt"]) {
        crearAlbum = @"Criar novo álbum";
        self.misAlbumsNavItem.title = @"Álbuns";
    }
    
}
-(void)viewDidAppear:(BOOL)animated{

    [self.selectAlbumTable reloadData];

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
    if (section == 1){
        NSMutableArray *albums =[repositoriodeAlbums sharedInstance].albums;
        return [albums count];
    
    }

    return 1;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell;
    
    //CELDA STATICA
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"crearNuevoAlbum" forIndexPath:indexPath];

        cell.textLabel.text = crearAlbum;
        cell.imageView.image = [UIImage imageNamed:@"mas"];

    //CELDAS DINAMICAS
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleTableItem" forIndexPath:indexPath];
    
        NSMutableArray *albums =[repositoriodeAlbums sharedInstance].albums;
        Albums *album = [albums objectAtIndex:indexPath.row];
        cell.textLabel.text = album.nombre;
        cell.textLabel.numberOfLines = 2;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Ultima modificacion: %@",album.fechaModificacion];
        cell.imageView.image = [UIImage imageNamed:@"albumIcon"];
        cell.backgroundColor = (album.sended) ? [UIColor grayColor] : [UIColor colorWithRed:0.969 green:0.976 blue:0.98 alpha:1]; /*#f7f9fa*/

        
    }
    
    //Cambiar Tamaño de letra segun dispositivo
    
    // ipad 2, ipad mini, ipad retina
    if (screenWidth == 768) {
        cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:25.0];
    }
    
    // iphone 6 plus
    if (screenWidth == 414) {
        cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];
    }
    
    // iphone 6
    if (screenWidth == 375) {
        cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];
    }
    // iphone 5, 5c, 5s, touch 5 & iphone 4, 4s, touch 4
    else if (screenWidth == 320){
        cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:17.0];
    }

    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return NO;
    }return YES;

}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {

        NSMutableArray *albums = [repositoriodeAlbums sharedInstance].albums;
        [albums removeObjectAtIndex:indexPath.row];
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
    NSIndexPath *indexPath = [self.selectAlbumTable indexPathForSelectedRow];
    
    if ([segue.identifier isEqualToString:@"crearAlbum"]) {
        crearAlbumVC *crear= (crearAlbumVC *) segue.destinationViewController;
        
        NSMutableArray *albums =[repositoriodeAlbums sharedInstance].albums;
        Albums *album = [albums objectAtIndex:indexPath.row];
        crear.albums = album;

    }

    
}



-(UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;
    
}

- (IBAction)returnButton:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
