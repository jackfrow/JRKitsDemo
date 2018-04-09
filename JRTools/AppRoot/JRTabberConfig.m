//
//  JRTabberConfig.m
//  JRTabbarViewController
//
//  Created by 徐方豪 on 2018/4/4.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRTabberConfig.h"
#import "JRBasicNavigationController.h"
#import "JRPeronalTableViewController.h"

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
    
    NSArray* classString = @[@"JRPeronalTableViewController",@"JRPeronalTableViewController",@"JRPeronalTableViewController"];
    
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
    
    NSDictionary *peronalVc = @{CYLTabBarItemTitle : @"个人信息1",CYLTabBarItemImage : @"settings-32",CYLTabBarItemSelectedImage : @"settings-32"};

       NSDictionary *peronalVc1 = @{CYLTabBarItemTitle : @"个人信息2",CYLTabBarItemImage : @"settings-32",CYLTabBarItemSelectedImage : @"settings-32"};
    
       NSDictionary *peronalVc2 = @{CYLTabBarItemTitle : @"个人信息3",CYLTabBarItemImage : @"settings-32",CYLTabBarItemSelectedImage : @"settings-32"};
    
    NSArray *tabBarItemsAttributes = @[peronalVc,peronalVc1,peronalVc2];
    
    return tabBarItemsAttributes;
}



@end
