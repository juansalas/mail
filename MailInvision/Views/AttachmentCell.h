//
//  AttachmentCell.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/2/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Attachment.h"

@interface AttachmentCell : UITableViewCell

@property (nonatomic, copy, readonly) Attachment *attachment;

@property (nonatomic, weak) IBOutlet UILabel *fileName;
@property (nonatomic, weak) IBOutlet UIImageView *placeholder;

-(void)setAttachment:(Attachment *)attachment;

+(CGFloat)sectionHeight;
+(UIView*)sectionViewWithTitle:(NSString*)title forContainer:(UIView*)container;

@end
