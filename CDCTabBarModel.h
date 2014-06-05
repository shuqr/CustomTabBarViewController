//
//  CDCTabBarModel.h
//  CustomTabBarViewController
//
//  Created by Chanry on 14-4-4.
//  Copyright (c) 2014年 Chanry. All rights reserved.
//
#import "CDCTabBarItemModel.h"

#define kTabBarJsonFileName    @"TabBar"


@interface CDCTabBarMoreBarModel : NSObject

@property (nonatomic, retain) UIImage *leftImage;
@property (nonatomic, retain) UIImage *rightImage;
@property (nonatomic, retain) UIImage *leftImageDisabled;
@property (nonatomic, retain) UIImage *rightImageDisabled;

- (id)initWithDictionary :(NSDictionary*)dict;

@end



@interface CDCTabBarModel : NSObject

@property (nonatomic, copy) NSArray *tabBarItems;
@property (nonatomic, retain) CDCTabBarMoreBarModel *moreBar;
@property (nonatomic, retain) NSString *defaultTheme;

- (id)initWithJsonFile;

@end
