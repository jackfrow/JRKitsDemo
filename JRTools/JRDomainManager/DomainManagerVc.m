//
//  DomainManagerVc.m
//  JRKits
//
//  Created by 徐方豪 on 2018/4/12.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "DomainManagerVc.h"
#import "CoreStatus.h"

NSString* const JRDomain = @"Domain";

@interface DomainManagerVc ()<CoreStatusProtocol>

@property (weak, nonatomic) IBOutlet UILabel *NetworkState;
@property (weak, nonatomic) IBOutlet UILabel *NetworkIp;

@property (weak, nonatomic) IBOutlet UILabel *CurrentLabel;

@end

@implementation DomainManagerVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"域名管理"];
    
    DomainModel* model = [NSKeyedUnarchiver  unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:JRDomain]];
    if (model) {
        self.CurrentLabel.text = model.name;
    }
    
    [self updateNetworkData];
    // 开始监听网络状态
    [CoreStatus beginNotiNetwork:self];
    
    // Do any additional setup after loading the view.
}

#pragma mark - 获取当前网络状态及名称
- (void) updateNetworkData
{
    // 是否有网络
    if ([CoreStatus isNetworkEnable]) {
        // 是否处于WiFi状态
        if ([CoreStatus isWifiEnable]) {
            self.NetworkState.text = [NSString stringWithFormat:@"当前网络状态：%@   %@",[CoreStatus currentNetWorkStatusString],[CoreStatus setupGetWifiName]];
            self.NetworkIp.text = [NSString stringWithFormat:@"当前网络IP地址：%@",[CoreStatus deviceIPAdress]];
        }else{
            self.NetworkState.text = [NSString stringWithFormat:@"当前网络状态：%@",[CoreStatus currentNetWorkStatusString]];
            self.NetworkIp.text = [NSString stringWithFormat:@"当前网络IP地址：%@",[CoreStatus deviceWANIPAdress]];
        }
    }else{
        self.NetworkState.text = [NSString stringWithFormat:@"当前网络状态：%@",[CoreStatus currentNetWorkStatusString]];
        self.NetworkIp.text = @"当前网络IP地址：0.0.0.0:0000";
    }
}

/** 网络状态变更 */
-(void)coreNetworkChangeNoti:(NSNotification *)noti
{
    [self updateNetworkData];
}

- (IBAction)Prelive:(id)sender {
    
    DomainModel* model = [[DomainModel alloc] init];
    model.name = @"Prelive";
    model.mainDomain = @"http://prelive.admin.hilife.sg/service";
    [self setDomainWithModel:model];
}


- (IBAction)Staging:(id)sender {
    
    DomainModel* model = [[DomainModel alloc] init];
    model.name = @"Staging";
    model.mainDomain = @"http://staging.admin.hilife.sg/service";
    [self setDomainWithModel:model];
    
}
- (IBAction)Preprod:(id)sender {
    
    DomainModel* model = [[DomainModel alloc] init];
    model.name = @"Preprod";
    model.mainDomain = @"https://preprod.admin.hilife.sg/service";
    [self setDomainWithModel:model];
}

-(void)setDomainWithModel:(DomainModel*)model{
    
    self.CurrentLabel.text = model.name;
    
       [CoreStatus endNotiNetwork:self];
     [self dismissViewControllerAnimated:YES completion:nil];

    if (self.selectedSuceesBlock) {
        self.selectedSuceesBlock(model);
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:model]
                                              forKey:JRDomain];
    [[NSUserDefaults standardUserDefaults] synchronize];//立即同步数据
    

   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@synthesize currentStatus;

@end
