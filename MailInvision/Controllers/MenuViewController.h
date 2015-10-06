//
//  MenuViewController.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/5/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UITableViewController
{
    NSMutableArray *sections;
}

-(void)makeMenuItemActive:(NSString*)itemTitle;

+ (MenuViewController*)instance;

@end
