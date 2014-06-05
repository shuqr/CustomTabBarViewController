//
//  CDCTabBarViewController.h
//  CustomTabBarViewController
//
//  Created by Chanry on 14-4-3.
//  Copyright (c) 2014年 Chanry. All rights reserved.
//

#import "CDCTabBar.h"
#import "CDCTabBarModel.h"

@interface CDCTabBarViewController : UITabBarController

@property(retain,nonatomic) CDCTabBar *cdcTabBar ;

- (void)hideTabBar ;
- (void)showTabBar ;
- (void)hideTabBarWithoutAnimation;

@end
