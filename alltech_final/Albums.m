//
//  Albums.m
//  Alltech
//
//  Created by Jose Esteban Garibay Castillo on 09/03/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "Albums.h"


@implementation Albums

-(id)init {
    if (self=[super init]) {
        if (self.imagenes==nil) {
            self.imagenes = [[NSMutableArray alloc] init];
        }
    }
    return self;
}
@end




