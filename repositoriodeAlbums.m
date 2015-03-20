//
//  repositoriodeAlbums.m
//  Alltech
//
//  Created by Jose Esteban Garibay Castillo on 17/03/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "repositoriodeAlbums.h"
#import "Albums.h"

@implementation repositoriodeAlbums

static repositoriodeAlbums * instancia;


-(id)init {
    if (self=[super init]) {
        [self leer];
        if (self.albums==nil) {
            self.albums = [[NSMutableArray alloc] init];
        }
    }
    return self;
}


-(void)leer{
    NSArray *albumsLeidos = [[NSArray alloc]initWithContentsOfFile:[self ruta]];
    if (albumsLeidos!=nil) {
        self.albums = [[NSMutableArray alloc] init];
        
        for (NSDictionary * diccionario in albumsLeidos) {
            Albums * album = [[Albums alloc] init];
            album.nombre = [diccionario objectForKey:@"nombre"];
            album.descripcion = [diccionario objectForKey:@"descripcion"];
            album.programa = [diccionario objectForKey:@"programa"];
            album.producto = [diccionario objectForKey:@"producto"];
            album.especie = [diccionario objectForKey:@"especie"];
            album.imagenes = [diccionario objectForKey:@"imagenes"];
            album.fechaModificacion = [diccionario objectForKey:@"fecha"];
            
            [self.albums addObject:album];
        }
        
    }


}

-(void)guardar{
    
    NSMutableArray * albumsAGuardar = [[NSMutableArray alloc] init];
    for (Albums * album in self.albums) {
        NSDictionary * diccionario = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      album.nombre, @"nombre",
                                      album.descripcion, @"descripcion",
                                      album.programa, @"programa",
                                      album.producto, @"producto",
                                      album.especie, @"especie",
                                      album.imagenes, @"imagenes",
                                      album.fechaModificacion, @"fecha",
                                      nil];
        
        [albumsAGuardar addObject:diccionario];
    }
    [albumsAGuardar writeToFile:[self ruta] atomically:YES];

}

-(NSString *)ruta{
    NSString * pathFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [pathFolder stringByAppendingPathComponent:@"albums.plist"];

}
+(repositoriodeAlbums *)sharedInstance {
    if (instancia==nil) {
        instancia = [[repositoriodeAlbums alloc] init];
    }
    return instancia;
}

@end
