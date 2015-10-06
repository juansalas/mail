//
//  DateHelper.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper

+(NSDate*)fromUnixTimestamp:(double)timestamp
{
    NSTimeInterval interval = (NSTimeInterval)timestamp;
    NSDate *dated = [NSDate dateWithTimeIntervalSince1970:interval];
    return dated;
}

+(NSString *)time:(NSDate *)date
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"H:mm"];
    return [formatter stringFromDate:date];
    
}

+(NSString *)timeAgo:(NSDate*)date
{
    NSDate *now = [NSDate date];
    double deltaSeconds = fabs([date timeIntervalSinceDate:now]);
    double deltaMinutes = deltaSeconds / 60.0f;
    
    int minutes;
    
    if(deltaSeconds < 5)
    {
        return @"Just now";
    }
    else if(deltaSeconds < 60)
    {
        return [NSString stringWithFormat:@"%.0f seconds ago", deltaSeconds];
    }
    else if(deltaSeconds < 120)
    {
        return @"A minute ago";
    }
    else if (deltaMinutes < 60)
    {
        return [NSString stringWithFormat:@"%.0f minutes ago", deltaMinutes];
    }
    else if (deltaMinutes < 120)
    {
        return @"An hour ago";
    }
    else if (deltaMinutes < (24 * 60))
    {
        minutes = (int)floor(deltaMinutes/60);
        return [NSString stringWithFormat:@"%d hours ago", minutes];
    }
    else if (deltaMinutes < (24 * 60 * 2))
    {
        return @"Yesterday";
    }
    else if (deltaMinutes < (24 * 60 * 7))
    {
        minutes = (int)floor(deltaMinutes/(60 * 24));
        return [NSString stringWithFormat:@"%d days ago", minutes];
    }
    else if (deltaMinutes < (24 * 60 * 14))
    {
        return @"Last week";
    }
    else if (deltaMinutes < (24 * 60 * 31))
    {
        minutes = (int)floor(deltaMinutes/(60 * 24 * 7));
        return [NSString stringWithFormat:@"%d weeks ago",minutes];
    }
    else if (deltaMinutes < (24 * 60 * 61))
    {
        return @"Last month";
    }
    else if (deltaMinutes < (24 * 60 * 365.25))
    {
        minutes = (int)floor(deltaMinutes/(60 * 24 * 30));
        return [NSString stringWithFormat:@"%d months ago", minutes];
    }
    else if (deltaMinutes < (24 * 60 * 731))
    {
        return @"Last year";
    }
    
    minutes = (int)floor(deltaMinutes/(60 * 24 * 365));
    return [NSString stringWithFormat:@"%d years ago", minutes];
    
}

+(BOOL)isToday:(NSDate *)date
{
    NSCalendarUnit units = NSCalendarUnitDay | NSCalendarUnitWeekOfYear |
    NSCalendarUnitMonth | NSCalendarUnitYear;
    
    // if `date` is before "now" (i.e. in the past) then the components will be positive
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units
                                                                   fromDate:date
                                                                     toDate:[NSDate date]
                                                                    options:0];
    
    if (components.year == 0 && components.month == 0 && components.weekOfYear == 0 && components.day == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

@end
