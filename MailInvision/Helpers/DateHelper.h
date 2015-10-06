//
//  DateHelper.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateHelper : NSObject

+(NSDate*)fromUnixTimestamp:(double)timestamp;
+(NSString *)time:(NSDate *)date;
+(NSString *)timeAgo:(NSDate*)date;
+(BOOL)isToday:(NSDate *)date;

@end
