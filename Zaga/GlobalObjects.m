//
//  GlobalObjects.m
//  Zaga
//
//  Created by Miguel Araújo on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "GlobalObjects.h"

static NSArray * _RelatoArray;

@implementation GlobalObjects

+(void)loadRelato:(NSArray *)relatos
{
    _RelatoArray = relatos;
}

+(NSArray*)RelatosArray
{
    return _RelatoArray;
}

@end