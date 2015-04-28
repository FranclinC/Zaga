//
//  CloudProvider.m
//  Zaga
//
//  Created by Rafael Gouveia on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "CloudProvider.h"

@implementation CloudProvider

-(id) init{
    self = [super init];
    if(self){
    _myContainer =[CKContainer defaultContainer];
    _publicDatabase = [_myContainer publicCloudDatabase];
    }
    return self;
}
-(BOOL)addOcorrencia:(NSNumber*)Type location:(CLLocation *)position{
    CKRecord * record = [[CKRecord alloc] initWithRecordType:@"Relato"];
    record[@"Location"] = position;
    record[@"Type"] = Type;
    
    [_publicDatabase saveRecord:record completionHandler:^(CKRecord *artworkRecord, NSError *error){
        /*if (!error) {
            // Insert successfully saved record code
        }
        else {
            // Insert error handling
        }*/
    }];

    return YES;
}


@end
