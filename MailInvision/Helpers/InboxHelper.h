//
//  InboxHelper.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/2/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InboxItem.h"

@interface InboxHelper : NSObject

+(BOOL)hasBeenOpened:(InboxItem*)inboxItem;
+(void)markAsOpened:(InboxItem*)inboxItem;

@end
