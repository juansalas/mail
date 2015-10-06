//
//  InboxTableViewController.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InboxTableViewController : UITableViewController
{
    NSArray *_inboxItems;
}

@property (nonatomic, weak) IBOutlet UITextField *search;

@end
