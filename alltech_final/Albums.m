//
//  Albums.m
//  Alltech
//
//  Created by Jose Esteban Garibay Castillo on 09/03/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "Albums.h"


@implementation Albums

@dynamic id;
@dynamic nombre;
@dynamic descripcion;
@dynamic programa;
@dynamic producto;
@dynamic especie;
@dynamic imagen;

+(id)albumWhitContext:(NSManagedObjectContext *)context {
    Albums *album = [NSEntityDescription
                     insertNewObjectForEntityForName:@"nombre"
                     inManagedObjectContext:context];
    return album;
}

@end




