//
//  CloudProvider.h
//  Zaga
//
//  Created by Rafael Gouveia on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

#import "GlobalObjects.h"
#import "Report.h"

@import CloudKit;

@interface CloudProvider : NSObject

@property CKContainer * myContainer;
@property CKDatabase * publicDatabase;

-(id)init;
-(BOOL)addRelato:(Relato*)relato;
-(void)queryRelato:(CLLocation *)location handler:(void(^)(NSMutableArray* arr, NSError * error))completion;

@end
