//
//  Recipient.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "Recipient.h"

@implementation Recipient

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _emailAddress = [dictionary objectForKey:@"emailAddress"];
        _fullName = [dictionary objectForKey:@"fullName"];
        _avatarURL = [NSURL URLWithString:[dictionary objectForKey:@"avatarURL"]];
    }
    
    return self;
}

@end
