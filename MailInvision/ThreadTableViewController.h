//
//  ThreadTableViewController.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InboxItem.h"

@interface ThreadTableViewController : UITableViewController
{
    //It is not clear in the prototype if the shown attachments are from the last email or a summary of all the attachments in the thread.
    //I'll do some logic to show all the attachments in the thread.
    NSMutableArray *_attachments;
    
    UIView *_bottomBar;
}

@property (nonatomic, copy, readonly) InboxItem *inboxItem;

@property (nonatomic, weak) IBOutlet UILabel *subject;
@property (nonatomic, weak) IBOutlet UIButton *reply;
@property (nonatomic, weak) IBOutlet UIButton *forward;

-(void)setInboxItem:(InboxItem *)inboxItem;

@end
