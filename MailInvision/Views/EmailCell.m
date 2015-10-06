//
//  EmailCell.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "EmailCell.h"
#import "DateHelper.h"
#import "UIImageView+Internet.h"

#define ROW_DEFAULT_HEIGHT 140

@implementation EmailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEmail:(Email *)email
{
    _email = email;
    
    _excerpt.text = _email.body;
    _recipientName.text = _email.sentBy.fullName;
    
    if (![DateHelper isToday:_email.sentOn]) {
        _timeSpan.text = [DateHelper time:_email.sentOn];
    }
    else
    {
        _timeSpan.text = [DateHelper timeAgo:_email.sentOn];
    }
    
    
    [_avatarURL setImageURL:_email.sentBy.avatarURL];
    _avatarURL.layer.cornerRadius = _avatarURL.frame.size.width / 2;
    
    Recipient *to = [_email.recipients objectAtIndex:0];
    _toName.text = [NSString stringWithFormat:@"to %@", to.fullName];
    
    NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
    style.minimumLineHeight = 20.f;
    style.maximumLineHeight = 20.f;
    NSDictionary *attributtes = @{NSParagraphStyleAttributeName : style,};
    _excerpt.attributedText = [[NSAttributedString alloc] initWithString:_excerpt.text
                                                              attributes:attributtes];
    
}

+(CGFloat)rowHeightForEmail:(Email*)email
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    NSDictionary *attributes = @{NSFontAttributeName: font};
    
    CGRect rect = [email.body boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    
    return rect.size.height + ROW_DEFAULT_HEIGHT;
    
}

-(CGFloat)height
{
    return _more.frame.origin.y + _more.frame.size.height + 30;
}

@end
