//
//  UCSQRCodeResultViewController.m
//  QRCodeTest
//
//  Created by UCSAPP on 2017/5/15.
//  Copyright © 2017年 UCSMY. All rights reserved.
//

#import "UCSQRCodeResultViewController.h"
#import "UIImage+Bundle.h"
#import "UCSQRScanConst.h"

@interface UCSQRCodeResultViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *resultLogo;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation UCSQRCodeResultViewController

#pragma mark - ViewLifeCycle

- (void)dealloc{
    
    NSLog(@"UCSQRCodeResultViewController Dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    [self initViewModel];
}

#pragma mark - Properties Getter Setter


#pragma mark - Actions

- (IBAction)loginAction:(id)sender {
    
    if (_cancelButton.hidden) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleDefault) handler:nil];
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    }
}

- (IBAction)cancelAction:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PublicMethods

#pragma mark - PrivateMethods

- (void)initUI{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self.navigationController action:@selector(dismissModalViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barBtnItem;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _resultLogo.image = [UIImage loadFromQRCodeBundleWithName:UCSGQRCodeWindowResultTopLogoImage];
    self.title = NAVI_TITLE;
    _descriptionLabel.text = DESCRIPTION_TITLE;
}

- (void)initViewModel{
   
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
