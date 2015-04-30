//
//  LocationDataController.h
//  Zaga
//
//  Created by Miguel Araújo on 4/30/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Location.h"

@interface LocationDataController : NSObject <MKAnnotation>

- (Location *)getPointOfInterest;

@end