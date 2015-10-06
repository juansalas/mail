//
//  Email.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipient.h"

@interface Email : NSObject

@property (nonatomic, copy, readonly) NSDate *sentOn;

@property (nonatomic, copy, readonly) Recipient *sentBy;
@property (nonatomic, copy, readonly) NSArray  *recipients;
@property (nonatomic, copy, readonly) NSArray  *attachments;

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *body;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
