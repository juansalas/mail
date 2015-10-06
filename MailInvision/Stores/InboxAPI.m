//
//  InboxAPI.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "InboxAPI.h"
#import <AFNetworking.h>
#import <AFHTTPRequestOperation.h>
#import "InboxItem.h"

@implementation InboxAPI

static NSString * const kGetInbox = @"http://dev.laterous.com/invision/index.php";

+(void)requestInbox:(NSString*)authToken completionBlock:(void (^)(NSMutableArray * inboxItems, NSError * error)) handler{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kGetInbox parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError * error = nil;
        NSMutableArray * inboxItems = [NSMutableArray new];
        
        NSDictionary *dict = (NSDictionary*)responseObject;
        
        if ([dict objectForKey:@"code"]) {
            
            int code = [[dict objectForKey:@"code"] intValue];
            
            if (code == 200) {
                
                for (NSDictionary *inboxItemDict in [dict objectForKey:@"response"]) {
                    
                    @try {
                        InboxItem *inboxItem = [[InboxItem alloc] initWithDictionary:inboxItemDict];
                        [inboxItems addObject:inboxItem];
                    }
                    @catch (NSException *exception) {
                        NSLog(@"Looks like there's a problem parsing the JSON for this Inbox item. Let's keep trying with the rest.");
                    }
                    @finally {
                        
                    }
                    
                    
                }
                
            }
            
        }
        
        handler(inboxItems, error);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(NULL, error);
    }];

}

@end
