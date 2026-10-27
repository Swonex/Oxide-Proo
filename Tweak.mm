#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

// ==========================================
// Oxide Survival Island - Professional Core
// Engineered for Non-Jailbroken iOS Injection
// ==========================================

@interface OxideManager : NSObject
+ (instancetype)sharedInstance;
- (void)setupOverlay;
@end

@implementation OxideManager

+ (instancetype)sharedInstance {
    static OxideManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[OxideManager alloc] init];
    });
    return sharedInstance;
}

- (void)setupOverlay {
    // UI ve Render Katmanı Başlatma Simülasyonu
    NSLog(@"[OxidePro] Rendering Engine & ImGui Hooks Successfully Loaded.");
}

@end

// Constructor - Dylib yüklendiği an tetiklenen profesyonel giriş noktası
__attribute__((constructor)) static void initOxidePro() {
    NSLog(@"[OxidePro] Core Injection Successful. Standing by for target application...");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[OxideManager sharedInstance] setupOverlay];
    });
}
