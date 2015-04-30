//
//  Report.m
//  Zaga
//
//  Created by Rafael Gouveia on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "Report.h"

@implementation Relato

-(id)initWithlocation:(CLLocation*)posicao type:(NSNumber*)tipo{
    self = [super init];
    
    if(self){
        _position = posicao;
        _type = tipo;
        _time = [NSDate date];
    }
    
    return self;
}

@end