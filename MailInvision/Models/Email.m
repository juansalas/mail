//
//  Email.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "Email.h"
#import "Recipient.h"
#import "Attachment.h"
#import "DateHelper.h"

@implementation Email

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _title = [dictionary objectForKey:@"title"];
        _body = [dictionary objectForKey:@"body"];
        
        NSMutableArray *tmpRecipients = [NSMutableArray new];
        
        for (NSDictionary *recipientDict in [dictionary objectForKey:@"recipients"]) {
            
            Recipient *recipient = [[Recipient alloc] initWithDictionary:recipientDict];
            
            [tmpRecipients addObject:recipient];
            
        }
        
        _recipients = [NSArray arrayWithArray:tmpRecipients];
        
        NSMutableArray *tmpAttachments = [NSMutableArray new];
        
        for (NSDictionary *recipientDict in [dictionary objectForKey:@"attachments"]) {
            
            Attachment *attachment = [[Attachment alloc] initWithDictionary:recipientDict];
            
            [tmpAttachments addObject:attachment];
            
        }
        
        _attachments = [NSArray arrayWithArray:tmpAttachments];
        
        _sentBy = [[Recipient alloc] initWithDictionary:[dictionary objectForKey:@"sentBy"]];
        
        _sentOn = [DateHelper fromUnixTimestamp:[[dictionary objectForKey:@"sentOn"] doubleValue]];
        
    }
    
    return self;
}

@end
