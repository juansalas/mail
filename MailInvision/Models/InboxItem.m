//
//  EmailThread.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "InboxItem.h"
#import "Email.h"
#import "Recipient.h"
#import "DateHelper.h"

@implementation InboxItem

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        _uniqueId = [dictionary objectForKey:@"uniqueId"];
        
        _subject = [dictionary objectForKey:@"subject"];
        
        _hasAttachements = [[dictionary objectForKey:@"hasAttachements"] boolValue];
        
        _subject = [dictionary objectForKey:@"subject"];
        
        NSMutableArray *tmpEmails = [NSMutableArray new];
        
        for (NSDictionary *emailDict in [dictionary objectForKey:@"emails"]) {
            
            Email *email = [[Email alloc] initWithDictionary:emailDict];
            
            [tmpEmails addObject:email];
            
        }
        
        _emails = [NSArray arrayWithArray:tmpEmails];
        
        NSMutableArray *tmpParticipants = [NSMutableArray new];
        
        for (NSDictionary *emailDict in [dictionary objectForKey:@"participants"]) {
            
            Recipient *recipient = [[Recipient alloc] initWithDictionary:emailDict];
            
            [tmpParticipants addObject:recipient];
            
        }
        
        _participants = [NSArray arrayWithArray:tmpParticipants];
        
        _activeOn = [DateHelper fromUnixTimestamp:[[dictionary objectForKey:@"activeOn"] doubleValue]];
    }
    
    return self;
}

@end
