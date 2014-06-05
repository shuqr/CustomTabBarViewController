//
//  CDCTabBarItemModel.m
//  CustomTabBarViewController
//
//  Created by Chanry on 14-4-4.
//  Copyright (c) 2014年 Chanry. All rights reserved.
//

#import "CDCTabBarItemModel.h"

@implementation CDCTabBarItemModel

- (id)initWithDictionary :(NSDictionary*)dict  {
    
    self = [super init];
    if (self) {
        
        NSString *bundleName = @"";
        if ([dict[@"defaultTheme"] length] > 0 && dict[@"defaultTheme"] != [NSNull null]) {
            bundleName = dict[@"defaultTheme"];
        }
        
        if ([dict[@"title"] length] > 0 && dict[@"title"] != [NSNull null]) {
            self.title = dict[@"title"];
        }
        if ([dict[@"title_selected"] length] > 0 && dict[@"title_selected"] != [NSNull null]) {
            self.titleSelected = dict[@"title_selected"];
        }
        if ([dict[@"image"] length] > 0 && dict[@"image"] != [NSNull null]) {
            self.image = [UIImage imageNamed:[bundleName stringByAppendingString: dict[@"image"]]];
        }
        if ([dict[@"image_selected"] length] > 0 && dict[@"image_selected"] != [NSNull null]) {
            self.imageSelected = [UIImage imageNamed:[bundleName stringByAppendingString: dict[@"image_selected"]]];
        }
        if ([dict[@"root_class"] length] > 0 && dict[@"root_class"] != [NSNull null]) {
            self.rootClassString = dict[@"root_class"];
        }
    }
    return self;
}

@end
