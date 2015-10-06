//
//  MenuItem.h
//  MailInvision
//
//  Created by Juanchi Salas on 10/5/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MenuItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSMutableArray *children;
@property (nonatomic, copy) UIImage *icon;
@property BOOL isActive;

@end
