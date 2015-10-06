//
//  LoginViewController.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/5/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "LoginViewController.h"
#import "InboxTableViewController.h"
#import "SideMenuManagerViewController.h"
#import "MenuViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)login:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Inbox" bundle: nil];
    
    SideMenuManagerViewController *menuController = [SideMenuManagerViewController instance];
    
    MenuViewController *menu = [MenuViewController instance];
    
    [menuController setMenuController:menu];
    
    InboxTableViewController *controller = (InboxTableViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"InboxTableViewController"];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [menuController setCenterController:navigationController];
    
    [self presentViewController:menuController animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.email) {
        [self.password becomeFirstResponder];
    }
    else
    {
        //Validation should occur here
        [self login:self];
    }
    return YES;
}

@end
