//
//  UCSCameraManager.h
//  Linkedsee
//
//  Created by UCSAPP on 2017/5/17.
//  Copyright © 2017年 UCSLinkedSee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSUInteger, CameraCheckStatus) {
    CameraCheckStatusUnsupport,
    CameraCheckStatusSucceed,
    CameraCheckStatusInitialGranted,
    CameraCheckStatusClosed,
};

typedef void(^CameraCheckHandler)(CameraCheckStatus status);
typedef void(^ScanerOutcomeHandler)(BOOL successful, NSString *result);

@interface UCSCameraManager : NSObject

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) AVCaptureDevice *captureDevice;
@property (nonatomic, copy) ScanerOutcomeHandler scanHandler;

- (void)makePreparationWithInterestRect:(CGRect)rect ofCameraStatus:(CameraCheckHandler)block;

- (void)startScan;

- (void)stopScan;

@end
