//
//  Albums.h
//  Alltech
//
//  Created by Jose Esteban Garibay Castillo on 09/03/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Albums : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * descripcion;
@property (nonatomic, retain) NSString * programa;
@property (nonatomic, retain) NSString * producto;
@property (nonatomic, retain) NSString * especie;
@property (nonatomic, retain) NSString * imagen;


+(id)albumWhitContext:(NSManagedObjectContext *)context;

@end
