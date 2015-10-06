//
//  LoginViewController.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/5/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *email;
@property (nonatomic, weak) IBOutlet UITextField *password;

-(IBAction)login:(id)sender;

@end
