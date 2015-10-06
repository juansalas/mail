//
//  UIHelper.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/2/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CEUnopenedInbox,
    CEOpenedInbox,
    CETodayInbox,
    CEAttachmentHeader,
    CETimeAgoOpenedEmail,
    CEThreadActionButton,
    CEThreadActionBar,
    CEThreadActionButtonText,
    CENavigationBarTitle,
    CEMenuSectionBackground,
    CEMenuSectionTitle,
    CEMenuItem,
    CEMenuItemActiveBackground,
    CEMenuItemActive,
    CEMenuBackground,
    CESearchPlaceholder,
    CEAttachmentOpened,
    CEAttachmentUnopened,
    CEOther
} ColoredEvent;

@interface UIHelper : NSObject

+(UIColor*)forEvent:(ColoredEvent)coloredEvent;

@end
