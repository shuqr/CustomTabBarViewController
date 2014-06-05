//
//  CDCTabBarItemModel.h
//  CustomTabBarViewController
//
//  Created by Chanry on 14-4-4.
//  Copyright (c) 2014年 Chanry. All rights reserved.
//


@interface CDCTabBarItemModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleSelected;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImage *imageSelected;
@property (nonatomic, copy) NSString *rootClassString;

- (id)initWithDictionary :(NSDictionary*)dict ;

@end
