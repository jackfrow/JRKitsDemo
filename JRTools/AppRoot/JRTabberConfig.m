//
//  JRTabberConfig.m
//  JRTabbarViewController
//
//  Created by 徐方豪 on 2018/4/4.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRTabberConfig.h"
#import "JRBasicNavigationController.h"

@interface JRTabberConfig()

@property (nonatomic,strong,readwrite) CYLTabBarController* tabBarController;

@end

@implementation JRTabberConfig

-(CYLTabBarController *)tabBarController{

    if (_tabBarController == nil) {
        
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController];
//        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
        
    }
    return _tabBarController;
    
}

- (NSArray *)viewControllers {
    
    NSMutableArray* temps = [@[] mutableCopy];
    
    NSArray* classString = @[@"JRPeronalTableViewController",@"JRMessageViewController"];
    
    UIViewController* tempViewController;
    
    UINavigationController* tempNavigationController;

    Class class;
    
    for (NSString*  temp in classString) {
        
        class = NSClassFromString(temp);
        
        tempViewController = [[class alloc] init];
        
        tempNavigationController = [[JRBasicNavigationController alloc] initWithRootViewController:tempViewController];
        
        [temps addObject:tempNavigationController];
        
    }
    
//    HomeViewController* home = [[HomeViewController alloc] init];
//    JRBaseNavigationController* homeNavigationController = [[JRBaseNavigationController alloc] initWithRootViewController:home];
//
//    PersonalViewController* person = [[PersonalViewController alloc] init];
//    JRBaseNavigationController* personNavigationController = [[JRBaseNavigationController alloc] initWithRootViewController:person];
//
//    NSArray* viewControllers = @[homeNavigationController,personNavigationController];
   
    return temps;
    
}


- (NSArray *)tabBarItemsAttributesForController {
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 //                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"home_normal",  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : @"home_highlight", /* NSString and UIImage are supported*/
                                                 };
//    NSDictionary *secondTabBarItemsAttributes = @{
//                                                  //                                                  CYLTabBarItemTitle : @"同城",
//                                                  CYLTabBarItemImage : @"mycity_normal",
//                                                  CYLTabBarItemSelectedImage : @"mycity_highlight",
//                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 //                                                 CYLTabBarItemTitle : @"消息",
                                                 CYLTabBarItemImage : @"message_normal",
                                                 CYLTabBarItemSelectedImage : @"message_highlight",
                                                 };
//    NSDictionary *fourthTabBarItemsAttributes = @{
//                                                  //                                                  CYLTabBarItemTitle : @"我的",
//                                                  CYLTabBarItemImage : @"account_normal",
//                                                  CYLTabBarItemSelectedImage : @"account_highlight"
//                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
//                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
//                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}



@end
