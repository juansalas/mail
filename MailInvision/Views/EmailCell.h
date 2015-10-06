//
//  EmailCell.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Email.h"

@interface EmailCell : UITableViewCell

@property (nonatomic, copy, readonly) Email *email;

@property (nonatomic, weak) IBOutlet UILabel *recipientName;
@property (nonatomic, weak) IBOutlet UILabel *toName;
@property (nonatomic, weak) IBOutlet UILabel *excerpt;
@property (nonatomic, weak) IBOutlet UILabel *timeSpan;
@property (nonatomic, weak) IBOutlet UIButton *more;
@property (nonatomic, weak) IBOutlet UIImageView *avatarURL;

-(void)setEmail:(Email *)email;

+(CGFloat)rowHeightForEmail:(Email*)email;

@end
