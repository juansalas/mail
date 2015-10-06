//
//  Recipient.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipient : NSObject

@property (nonatomic, copy, readonly) NSString *fullName;
@property (nonatomic, copy, readonly) NSString *emailAddress;
@property (nonatomic, copy, readonly) NSURL *avatarURL;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
