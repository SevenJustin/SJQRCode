//
//  UCSQRCodeScanViewController.m
//  QRCodeTest
//
//  Created by UCSAPP on 2017/5/15.
//  Copyright © 2017年 UCSMY. All rights reserved.
//

#import "UCSQRCodeScanViewController.h"
#import "UCSScanerView.h"
#import "UCSQRCodeResultViewController.h"
#import "UCSCameraManager.h"

#define NAVI_TITLE @"扫码登录"

@interface UCSQRCodeScanViewController ()

@property (weak, nonatomic) IBOutlet UCSScanerView *scanerView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong) UCSCameraManager *cameraManager;

@end


@implementation UCSQRCodeScanViewController

#pragma mark - ViewLifeCycle

- (void)dealloc{
    
    NSLog(@" UCSQRCodeScanViewController Dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    [self initViewModel];
    
    [self performSelector:@selector(makePreparationAboutCamera) withObject:nil afterDelay:0.001];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.cameraManager startScan];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.cameraManager stopScan];
}

#pragma mark - Actions

#pragma mark - Getters && Setters

- (UCSCameraManager *)cameraManager{
    
    if (!_cameraManager) {
        _cameraManager = [[UCSCameraManager alloc] init];
    }
    return _cameraManager;
}

#pragma mark - PublicMethods

+ (UCSQRCodeScanViewController *)initQRViewController{
    
    UCSQRCodeScanViewController *qrVC = [[UCSQRCodeScanViewController alloc] init];
    return qrVC;
}

#pragma mark - PrivateMethods

- (void)initUI{
 
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = NAVI_TITLE;
}

- (void)initViewModel{

    __weak typeof(self) weakSelf = self;
    self.cameraManager.scanHandler = ^(BOOL successful, NSString *result) {
        
        __strong typeof(self) strongSelf = weakSelf;
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"扫码结果" message:result preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [strongSelf.cameraManager startScan];
        }];
        [alertC addAction:alertA];
        [strongSelf presentViewController:alertC animated:YES completion:nil];
    };
}

- (void)createScanerMask{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    CGFloat centerWidth = (SCREEN_WIDTH - 2*(UCSGQRCodeWindowBorderWidth + UCSGQRCodeWindowLeading));
    [path appendPath:[[UIBezierPath bezierPathWithRect:CGRectMake(self.scanerView.frame.origin.x + UCSGQRCodeWindowBorderWidth, self.scanerView.frame.origin.y + UCSGQRCodeWindowBorderWidth, centerWidth, centerWidth)] bezierPathByReversingPath]];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    [self.backView.layer setMask:shapeLayer];
    [self.view.layer insertSublayer:self.cameraManager.previewLayer atIndex:0];
}

- (void)makePreparationAboutCamera{
    
    __weak typeof(self) weakSelf = self;
    
    [self.cameraManager makePreparationWithInterestRect:self.scanerView.frame ofCameraStatus:^(CameraCheckStatus status) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        switch (status) {
                
            case CameraCheckStatusClosed:
            case CameraCheckStatusUnsupport: {
                
                [strongSelf popOutAlert:status];
            }
                break;
                
            case CameraCheckStatusInitialGranted:
            case CameraCheckStatusSucceed: {
                
                [strongSelf createScanerMask];
            }
                break;
                
            default:
                break;
        }
    }];
}

- (void)popOutAlert:(CameraCheckStatus)status{
    
    if (status == CameraCheckStatusUnsupport) {
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
        
    }else if (status == CameraCheckStatusClosed){
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在系统设置中允许灵犀访问相机" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertB = [UIAlertAction actionWithTitle:@"暂不" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"去开启" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                
                //TODO: 系统判断
                //            [[UIApplication sharedApplication] openURL:url];
                [[UIApplication sharedApplication] openURL:url options:[NSDictionary dictionary] completionHandler:nil];
            }
        }];
        
        [alertC addAction:alertB];
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    }
}

#pragma mark - Overrides

#pragma mark - Notifications

#pragma mark - Delegate

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
