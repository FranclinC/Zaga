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
-(BOOL)addRelato:(Relato*)relato{
    CKRecord * record = [[CKRecord alloc] initWithRecordType:@"Relato"];
    record[@"Location"] = relato.position;
    record[@"Type"] = relato.type;
    record[@"Time"] = relato.time;
    
    [_publicDatabase saveRecord:record completionHandler:^(CKRecord *artworkRecord, NSError *error){
        if (!error) {
            // Insert successfully saved record code
        }
        else {
            // Insert error handling
        }
    }];

    return YES;
}

-(void)queryRelato:(CLLocation *)location handler:(void(^)(NSMutableArray* arr, NSError * error))completion{
    CGFloat raio = 1000.0;
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"distanceToLocation:fromLocation:(location, %@) < %f", location,raio];
    CKQuery* query = [[CKQuery alloc] initWithRecordType:@"Relato" predicate:predicate];
    
    [_publicDatabase performQuery:query inZoneWithID:nil completionHandler:^(NSArray *results, NSError *error) {
            if(error) {
                NSLog(@"Error: %@", error.localizedDescription);
            }
            NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:results.count];
            if(results) {
                for(CKRecord *record in results) {
                    Relato *channel = [[Relato alloc] init];
                    channel.position = record[@"Location"];
                    channel.time = record[@"Time"];
                    channel.type = record[@"Type"];
                    [arr addObject:channel];
                }
            }
            completion(arr,error);
        }
     ];

}


@end
