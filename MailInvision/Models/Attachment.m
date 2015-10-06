//
//  Attachment.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "Attachment.h"

@implementation Attachment

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        NSString *type = [dictionary objectForKey:@"type"];
        
        if ([type isEqualToString:@"image"]) {
            _type = AttachmentImage;
        }
        else if ([type isEqualToString:@"video"]) {
            _type = AttachmentVideo;
        }
        else
        {
            _type = AttachmentOther;
        }
        
        _fileURL = [NSURL URLWithString:[dictionary objectForKey:@"url"]];
    }
    
    return self;
}

@end
