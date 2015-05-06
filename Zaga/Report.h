//
//  Relato.h
//  Zaga
//
//  Created by Rafael Gouveia on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/Corelocation.h>

@interface Relato : NSObject

@property CLLocation * position;
@property NSNumber* type;
@property NSDate * time;

@end