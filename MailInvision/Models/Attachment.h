//
//  Attachment.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    AttachmentImage,
    AttachmentVideo,
    AttachmentOther
} AttachmentType;

@interface Attachment : NSObject

@property (nonatomic, copy, readonly) NSURL *fileURL;
@property (nonatomic, readonly) AttachmentType  type;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
