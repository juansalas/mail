//
//  InboxAPI.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InboxAPI : NSObject

+(void)requestInbox:(NSString*)authToken completionBlock:(void (^)(NSMutableArray * inboxItems, NSError * error)) handler;

@end
