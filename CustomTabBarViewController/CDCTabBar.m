//
//  CDCTabBar.m
//  CustomTabBarViewController
//
//  Created by Chanry on 14-4-3.
//  Copyright (c) 2014年 Chanry. All rights reserved.
//

#import "CDCTabBar.h"

#define kTabBarItemsMoveLeft   1  //向左移动
#define kTabBarItemsMoveRight  2  //向右移动

#define kTabBarLeftSide        1  //左侧
#define kTabBarRightSize       2  //右侧

@implementation CDCTabBarItem

- (id)initWithNormalBgImage :(UIImage*)normalImage selecetdBgImage:(UIImage*)selectedImage normalTitle:(NSString*)normalText selectedTitle:(NSString*)selectedText barTotalNum:(int)total currentIndex:(int)index selectAction:(CDCTabBarSelectAction)action {
    
    CGRect frame = CGRectMake( 0,
                              [UIScreen mainScreen].bounds.size.height - kCDCTabBarHeight,
                              total >= kCDCTabBarVisibleItemsMax ?
                                            [UIScreen mainScreen].bounds.size.width/kCDCTabBarVisibleItemsMax :
                                            [UIScreen mainScreen].bounds.size.width/total,
                              kCDCTabBarHeight);
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blueColor];
        self.tabIndex = index;
        
        if (action != nil) {
            self.SelecAction = action;
            
            [self addTarget:self action:@selector(clickedAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if (normalImage != nil) {
            [self setBackgroundImage:normalImage forState:UIControlStateNormal];
            
            if (selectedImage != nil) {
                [self setBackgroundImage:selectedImage forState:UIControlStateSelected];
            }
        }
        
        if ([normalText length] > 0) {
            self.normalTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 3*frame.size.height/4, frame.size.width, frame.size.height/4)];
            self.normalTitle.backgroundColor = [UIColor clearColor];
            self.normalTitle.text = normalText;
            self.normalTitle.textColor = [UIColor whiteColor];
            self.normalTitle.textAlignment = NSTextAlignmentCenter;
            self.normalTitle.font = [UIFont systemFontOfSize:11.0f];
            [self addSubview:self.normalTitle];
            //样式需要TODO
            if ([selectedText length] > 0) {
                //TODO
                self.selectedTitle = [[UILabel alloc] initWithFrame:self.normalTitle.frame];
                self.selectedTitle.backgroundColor = [UIColor clearColor];
                self.selectedTitle.text = selectedText;
                self.selectedTitle.textColor = [UIColor whiteColor];
                self.selectedTitle.font = [UIFont systemFontOfSize:11.0f];
                self.selectedTitle.textAlignment = NSTextAlignmentCenter;
                [self addSubview:self.selectedTitle];
                self.selectedTitle.hidden = YES;
            }
        }
        
        [self registeNotification];
    }
    return self;
}

- (id)initWithNormalBgImage :(UIImage*)normalImage selecetdBgImage:(UIImage*)selectedImage normalTitle:(NSString*)normalText barTotalNum:(int)total currentIndex:(int)index selectAction:(CDCTabBarSelectAction)action {
    
    self = [self initWithNormalBgImage:normalImage selecetdBgImage:normalImage normalTitle:normalText selectedTitle:normalText barTotalNum:total currentIndex:(int)index selectAction:action];
    
    return self;
}

- (id)initWithNormalBgImage :(UIImage*)normalImage normalTitle:(NSString*)normalText selectedTitle:(NSString*)selectedText barTotalNum:(int)total currentIndex:(int)index selectAction:(CDCTabBarSelectAction)action {
    
    self = [self initWithNormalBgImage:normalImage selecetdBgImage:normalImage normalTitle:normalText selectedTitle:selectedText barTotalNum:total currentIndex:(int)index selectAction:action];
    
    return self;
}

- (id)initWithNormalBgImage :(UIImage*)normalImage normalTitle:(NSString*)normalText barTotalNum:(int)total currentIndex:(int)index selectAction:(CDCTabBarSelectAction)action {
    
    self = [self initWithNormalBgImage:normalImage selecetdBgImage:normalImage normalTitle:normalText barTotalNum:total currentIndex:(int)index selectAction:action];
    
    return self;
}

- (id)initWithNormalTitle :(NSString*)normalText selectedTitle:(NSString*)selectedText barTotalNum:(int)total currentIndex:(int)index selectAction:(CDCTabBarSelectAction)action {
    
    self = [self initWithNormalBgImage:nil normalTitle:normalText selectedTitle:selectedText barTotalNum:total currentIndex:(int)index selectAction:action];
    
    return self;
}

- (id)initWithNormalBgImage :(UIImage*)normalImage barTotalNum:(int)total currentIndex:(int)index selectAction:(CDCTabBarSelectAction)action {
    
    self = [self initWithNormalBgImage:normal normalTitle:@"" barTotalNum:total currentIndex:(int)index selectAction:action];
    
    return self;
}

