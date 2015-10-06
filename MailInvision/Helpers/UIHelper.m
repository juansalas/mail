//
//  UIHelper.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/2/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "UIHelper.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIHelper

+(UIColor*)forEvent:(ColoredEvent)coloredEvent
{
    switch (coloredEvent) {
        case CEOpenedInbox:
            return [UIColor clearColor];
        case CEUnopenedInbox:
            return UIColorFromRGB(0x1ABD9D);
        case CETodayInbox:
            return UIColorFromRGB(0x3BA4FF);
        case CEAttachmentHeader:
            return UIColorFromRGB(0x6E6E6E);
        case CETimeAgoOpenedEmail:
            return UIColorFromRGB(0x999999);
        case CEThreadActionBar:
            return UIColorFromRGB(0x999999);
        case CEThreadActionButton:
            return UIColorFromRGB(0xF9F9F9);
        case CEThreadActionButtonText:
            return UIColorFromRGB(0xA9A9A9);
        case CENavigationBarTitle:
            return UIColorFromRGB(0x4F4F4F);
        case CEMenuSectionBackground:
            return UIColorFromRGB(0x3B3841);
        case CEMenuSectionTitle:
            return UIColorFromRGB(0x797483);
        case CEMenuItem:
            return UIColorFromRGB(0x9E98AA);
        case CEMenuBackground:
            return UIColorFromRGB(0x34313A);
        case CEMenuItemActive:
            return UIColorFromRGB(0xFFFFFF);
        case CEMenuItemActiveBackground:
            return UIColorFromRGB(0x3E85FD);
        case CESearchPlaceholder:
            return UIColorFromRGB(0x999999);
        case CEAttachmentOpened:
            return UIColorFromRGB(0xADADAD);
        case CEAttachmentUnopened:
            return UIColorFromRGB(0x7A7A7A);
        default:
            return [UIColor whiteColor];
    }
}

+(void)addBottomBorder:(UIView*)toView ofColor:(UIColor*)color
{
    UIView *border = [UIView new];
    border.translatesAutoresizingMaskIntoConstraints = NO;
    border.backgroundColor = color;
    
    [toView addSubview:border];
    
}


@end
