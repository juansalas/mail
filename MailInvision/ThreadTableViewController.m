//
//  ThreadTableViewController.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/1/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "ThreadTableViewController.h"
#import "Email.h"
#import "EmailCell.h"
#import "InboxHelper.h"
#import "Attachment.h"
#import "AttachmentCell.h"
#import "UIHelper.h"

@interface ThreadTableViewController ()

@end

@implementation ThreadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customBottomBar];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 60.0f, 33.0f)];
    UIImage *backImage = [[UIImage imageNamed:@"button-back-placeholder"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10.0f, 0, 10.0f)];
    [backButton setBackgroundImage:backImage  forState:UIControlStateNormal];
    [backButton setTitleColor:[UIHelper forEvent:CENavigationBarTitle] forState:UIControlStateNormal];
    [backButton setTitle:@"Inbox" forState:UIControlStateNormal];
    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 7, 0, 0)];
    [backButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
    int spacing = 13;
    
    UIImage *downloadImage = [UIImage imageNamed:@"button-download"];
    UIButton *download = [UIButton buttonWithType:UIButtonTypeCustom];
    download.bounds = CGRectMake( 0, 0, downloadImage.size.width + spacing, downloadImage.size.height );
    [download setImage:downloadImage forState:UIControlStateNormal];
    
    UIImage *removeImage = [UIImage imageNamed:@"button-remove"];
    UIButton *remove = [UIButton buttonWithType:UIButtonTypeCustom];
    remove.bounds = CGRectMake( 0, 0, removeImage.size.width + spacing, removeImage.size.height );
    [remove setImage:removeImage forState:UIControlStateNormal];
    
    UIImage *moreImage = [UIImage imageNamed:@"button-more"];
    UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
    more.bounds = CGRectMake( 0, 0, moreImage.size.width + spacing, moreImage.size.height );
    [more setImage:moreImage forState:UIControlStateNormal];
    
    
    NSArray *actionButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:more], [[UIBarButtonItem alloc] initWithCustomView:remove], [[UIBarButtonItem alloc] initWithCustomView:download]];
    
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    _subject.text = _inboxItem.subject;
    
    self.tableView.allowsSelection = NO;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_bottomBar removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [_bottomBar setFrame:CGRectMake(0, CGRectGetHeight(self.navigationController.view.frame) - CGRectGetHeight(_bottomBar.frame), CGRectGetWidth(self.navigationController.view.frame), CGRectGetHeight(_bottomBar.frame))];
    
    
    CGRect containerRect = self.navigationController.view.frame;
    
    [_reply setFrame:CGRectMake(0, 1, CGRectGetWidth(containerRect)/2, CGRectGetHeight(_bottomBar.frame))];
    [_forward setFrame:CGRectMake(CGRectGetWidth(containerRect)/2 + 1, 1, CGRectGetWidth(containerRect)/2, CGRectGetHeight(_bottomBar.frame))];
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - View Customizations
-(void)customBottomBar
{
    
    int height = 60;
    
    _bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.navigationController.view.frame) - height, CGRectGetWidth(self.navigationController.view.frame), height)];

    _forward = [UIButton buttonWithType:UIButtonTypeCustom];
    _reply = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGRect containerRect = self.navigationController.view.frame;
    
    [_reply setFrame:CGRectMake(0, 1, CGRectGetWidth(containerRect)/2, height)];
    [_forward setFrame:CGRectMake(CGRectGetWidth(containerRect)/2 + 1, 1, CGRectGetWidth(containerRect)/2, height)];
    
    [_forward setTitle:@"Forward" forState:UIControlStateNormal];
    [_reply setTitle:@"Reply" forState:UIControlStateNormal];
    
    [_reply setTitleColor:[UIHelper forEvent:CEThreadActionButtonText] forState:UIControlStateNormal];
    [_forward setTitleColor:[UIHelper forEvent:CEThreadActionButtonText] forState:UIControlStateNormal];
    
    [_reply setBackgroundColor:[UIHelper forEvent:CEThreadActionButton]];
    [_forward setBackgroundColor:[UIHelper forEvent:CEThreadActionButton]];
    
    [_reply.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.5]];
    [_forward.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.5]];
    
    [_forward setImage:[UIImage imageNamed:@"icon-forward"] forState:UIControlStateNormal];
    [_reply setImage:[UIImage imageNamed:@"icon-reply"] forState:UIControlStateNormal];
    
    _forward.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    _forward.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    _forward.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    _forward.titleEdgeInsets = UIEdgeInsetsMake(0., 10., 0., 0.);
    _reply.titleEdgeInsets = UIEdgeInsetsMake(0., 10., 0., 0.);
    
    [_bottomBar addSubview:_forward];
    [_bottomBar addSubview:_reply];
    
    [_bottomBar setBackgroundColor:self.tableView.separatorColor];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, _bottomBar.frame.size.width, height)]];
    
    [self.navigationController.view addSubview:_bottomBar];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _inboxItem.emails.count;
    }
    else if (section == 1)
    {
        return _attachments.count;
    }
    else
    {
        return 0;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NSString *reuseIdentifier = @"email";
        
        if (indexPath.row + 1== _inboxItem.emails.count) {
            reuseIdentifier = @"emailLast";
        }
        
        EmailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        
        Email *email = [_inboxItem.emails objectAtIndex:indexPath.row];
        
        [cell setEmail:email];
        
        return cell;
    }
    else
    {
        NSString *reuseIdentifier = @"attachment";
        
        AttachmentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        
        Attachment *attachment = [_attachments objectAtIndex:indexPath.row];
        
        [cell setAttachment:attachment];
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row + 1== _inboxItem.emails.count) {
        return [EmailCell rowHeightForEmail:[_inboxItem.emails objectAtIndex:indexPath.row]];
    }
    else
    {
        return 85;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 && _attachments.count > 0) {
        return [AttachmentCell sectionHeight];
    }
    else
    {
        return 0;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return [AttachmentCell sectionViewWithTitle:[NSString stringWithFormat:(_attachments.count==1?@"%lu Attachment":@"%lu Attachments"),(unsigned long)_attachments.count] forContainer:tableView];
    }
    else
    {
        return nil;
    }
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

-(void)setInboxItem:(InboxItem *)inboxItem
{
    _inboxItem = inboxItem;
    
    [InboxHelper markAsOpened:_inboxItem];
    
    _attachments = [NSMutableArray new];
    
    //It is not clear in the prototype if the shown attachments are from the last email or a summary of all the attachments in the thread.
    //I'll do some logic to show all the attachments in the thread.
    for (Email *email in _inboxItem.emails) {
        if (email.attachments && email.attachments.count > 0) {
            [_attachments addObjectsFromArray:email.attachments];
        }
    }
}

@end
