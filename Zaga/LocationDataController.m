//
//  LocationDataController.m
//  Zaga
//
//  Created by Miguel Araújo on 4/30/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "LocationDataController.h"
#import "Location.h"

@implementation LocationDataController

-(Location *)getPointOfInterest;
{
    Location *myLocation = [[Location alloc]init];
    myLocation.latitude = -8.06260769;
    myLocation.longitude = -34.9031353;
    
    return myLocation;
}

@end