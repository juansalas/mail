//
//  AttachmentCell.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/2/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "AttachmentCell.h"
#import "UIImageView+Internet.h"
#import "UIHelper.h"

@implementation AttachmentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setAttachment:(Attachment *)attachment
{
    _attachment = attachment;
    
    NSArray *urlComponents = [[attachment.fileURL absoluteString] componentsSeparatedByString:@"/"];
    NSString *filename = [urlComponents lastObject];
    
    _fileName.text = filename;
    
    [_placeholder setImage:[UIImage imageNamed:@"image-placeholder"]];
    
    //I can either do
    //[_placeholder setImageURL:attachment.fileURL];
    
    _placeholder.layer.cornerRadius = 2.0;
}


+(CGFloat)sectionHeight
{
    return 40.0;
}

+(UIView*)sectionViewWithTitle:(NSString*)title forContainer:(UIView*)container
{
    int _padding = 10;
    
    UIView *section = [UIView new];
    
    int _width = MAX(container.frame.size.width, container.frame.size.height);
    
    [section setBackgroundColor:[UIColor whiteColor]];
    [section setFrame:CGRectMake(0, 0, _width, [AttachmentCell sectionHeight])];
    
    UILabel *labelTitle = [UILabel new];
    
    [labelTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0]];
    [labelTitle setTextColor:[UIHelper forEvent:CEAttachmentHeader]];
    [labelTitle setFrame:CGRectMake(_padding, _padding, section.frame.size.width, [AttachmentCell sectionHeight] / 2)];
    [labelTitle setText:title];
    
    [section addSubview:labelTitle];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.backgroundColor = [[UIColor lightGrayColor] CGColor];
    bottomBorder.frame = CGRectMake(0, CGRectGetHeight(section.frame) - 1, CGRectGetWidth(section.frame), 0.5f);
    [section.layer addSublayer:bottomBorder];
    
    CALayer *upperBorder = [CALayer layer];
    upperBorder.backgroundColor = [[UIColor lightGrayColor] CGColor];
    upperBorder.frame = CGRectMake(0, 0, CGRectGetWidth(section.frame), 0.5f);
    [section.layer addSublayer:upperBorder];
    
    return section;
}

@end
