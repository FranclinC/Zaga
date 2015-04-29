//
//  GlobalObjects.h
//  Zaga
//
//  Created by Miguel Araújo on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Relato.h"

@interface GlobalObjects : NSObject


+(void)loadRelato:(NSArray *) relatos;
+(Relato*)RelatosArray;

@end