- (id)initWithTabBarModel :(CDCTabBarItemModel*)model barTotalNum:(int)total currentIndex:(int)index selectedAction:(CDCTabBarSelectAction)action {
    
    return [self initWithNormalBgImage:model.image selecetdBgImage:model.imageSelected normalTitle:model.title selectedTitle:model.titleSelected barTotalNum:total currentIndex:(int)index selectAction:action];
}

/**
 *  点击后，触发的事件
 *
 *  @param sender 按钮本身
 */
- (void)clickedAction :(id)sender {
    
    if (self.SelecAction) {
        [self postNotification];
        self.SelecAction();
    }
    
    [self setSelectedState:YES];
}

/**
 *  设置选中状态
 *
 *  @param selected YES 选中
 */
- (void)setSelectedState :(BOOL)selected {
    if (selected) {
        self.selected = YES;
        if (self.selectedTitle) {
            self.selectedTitle.hidden = NO;
            self.normalTitle.hidden = YES;
        }
    } else {
        self.selected = NO;
        if (self.selectedTitle) {
            self.selectedTitle.hidden = YES;
            self.normalTitle.hidden = NO;
        }
    }
}

/**
 *  注册点击tab后通知
 */
- (void)registeNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeSelectedIndexChange:) name:kCDCTabBarSelectedNotification object:nil];
}
/**
 *  传送通知
 */
- (void)postNotification {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kCDCTabBarSelectedNotification object:nil userInfo:@{@"selectedIndex": [NSNumber numberWithInt:self.tabIndex],@"originX":[NSNumber numberWithFloat:self.frame.origin.x]}];
}
/**
 *  去除通知
 */
- (void)unRegisteNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCDCTabBarSelectedNotification object:nil];
}
/**
 *  监听事件
 *
 *  @param notification
 */
- (void)observeSelectedIndexChange :(id)notification{
    
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *selectedIndex = userInfo[@"selectedIndex"];
    
    [self setSelectedState:[selectedIndex intValue] == self.tabIndex];
}

- (void)dealloc {
    [self unRegisteNotification];
}
@end

@interface CDCTabBarWrapper()
{
    BOOL bNeedsScroll;//是否需要滚动才能看到所有tab
}
@end
@implementation CDCTabBarWrapper

- (id)initWithFrame:(CGRect)frame tabBarItems:(NSArray *)items moreBar:(CDCTabBarMoreBarModel *)moreBar{
    
    frame.origin = CGPointZero;
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.tabBarItems = items;
        self.moreBarModel = moreBar;
        bNeedsScroll = [items count] > kCDCTabBarVisibleItemsMax;

        self.tabsContainer = [self createTabsContainer:frame numberOfTabs:[items count]];
        self.tabsContainer.backgroundColor = [UIColor blueColor];
        [self addSubview:self.tabsContainer];
        
        [self createTabs:items];
    
        //不多于5个可以显示一屏
        if ([items count] <= kCDCTabBarVisibleItemsMax) {
            
        }
        //多于5个需要可以拖动
        else {
            [self createSideBar];
            [self registeNotification];
        }
    }
    
    return self;
}

/**
 *  创建tabs容器
 *
 *  @param frame  可视区域
 *  @param number tab个数
 *
 *  @return
 */
- (UIScrollView*)createTabsContainer :(CGRect)frame numberOfTabs:(int)number {
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:frame];
    
    if (bNeedsScroll) {
        
        scroll.contentSize = CGSizeMake(number * frame.size.width / 5 + kCDCTabBarLeftBarWidth * 2, frame.size.height);
        scroll.scrollEnabled = YES;
        scroll.showsVerticalScrollIndicator = NO;
        scroll.bounces = NO;
    } else {
        
        scroll.contentSize = frame.size;
    }
    
    return scroll;
}

- (void)createTabs :(NSArray*)tabItems {
    
    for (int i = 0; i < [tabItems count]; i++) {
        
        CDCTabBarItem *item = (CDCTabBarItem*)tabItems[i];
        NSAssert(item != nil, @"不能为空，CDCTabBarItem类型不对");
        //第一个默认选中
        if (i == 0) {
            [item setSelectedState:YES];
        }
        
        CGFloat startX = bNeedsScroll ? kCDCTabBarLeftBarWidth : 0.0;
        CGRect frame = CGRectMake(startX + i * item.bounds.size.width, 0, item.bounds.size.width, item.bounds.size.height);
        item.frame = frame;
        [self.tabsContainer addSubview : item];
        
    }
}

