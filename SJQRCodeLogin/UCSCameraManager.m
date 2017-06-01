//
//  UCSCameraManager.m
//  Linkedsee
//
//  Created by UCSAPP on 2017/5/17.
//  Copyright © 2017年 UCSLinkedSee. All rights reserved.
//

#import "UCSCameraManager.h"
#import "UCSQRScanConst.h"

@interface UCSCameraManager ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, assign) CGRect rectOfInterest;

@end

@implementation UCSCameraManager

- (void)dealloc{
    
    NSLog(@"****UCSCameraManager Dealloced");
}

#pragma mark - PublicMethods

- (void)makePreparationWithInterestRect:(CGRect)rect ofCameraStatus:(CameraCheckHandler)block {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        
        self.rectOfInterest = rect;
        
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (status == AVAuthorizationStatusNotDetermined) {
            
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                
                if (granted) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (block) {
                            block(CameraCheckStatusInitialGranted);
                        }
                        [self initializeScaner];
                    });
                }
            }];
            
        } else if (status == AVAuthorizationStatusAuthorized) {
            
            if (block) {
                block(CameraCheckStatusSucceed);
            }
            [self initializeScaner];
            
        } else if (status == AVAuthorizationStatusDenied) {
            
            if (block) {
                block(CameraCheckStatusClosed);
            }
        }
        
    } else {
        
        if (block) {
            block(CameraCheckStatusUnsupport);
        }
    }
}

- (void)initializeScaner{
    
    CGFloat centerWidth = (SCREEN_WIDTH - 2*(UCSGQRCodeWindowBorderWidth + UCSGQRCodeWindowLeading));
    
    if (!_captureDevice) {
        
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        output.rectOfInterest = CGRectMake((self.rectOfInterest.origin.y + UCSGQRCodeWindowBorderWidth)/SCREEN_HEIGHT, (self.rectOfInterest.origin.x + UCSGQRCodeWindowBorderWidth)/SCREEN_WIDTH, centerWidth/SCREEN_HEIGHT, centerWidth/SCREEN_WIDTH);
        [self.session addInput:input];
        [self.session addOutput:output];
        
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
        _captureDevice = device;
        [self.session startRunning];
    }
}

- (void)startScan{
    
    if (_captureDevice) {
        [self.session performSelector:@selector(startRunning) withObject:nil afterDelay:0.001];
    }
}

- (void)stopScan{
    
    if (self.session.running) {
        [self.session performSelector:@selector(stopRunning) withObject:nil afterDelay:0.001];
    }
}

#pragma mark - - - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    [self stopScan];
    
    if (metadataObjects.count > 0) {
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSLog(@"*****%@", obj.stringValue);
        
        if (self.scanHandler) {
            self.scanHandler(YES, obj.stringValue);
        }
    }
}

#pragma mark - Properties Getter Setter

- (AVCaptureSession *)session{
    
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer{
    
    if (!_previewLayer) {
        
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _previewLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    
    return _previewLayer;
}

@end
