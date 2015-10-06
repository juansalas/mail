//
//  EmailThread.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InboxItem : NSObject

@property (nonatomic, copy, readonly) NSString *uniqueId;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy, readonly) NSArray  *emails;
@property (nonatomic, copy, readonly) NSArray  *participants;
@property (nonatomic, readonly) BOOL  hasAttachements;
@property (nonatomic, copy, readonly) NSDate  *activeOn;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
