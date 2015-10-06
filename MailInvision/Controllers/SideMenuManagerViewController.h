//
//  MenuViewController.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/3/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuManagerViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, retain) id centerController;
@property (nonatomic, retain) id menuController;

-(IBAction)toggleMenu:(id)sender;
-(void)showCenter;

+ (SideMenuManagerViewController*)instance;

@end
