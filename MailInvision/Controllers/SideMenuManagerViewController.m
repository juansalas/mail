//
//  MenuViewController.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/3/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "SideMenuManagerViewController.h"

typedef enum {
    MenuPanDirectionNone,
    MenuPanDirectionLeft,
    MenuPanDirectionRight
} MenuPanDirection;

@interface SideMenuManagerViewController ()

@property (nonatomic, assign) CGPoint panGestureOrigin;
@property (nonatomic, assign) CGFloat panGestureVelocity;
@property (nonatomic, assign) MenuPanDirection panDirection;

@property (nonatomic, assign) BOOL menuOpened;
@property (nonatomic, assign) CGFloat menuAnimationDefaultDuration;
@property (nonatomic, assign) CGFloat menuWidth;
@property (nonatomic, assign) CGFloat togglePercentage;

@end

static SideMenuManagerViewController *sharedInstance = nil;

@implementation SideMenuManagerViewController

+ (SideMenuManagerViewController*)instance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {            
            sharedInstance = [SideMenuManagerViewController new];
        }
    }
    return sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuWidth = 260.0f;
    self.menuAnimationDefaultDuration = 0.2f;
    self.togglePercentage = 0.4f;
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handlePan:)];
    [recognizer setMaximumNumberOfTouches:1];
    [recognizer setDelegate:self];
    [recognizer setCancelsTouchesInView:NO];
    
    [self.view addGestureRecognizer:recognizer];
    
    [self.view addSubview:[self.menuController view]];
    [self.view addSubview:[self.centerController view]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIGestureRecognizer Callbacks

- (void) handlePan:(UIPanGestureRecognizer *)recognizer {
    
    UIView *view = [self.centerController view];
    CGRect frame = [self.centerController view].frame;
    
    if(recognizer.state == UIGestureRecognizerStateBegan) {
        _panGestureOrigin = view.frame.origin;
        self.panDirection = MenuPanDirectionNone;
    }
    
    if(self.panDirection == MenuPanDirectionNone) {
        CGPoint translatedPoint = [recognizer translationInView:view];
        if(translatedPoint.x > 0) {
            self.panDirection = MenuPanDirectionRight;
        }
        else if(translatedPoint.x < 0) {
            self.panDirection = MenuPanDirectionLeft;
        }
    }
    
    CGPoint translatedPoint = [recognizer translationInView:view];
    
    
    if (self.panDirection == MenuPanDirectionRight && !_menuOpened) {
        frame.origin.x = translatedPoint.x;
    }
    else if (_menuOpened)
    {
        
        frame.origin.x = _panGestureOrigin.x - fabs(translatedPoint.x);
    }
    
    [self.centerController view].frame = frame;
    
    if(recognizer.state == UIGestureRecognizerStateEnded) {
        
        if (translatedPoint.x > _menuWidth * self.togglePercentage) {
            [self showMenu];
        }
        else
        {
            [self hideMenu];
        }
        
    }
    
}

#pragma mark - Center View Controller Movement

-(IBAction)toggleMenu:(id)sender
{
    if (_menuOpened) {
        [self hideMenu];
    }
    else
    {
        [self showMenu];
    }
}

-(void)hideMenu
{
    [UIView animateWithDuration:self.menuAnimationDefaultDuration delay:0.0 options:0
                     animations:^{
                         CGRect frame = [self.centerController view].frame;
                         frame.origin.x = 0;
                         [self.centerController view].frame = frame;
                                 _panGestureOrigin = [self.centerController view].frame.origin;
                     }
                     completion:nil];
    
    _menuOpened = NO;
}

-(void)showMenu
{
    
    [UIView animateWithDuration:self.menuAnimationDefaultDuration delay:0.0 options:0
                     animations:^{
                         CGRect frame = [self.centerController view].frame;
                         frame.origin.x = _menuWidth;
                         [self.centerController view].frame = frame;
                                 _panGestureOrigin = [self.centerController view].frame.origin;
                     }
                     completion:nil];
    
    _menuOpened = YES;

}

-(void)showCenter
{
    if (_menuOpened) {
        [self hideMenu];
    }
}

@end
