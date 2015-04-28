//
//  CloudProvider.h
//  Zaga
//
//  Created by Rafael Gouveia on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@import CloudKit;

@interface CloudProvider : NSObject
@property CKContainer * myContainer;
@property CKDatabase * publicDatabase;
-(id)init;
-(BOOL)addOcorrencia:(NSNumber*)tipo location:(CLLocation *)position;

@end
