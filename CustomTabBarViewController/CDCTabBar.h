//
//  CDCTabBar.h
//  CustomTabBarViewController
//
//  Created by Chanry on 14-4-3.
//  Copyright (c) 2014年 Chanry. All rights reserved.
//
#import "CDCTabBarModel.h"

#define kCDCTabBarVisibleItemsMax    5  //看的见的tab最多5个
#define kCDCTabBarHeight             48 //定义tabBar高度

#define kCDCTabBarMoreBarWidth       20               //导航条的更多按钮宽度
#define kCDCTabBarLeftBarWidth       10               //左边的按钮宽带
#define kCDCTabBarMoreBarImageName   @"rightMoreBar"  //显示最右边tab按钮

#define kCDCTabBarSelectedNotification   @"kCDCTabBarSelectedNotification"  //点击tab触发通知

#define kCDCTabBar

/**
 *  选择TabBar选项触发的动作Block
 */
typedef void(^CDCTabBarSelectAction)();


/**
 *  可点击的单元
 */
@interface CDCTabBarItem : UIButton

/**
 *  未选中显示背景
 */
@property (nonatomic, retain) UIImage *normalBgImage;
/**
 *  选中显示背景
 */
@property (nonatomic, retain) UIImage *selectedBgImage;
/**
 *  tab显示的文字
 */
@property (nonatomic, retain) UILabel *normalTitle;
/**
 *  选中文本，默认与普通一样
 */
@property (nonatomic, retain) UILabel *selectedTitle;
/**
 *  点击触发的动作，用于callback
 */
@property (nonatomic, copy) CDCTabBarSelectAction SelecAction;
/**
 *  tab所处的顺序 从0开始
 */
@property (nonatomic) int tabIndex;


- (id)initWithNormalBgImage :(UIImage*)normalImage selecetdBgImage:(UIImage*)selectedImage normalTitle:(NSString*)normalText selectedTitle:(NSString*)selectedText barTotalNum:(int)total currentIndex:(int)index selectAction:(CDCTabBarSelectAction)action;

- (id)initWithNormalBgImage :(UIImage*)normalImage selecetdBgImage:(UIImage*)selectedImage normalTitle:(NSString*)normalText  barTotalNum:(int)total currentIndex:(int)index selectAction:(CDCTabBarSelectAction)action;

- (id)initWithNormalBgImage :(UIImage*)normalImage normalTitle:(NSString*)normalText selectedTitle:(NSString*)selectedText barTotalNum:(int)total currentIndex:(int)index selectAction:(CDCTabBarSelectAction)action;

- (id)initWithNormalBgImage :(UIImage*)normalImage normalTitle:(NSString*)normalText barTotalNum:(int)total currentIndex:(int)index selectAction:(CDCTabBarSelectAction)action;

- (id)initWithNormalTitle :(NSString*)normalText selectedTitle:(NSString*)selectedText barTotalNum:(int)total currentIndex:(int)index selectAction:(CDCTabBarSelectAction)action;

- (id)initWithNormalBgImage :(UIImage*)normalImage barTotalNum:(int)total currentIndex:(int)index selectAction:(CDCTabBarSelectAction)action;


/**
 *  这个方法可能是众多中唯一需要的
 *
 *  @param model
 *  @param action
 *
 *  @return
 */
- (id)initWithTabBarModel :(CDCTabBarItemModel*)model barTotalNum:(int)total currentIndex:(int)index selectedAction:(CDCTabBarSelectAction)action;

/**
 *  设置选中状态
 *
 *  @param selected YES 选中
 */
- (void)setSelectedState :(BOOL)selected;

@end



/**
 *  包在TabBar外层的固定视图：
 *     与屏幕同宽； 与TabBar同高；
 */
@interface CDCTabBarWrapper : UIView

/**
 *  点击后，显示更多tab（反方向同时隐藏tab）
 *      当tab count不足kCDCTabBarVisibleItemsMax个，不显示
 */
@property (nonatomic, retain) UIButton *moreItemsButton;
/**
 *  tabBar左边按钮，点击后，所有回到最初状态
 */
@property (nonatomic, retain) UIButton *leftButton;
/**
 *  右边不可点击按钮
 */
@property (nonatomic, retain) UIButton *rightButtonDisabled;
/**
 *  左边不可点击按钮
 */
@property (nonatomic, retain) UIButton *leftButtonDisabled;

/**
 *  所有的tab （CDCTabBarItem）
 */
@property (nonatomic, copy) NSArray *tabBarItems;
/**
 *  两边的辅助按钮模型
 */
@property (nonatomic, retain) CDCTabBarMoreBarModel *moreBarModel;

/**
 *  tabBarItems的容器，处于moreItemsButton下方
 */
@property (nonatomic, retain) UIScrollView *tabsContainer;

- (id)initWithFrame :(CGRect)frame tabBarItems :(NSArray*)items moreBar:(CDCTabBarMoreBarModel*)moreBar;

@end



/**
 *  自定义TabBar视图
 */
@interface CDCTabBar : UIView

@property (nonatomic, retain) CDCTabBarWrapper *wrapper;

@property (nonatomic, retain) NSArray *tabBarItems;
///**
// *  左边的图片
// */
//@property (nonatomic, retain) UIImage *leftImage;
///**
// *  左边不可点击的图片
// */
//@property (nonatomic, retain) UIImage *leftImageDisabled;
///**
// *  右边图片
// */
//@property (nonatomic, retain) UIImage *rightImage;
///**
// *  右边不可点击图片
// */
//@property (nonatomic, retain) UIImage *rightImageDisabled;
/**
 *  当tab超过5个  显示在两边的按钮模型
 */
@property (nonatomic, retain) CDCTabBarMoreBarModel *moreBarModel;

- (id)initWithFrame:(CGRect)frame tabBarItems:(NSArray *)items moreBar:(CDCTabBarMoreBarModel*)moreBar;

@end
