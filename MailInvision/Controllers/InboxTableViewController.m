//
//  InboxTableViewController.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "InboxTableViewController.h"
#import "InboxItem.h"
#import "InboxCell.h"
#import "InboxAPI.h"
#import "ThreadTableViewController.h"
#import "SideMenuManagerViewController.h"
#import "MenuViewController.h"
#import "UIHelper.h"

@interface InboxTableViewController ()

@end

@implementation InboxTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __block InboxTableViewController *tableViewController = self;
    
    [InboxAPI requestInbox:@"-for-future-use-" completionBlock:^(NSMutableArray *inboxItems, NSError *error) {
        
        if (error == nil) {
            _inboxItems = inboxItems;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableViewController.tableView reloadData];
            });
        }
        else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ouch!"
                                                                                     message:[error localizedDescription]
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }];
    
    UIButton *menuButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 52.0f, 33.0f)];
    UIImage *menuImage = [UIImage imageNamed:@"button-menu"];
    [menuButton setBackgroundImage:menuImage  forState:UIControlStateNormal];
    [menuButton addTarget:[SideMenuManagerViewController instance] action:@selector(toggleMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIButton *composeButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 49.0f, 33.0f)];
    UIImage *composeImage = [UIImage imageNamed:@"button-compose"];
    [composeButton setBackgroundImage:composeImage  forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:composeButton];
    
    [self.search setValue:[UIHelper forEvent:CESearchPlaceholder] forKeyPath:@"_placeholderLabel.textColor"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_inboxItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InboxCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inboxItem" forIndexPath:indexPath];
    
    InboxItem *item = [_inboxItems objectAtIndex:indexPath.row];
    
    [cell setInboxItem:item];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.borderColor = [self.tableView.separatorColor CGColor];
    bottomBorder.borderWidth = 1.0f;
    
    bottomBorder.frame = CGRectMake(0, self.tableView.tableHeaderView.frame.size.height - 1.0f, self.tableView.tableHeaderView
                                    .frame.size.width, 1.0f);
    
    [self.tableView.tableHeaderView.layer addSublayer:bottomBorder];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
    [[MenuViewController instance] makeMenuItemActive:@"Inbox"];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //Make sure we show the center container all the time
    [[SideMenuManagerViewController instance] showCenter];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"threadDetail"])
    {
        
        ThreadTableViewController *vc = [segue destinationViewController];
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        InboxItem *inboxItem = [_inboxItems objectAtIndex:path.row];
        
        [vc setInboxItem:inboxItem];
        
    }
}

@end
