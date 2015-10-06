//
//  EmailCell.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InboxItem.h"

@interface InboxCell : UITableViewCell

@property (nonatomic, copy, readonly) InboxItem *inboxItem;
@property (nonatomic, weak) IBOutlet UILabel *recipients;
@property (nonatomic, weak) IBOutlet UILabel *subject;
@property (nonatomic, weak) IBOutlet UILabel *excerpt;
@property (nonatomic, weak) IBOutlet UILabel *timeSpan;
@property (nonatomic, weak) IBOutlet UIImageView *status;
@property (nonatomic, weak) IBOutlet UIImageView *attachment;

-(void)setInboxItem:(InboxItem *)inboxItem;

@end