- (void)createSideBar {
    
    //可点击右边
    self.moreItemsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreItemsButton.frame = CGRectMake( self.frame.size.width - kCDCTabBarMoreBarWidth, 0,
                                             kCDCTabBarMoreBarWidth, self.frame.size.height );
    
    self.moreItemsButton.backgroundColor = [UIColor clearColor];
    [self.moreItemsButton setBackgroundImage:self.moreBarModel.leftImage forState:UIControlStateNormal];
    
    self.moreItemsButton.tag = kTabBarItemsMoveLeft;
    
    //不可点击右边
    self.rightButtonDisabled = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButtonDisabled.frame = CGRectMake( self.frame.size.width - kCDCTabBarMoreBarWidth, 0,
                                            kCDCTabBarLeftBarWidth, self.frame.size.height );
    
    self.rightButtonDisabled.backgroundColor = [UIColor clearColor];
    [self.rightButtonDisabled setBackgroundImage:self.moreBarModel.rightImageDisabled forState:UIControlStateNormal];
    
    //可点击左边
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake( 0, 0, kCDCTabBarMoreBarWidth, self.frame.size.height );
    
    self.leftButton.backgroundColor = [UIColor clearColor];
    [self.leftButton setBackgroundImage:self.moreBarModel.rightImage forState:UIControlStateNormal];
    
    self.leftButton.tag = kTabBarItemsMoveRight;
    
    //不可点击左边
    self.leftButtonDisabled = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButtonDisabled.frame = CGRectMake( 0, 0, kCDCTabBarLeftBarWidth, self.frame.size.height );
    
    self.leftButtonDisabled.backgroundColor = [UIColor clearColor];
    [self.leftButtonDisabled setBackgroundImage:self.moreBarModel.leftImageDisabled forState:UIControlStateNormal];
    
    
    if (self.tabsContainer) {
        [self insertSubview:self.moreItemsButton aboveSubview:self.tabsContainer];
        [self insertSubview:self.leftButton aboveSubview:self.tabsContainer];
        
        [self insertSubview:self.rightButtonDisabled aboveSubview:self.tabsContainer];
        [self insertSubview:self.leftButtonDisabled aboveSubview:self.tabsContainer];
        
        //状态改变 左边可点击
        [self setClickableStateSize:kTabBarRightSize];
    } else {
        NSLog(@"请检查为什么滚动区为什么为空");
    }
    
    
    [self.moreItemsButton addTarget:self action:@selector(moveTabsAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftButton addTarget:self action:@selector(moveTabsAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)moveTabsAction :(id)sender {
    
    if ([sender tag] == kTabBarItemsMoveLeft) {
        [self moveToSide:kTabBarLeftSide];
    } else if ([sender tag] == kTabBarItemsMoveRight) {
        [self moveToSide:kTabBarRightSize];
    }
}

- (void)moveToSide :(int)side {
    if (side == kTabBarRightSize) {
        [self.tabsContainer scrollRectToVisible:self.tabsContainer.frame animated:YES];
        //状态改变 左边可点击
        [self setClickableStateSize:kTabBarRightSize];
    } else if (side == kTabBarLeftSide) {
        CGRect visibleRect = self.tabsContainer.frame;
        visibleRect.origin.x = self.tabsContainer.contentSize.width - visibleRect.size.width;
        [self.tabsContainer scrollRectToVisible:visibleRect animated:YES];
        //状态改变 左边可点击
        [self setClickableStateSize:kTabBarLeftSide];
    }
}

/**
 *  设置tab两边 哪边可以点击
 *
 *  @param side 左侧或右侧
 */
- (void)setClickableStateSize :(int)side {
    
    if (side == kTabBarLeftSide) {
        self.rightButtonDisabled.hidden = NO;
        self.moreItemsButton.hidden = YES;
        self.leftButton.hidden = NO;
        self.leftButtonDisabled.hidden = YES;
    } else if (side == kTabBarRightSize) {
        self.rightButtonDisabled.hidden = YES;
        self.moreItemsButton.hidden = NO;
        self.leftButton.hidden = YES;
        self.leftButtonDisabled.hidden = NO;
    }
}

/**
 *  注册点击tab后通知
 */
- (void)registeNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeSelectedIndexChange:) name:kCDCTabBarSelectedNotification object:nil];
}
/**
 *  去除通知
 */
- (void)unRegisteNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCDCTabBarSelectedNotification object:nil];
}
/**
 *  监听事件
 *
 *  @param notification
 */
- (void)observeSelectedIndexChange :(id)notification{
    
    if (bNeedsScroll) {
        NSDictionary *userInfo = [notification userInfo];
        NSNumber *originX = userInfo[@"originX"];
        
        CGFloat absoluteX = [originX floatValue] - self.tabsContainer.contentOffset.x;
        //如果originX 小于左侧按钮宽度 则向右边滚动
        if (absoluteX < kCDCTabBarLeftBarWidth) {
            NSLog(@"右边滚动");
            [self moveToSide:kTabBarRightSize];
        }
        //如果originX 大于五分之四屏幕了  需要向左滚动
        else if (absoluteX > 4 * [UIScreen mainScreen].bounds.size.width / 5){//To Be recheck...
            NSLog(@"向左滚动");
            [self moveToSide:kTabBarLeftSide];
        }
    }
}

- (void)dealloc {
    [self unRegisteNotification];
}
@end



@implementation CDCTabBar

- (id)initWithFrame:(CGRect)frame tabBarItems:(NSArray *)items moreBar:(CDCTabBarMoreBarModel *)moreBar
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.wrapper = [[CDCTabBarWrapper alloc] initWithFrame:frame tabBarItems:items moreBar:moreBar];
        self.moreBarModel = moreBar;
        [self addSubview:self.wrapper];
        
        
    }
    return self;
}

@end
