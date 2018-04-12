//
//  TestViewController.m
//  JRKits
//
//  Created by jackfrow on 2018/4/9.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "TestViewController.h"
#import "HLAPIClient.h"
#import "JRUploadData.h"
#import "DSToast.h"
#import "DomainManager.h"

@interface TestViewController ()<UIImagePickerControllerDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"test";
    
    UIButton* add =[UIButton buttonWithType:UIButtonTypeContactAdd];
    
    add.frame = CGRectMake(200, 200, 50, 50);
    
    [self.view addSubview:add];

    
    [add addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* domain =[UIButton buttonWithType:UIButtonTypeSystem];
    
     [domain addTarget:self action:@selector(showDomain) forControlEvents:UIControlEventTouchUpInside];
    
    [domain setTitle:@"域名控制" forState:UIControlStateNormal];
    
    
    domain.frame = CGRectMake(200, 400, 100, 50);
    
    [self.view addSubview:domain];
   
    
}

-(void)showDomain{
    
    [DomainManager actionManagerPresentVC:self completionBlock:^(DomainModel *model) {
        
        [[DSToast toastWithText:[NSString stringWithFormat:@"已经切换至%@",   model.name]] show];
        
    }];
    
}

-(void)selectImage{
    
    [[self class] ImagePickWithDelegate:self];
    
}

+(void)ImagePickWithDelegate:(id)delegate{
    // 创建UIImagePickerController实例
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    // 设置代理
    imagePickerController.delegate = delegate;
    // 是否允许编辑（默认为NO）
    imagePickerController.allowsEditing = YES;
    
    
    // 创建一个警告控制器
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: NSLocalizedString(@"Image from",nil) message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 设置警告响应事件
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle: NSLocalizedString(@"Camera",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 设置照片来源为相机
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // 设置进入相机时使用前置或后置摄像头
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        //        pushNotificationJumptoDestinationWithUserInfo
        // 展示选取照片控制器
        [delegate presentViewController:imagePickerController animated:YES completion:^{}];
    }];
    
    UIAlertAction *photosAction = [UIAlertAction actionWithTitle: NSLocalizedString(@"Gallery",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [delegate presentViewController:imagePickerController animated:YES completion:^{}];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // 添加警告按钮
        [alert addAction:cameraAction];
    }
    [alert addAction:photosAction];
    [alert addAction:cancelAction];
    // 展示警告控制器
    [delegate presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // 选取完图片后跳转回原控制器
        [picker dismissViewControllerAnimated:YES completion:nil];
        // 从info中将图片取出，并加载到imageView当中
        UIImage *image = [info objectForKey: UIImagePickerControllerEditedImage];
        
        NSData* imageDate = UIImageJPEGRepresentation(image,1);
        
        JRUploadData* header = [[JRUploadData alloc] init];
        
        header.data = imageDate;
        header.paramKey = @"head_portrait";
        
        [[HLAPIClient sharedClient] uploadHeader:[@[header,header,header] mutableCopy] success:^(id responseObject) {
            
            [[DSToast toastWithText:@"上传成功"] show];
            
        } failure:^(NSError *error) {
        
            [[DSToast toastWithText:@"上传失败"] show];
            
        }];
        
        
    });
    

    
}


// 取消选取调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
