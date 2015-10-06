//
//  InboxHelper.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/2/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "InboxHelper.h"

@implementation InboxHelper

static NSString * const kFormatUniqueId = @"opened_inboxItem_%@";

+(BOOL)hasBeenOpened:(InboxItem*)inboxItem
{
    //Just for debugging purposes
    //return NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return ([defaults boolForKey:[InboxHelper keyForUniqueId:inboxItem.uniqueId]]);
    
}

+(void)markAsOpened:(InboxItem*)inboxItem
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:YES forKey:[InboxHelper keyForUniqueId:inboxItem.uniqueId]];
    
    [defaults synchronize];
}

+(NSString*)keyForUniqueId:(NSString*)uniqueId
{
    return [NSString stringWithFormat:kFormatUniqueId,uniqueId];
}

@end
