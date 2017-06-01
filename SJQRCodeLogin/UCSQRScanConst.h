//
//  UCSQRScanConst.h
//  QRCodeTest
//
//  Created by UCSAPP on 2017/5/15.
//  Copyright © 2017年 UCSMY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define NAVI_TITLE @"扫码登录"
#define DESCRIPTION_TITLE @"灵犀网页版登录确认"
#define RESCAN_TITLE @"重新扫描"
#define LOGIN_TITLE @"确认登录"
#define RESCAN_DESCRIPTION @"二维码过期，请重新扫描"
#define LOGIN_DESCRIPTION @"灵犀网页版登录确认"

@interface UCSQRScanConst : NSObject

/*QRWindow边框宽度*/
UIKIT_EXTERN CGFloat const UCSGQRCodeWindowBorderWidth;
/*QRWindow边框与父视图间距*/
UIKIT_EXTERN CGFloat const UCSGQRCodeWindowLeading;

/*QRWindow上左图片*/
UIKIT_EXTERN NSString *const UCSGQRCodeWindowLeftUpImage;
/*QRWindow上右图片*/
UIKIT_EXTERN NSString *const UCSGQRCodeWindowRightUpImage;
/*QRWindow下左图片*/
UIKIT_EXTERN NSString *const UCSGQRCodeWindowLeftBottomImage;
/*QRWindow下右图片*/
UIKIT_EXTERN NSString *const UCSGQRCodeWindowRightBottomImage;
/*QRWindow结果Logo图片*/
UIKIT_EXTERN NSString *const UCSGQRCodeWindowResultTopLogoImage;

@end
