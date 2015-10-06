//
//  MenuViewController.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/5/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuItem.h"
#import "UIHelper.h"

@interface MenuViewController ()

@end

static MenuViewController *sharedInstance = nil;

@implementation MenuViewController

+ (MenuViewController*)instance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [MenuViewController new];
        }
    }
    return sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setFrame:[UIScreen mainScreen].bounds];
    
    UIView *tableHeaderView = [UIView new];
    tableHeaderView.frame = [UIApplication sharedApplication].statusBarFrame;
    
    [tableHeaderView setBackgroundColor:[UIHelper forEvent:CEMenuBackground]];
    [self.tableView setTableHeaderView:tableHeaderView];
    
    [self.view setBackgroundColor:[UIHelper forEvent:CEMenuBackground]];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setRowHeight:38.0];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self prepareMenu];
   
}

-(void)prepareMenu
{
    NSDictionary *dicMenu = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"]];
    
    sections = [NSMutableArray new];
    
    NSArray *keys;
    NSString* key;
    
    keys = [[dicMenu allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    for (int i = 0; i < keys.count; i++)
    {
        MenuItem *section = [MenuItem new];
        
        key = [keys objectAtIndex: i];
        
        section.title = [key stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:@""];
        section.children = [NSMutableArray new];
        
        NSArray *keysInternal = [dicMenu objectForKey: key];
        
        for (int j = 0; j < keysInternal.count; j++)
        {
            NSDictionary* keyInternal = [keysInternal objectAtIndex: j];
            
            MenuItem *item = [MenuItem new];
            
            item.title = [keyInternal objectForKey:@"title"];
            item.icon = [UIImage imageNamed:[keyInternal objectForKey:@"image"]];
            
            [section.children addObject:item];
            
        }
        
        [sections addObject:section];
        
        
    }
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerSection:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self headerSectionHeight:section];
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [self sectionFooterForMenuItem:[sections objectAtIndex:section]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self nextSectionIsSeparator:section]) {
        return 0;
    }
    else
    {
        return [self sectionFooterHeightForMenuItem:[sections objectAtIndex:section]];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[(MenuItem*)[sections objectAtIndex:section] children] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    }
    
    MenuItem *menuItem = [[[sections objectAtIndex:indexPath.section] children] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = menuItem.title;
    cell.imageView.image = menuItem.icon;
    
    [self beautify:cell forMenuItem:menuItem];
    
    return cell;
}

#pragma mark - Custom UI Construction

-(BOOL)nextSectionIsSeparator:(NSInteger)section
{
    if (section + 1 < sections.count) {
        if ([[[sections objectAtIndex:section + 1] title] isEqualToString:@""]) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

-(CGFloat)sectionFooterHeightForMenuItem:(MenuItem*)item
{
    return 15.0;
}

-(CGFloat)headerSectionHeight:(NSInteger)section
{
    MenuItem *item = [sections objectAtIndex:section];
    
    if ([item.title isEqualToString:@""]) {
        return 1;
    }
    else
    {
        if (section == 0) {
            return 45.0;
        }
        else
        {
            return 35.0;
        }
    }
}

-(UIView*)sectionFooterForMenuItem:(MenuItem*)item
{
    UIView *view = [UIView new];
    
    [view setBackgroundColor:[UIHelper forEvent:CEMenuBackground]];
    [view setFrame:CGRectMake(0, 0, self.view.frame.size.width, [self sectionFooterHeightForMenuItem:item])];
    
    return view;
}

-(UIView*)headerSection:(NSInteger)section
{
    MenuItem *item = [sections objectAtIndex:section];
    
    UIView *view = [UIView new];
    
    if (section == 0) {
        [view setBackgroundColor:[UIHelper forEvent:CEMenuBackground]];
    }
    else
    {
        [view setBackgroundColor:[UIHelper forEvent:CEMenuSectionBackground]];
    }
    
    [view setFrame:CGRectMake(0, 0, self.view.frame.size.width, [self headerSectionHeight:section])];
    
    if ([item.title isEqualToString:@""]) {
        return view;
    }
    else
    {
        UILabel *title = [UILabel new];
        int padding = 10;
        
        [title setFrame:CGRectMake(padding, 0, view.frame.size.width - padding, [self headerSectionHeight:section])];
        
        [title setText:[[item title] uppercaseString]];
        
        [title setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0]];
        
        [title setTextColor:[UIHelper forEvent:CEMenuSectionTitle]];
        
        [view addSubview:title];
        
        return view;
    }
}

-(void)beautify:(UITableViewCell*)cell forMenuItem:(MenuItem*)item
{
    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0]];
    
    if (item.isActive) {
        [cell.textLabel setTextColor:[UIHelper forEvent:CEMenuItemActive]];
        [cell setBackgroundColor:[UIHelper forEvent:CEMenuItemActiveBackground]];
    }
    else
    {
        [cell.textLabel setTextColor:[UIHelper forEvent:CEMenuItem]];
        [cell setBackgroundColor:[UIHelper forEvent:CEMenuBackground]];
    }
    
}

/* 
 De-activates any other menu item that is active and activates the one requested
 */
-(void)makeMenuItemActive:(NSString*)itemTitle
{
    for (int i = 0; i < sections.count; i++) {
        
        MenuItem *item = [sections objectAtIndex:i];
        
        for (MenuItem *itemChild in item.children) {
            itemChild.isActive = NO;
            if ([itemChild.title isEqualToString:itemTitle]) {
                itemChild.isActive = YES;
            }
        }
    }
    
    [self.tableView reloadData];
}

@end
