//
//  CDCTabBarModel.m
//  CustomTabBarViewController
//
//  Created by Chanry on 14-4-4.
//  Copyright (c) 2014年 Chanry. All rights reserved.
//

#import "CDCTabBarModel.h"

@implementation CDCTabBarMoreBarModel

- (id)initWithDictionary:(NSDictionary *)dict {
    
    self = [super init];
    
    NSString *bundleName = @"";
    if ([dict[@"defaultTheme"] length] > 0 && dict[@"defaultTheme"] != [NSNull null]) {
        bundleName = dict[@"defaultTheme"];
    }
    
    if ([dict[@"leftBarImage"] length] > 0 && dict[@"leftBarImage"] != [NSNull null]) {
        self.leftImage = [UIImage imageNamed:[bundleName stringByAppendingString: dict[@"leftBarImage"]]];
    }
    if ([dict[@"rightBarImage"] length] > 0 && dict[@"rightBarImage"] != [NSNull null]) {
        self.rightImage = [UIImage imageNamed:[bundleName stringByAppendingString: dict[@"rightBarImage"]]];
    }
    if ([dict[@"leftBarImageDisabled"] length] > 0 && dict[@"leftBarImageDisabled"] != [NSNull null]) {
        self.leftImageDisabled = [UIImage imageNamed:[bundleName stringByAppendingString: dict[@"leftBarImageDisabled"]]];
    }
    if ([dict[@"rightBarImageDisabled"] length] > 0 && dict[@"rightBarImageDisabled"] != [NSNull null]) {
        self.rightImageDisabled = [UIImage imageNamed:[bundleName stringByAppendingString: dict[@"rightBarImageDisabled"]]];
    }
    
    return self;
}

@end


@implementation CDCTabBarModel

- (id)initWithJsonFile  {
    
    self = [super init];
    
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:kTabBarJsonFileName ofType:@"json"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        NSError *error = nil;
        id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSAssert(error == nil, @"未读取到Json文件，或文件出错!");
        
        NSDictionary *dic = (NSDictionary*)jsonData;
        
        if (dic[@"defaultTheme"]) {
            self.defaultTheme = dic[@"defaultTheme"];
        }
        
        if ([dic[@"tabBarItems"] isKindOfClass:[NSArray class]]) {
            
            NSMutableArray *mulArray = [[NSMutableArray alloc] initWithCapacity:[dic[@"tabBarItems"] count]];
            
            NSArray *tabItems = (NSArray*)dic[@"tabBarItems"];
            for (NSDictionary *item in tabItems) {
                NSMutableDictionary *mutalbeItem = [[NSMutableDictionary alloc] initWithDictionary:item];
                [mutalbeItem setValue:self.defaultTheme forKeyPath:@"defaultTheme"];
                CDCTabBarItemModel *model = [[CDCTabBarItemModel alloc] initWithDictionary:mutalbeItem];
                [mulArray addObject:model];
            }
            self.tabBarItems = mulArray;
        }
        
        if (dic[@"moreBar"]) {
            NSMutableDictionary *mutalbeItem = [[NSMutableDictionary alloc] initWithDictionary:dic[@"moreBar"]];
            [mutalbeItem setValue:self.defaultTheme forKeyPath:@"defaultTheme"];
            self.moreBar = [[CDCTabBarMoreBarModel alloc] initWithDictionary:mutalbeItem];
        }
        
    }
    
    return self;
}

@end
