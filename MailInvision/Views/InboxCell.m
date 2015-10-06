//
//  EmailCell.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "InboxCell.h"
#import "Recipient.h"
#import "Email.h"
#import "DateHelper.h"
#import "InboxHelper.h"
#import "UIHelper.h"

@implementation InboxCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInboxItem:(InboxItem *)inboxItem
{
    _inboxItem = inboxItem;
    
    _subject.text = _inboxItem.subject;
    
    _recipients.text = @"";
    
    NSMutableString *recipientsExcerpt = [NSMutableString new];
    
    int index = 0;
    for (Recipient *recipient in _inboxItem.participants) {
        if (![recipientsExcerpt isEqualToString:@""]) {
            [recipientsExcerpt appendString:@", "];
        }
        
        [recipientsExcerpt appendString:recipient.fullName];
        
        index++;
        
        if (index == _inboxItem.participants.count) {
            
            _recipients.text = recipientsExcerpt;
            
            if (![InboxHelper hasBeenOpened:_inboxItem]) {
                // Create the attributes
                const CGFloat fontSize = 15;
                NSDictionary *attrs = @{
                                        NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize],
                                        NSForegroundColorAttributeName:[UIColor blackColor]
                                        };
                NSDictionary *subAttrs = @{
                                           NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:fontSize]
                                           };
                
                const NSRange range = NSMakeRange(recipientsExcerpt.length - recipient.fullName.length,recipient.fullName.length);
                
                // Create the attributed string (text + attributes)
                NSMutableAttributedString *attributedText =
                [[NSMutableAttributedString alloc] initWithString:_recipients.text
                                                       attributes:subAttrs];
                [attributedText setAttributes:attrs range:range];
                
                // Set it in our UILabel and we are done!
                [_recipients setAttributedText:attributedText];
            }
            
        }
        
    }
    
    
    
    Email *lastEmail = [_inboxItem.emails objectAtIndex:0];
    
    _excerpt.text = lastEmail.body;
    
    if ([DateHelper isToday:inboxItem.activeOn]) {
        _timeSpan.text = [DateHelper time:_inboxItem.activeOn];
    }
    else
    {
        _timeSpan.text = [DateHelper timeAgo:_inboxItem.activeOn];
    }
    
    
    if ([DateHelper isToday:_inboxItem.activeOn]) {
        _timeSpan.textColor = [UIHelper forEvent:CETodayInbox];
    }
    
    if (_inboxItem.hasAttachements) {
        _attachment.hidden = NO;
    }
    else
    {
        _attachment.hidden = YES;
    }
    
    if (![InboxHelper hasBeenOpened:_inboxItem]) {
        _status.clipsToBounds = YES;
        _status.layer.cornerRadius = _status.frame.size.width/2;
        _status.backgroundColor = [UIHelper forEvent:CEUnopenedInbox];
        _attachment.image = [_attachment.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _attachment.tintColor = [UIHelper forEvent:CEAttachmentUnopened];
    }
    else
    {
        _subject.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        _timeSpan.textColor = [UIHelper forEvent:CETimeAgoOpenedEmail];
        _status.backgroundColor = [UIColor clearColor];
        _attachment.image = [_attachment.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _attachment.tintColor = [UIHelper forEvent:CEAttachmentOpened];
    }
    
    
}

@end
