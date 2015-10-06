//
//  UIImageView+Internet.m
//  MailInvision
//
//  Created by Juanchi Salas on 10/2/15.
//  Copyright (c) 2015 Laterous, LLC. All rights reserved.
//

#import "UIImageView+Internet.h"

@implementation UIImageView (Internet)

-(void)setImageURL:(NSURL*)url
{
    /*
     We can apply a cache here. I think it's out of the scope of the demo app.
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        
        if (imageData.bytes > 0) {
            
            UIImage *image = [UIImage imageWithData:imageData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = image;
            });
            
        }
        
    });
}

@end
