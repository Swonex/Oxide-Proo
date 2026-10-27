#import <UIKit/UIKit.h>
#include <CoreGraphics/CoreGraphics.h>

// Global Hile Durumları (Toggle Değişkenleri)
bool g_AimbotEnabled = false;
bool g_ESPEnabled = false;
float g_FOVSize = 100.0f;

// Menü Arayüzünü Göstermek İçin Floating Button (Yüzen Menü Butonu)
@interface CheatMenuManager : NSObject
@property (strong, nonatomic) UIButton *menuButton;
@property (strong, nonatomic) UIView *menuPanel;
+ (instancetype)sharedInstance;
- (void)setupMenu;
@end

@implementation CheatMenuManager

+ (instancetype)sharedInstance {
    static CheatMenuManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CheatMenuManager alloc] init];
    });
    return sharedInstance;
}

- (void)setupMenu {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedService].keyWindow;
        if (!window) return;

        // Yüzen Menü Açma Butonu
        self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.menuButton.frame = CGRectMake(50, 100, 50, 50);
        self.menuButton.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8];
        self.menuButton.layer.cornerRadius = 25;
        [self.menuButton setTitle:@"O" forState:UIControlStateNormal];
        [self.menuButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [self.menuButton addTarget:self action:@selector(toggleMenu:) forControlEvents:UIControlEventTouchUpInside];
        [window addSubview:self.menuButton];

        // Ana Hile Kontrol Paneli
        self.menuPanel = [[UIView alloc] initWithFrame:CGRectMake(100, 150, 260, 300)];
        self.menuPanel.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:0.95];
        self.menuPanel.layer.cornerRadius = 12;
        self.menuPanel.hidden = YES;

        // Başlık
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 220, 30)];
        titleLabel.text = @"Oxide Pro Menu v1.0";
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.menuPanel addSubview:titleLabel];

        // ESP Switch
        UILabel *espLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 150, 30)];
        espLabel.text = @"ESP (Wallhack)";
        espLabel.textColor = [UIColor whiteColor];
        espLabel.font = [UIFont systemFontOfSize:14];
        [self.menuPanel addSubview:espLabel];

        UISwitch *espSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(190, 70, 0, 0)];
        [espSwitch addTarget:self action:@selector(toggleESP:) forControlEvents:UIControlEventValueChanged];
        [self.menuPanel addSubview:espSwitch];

        // Aimbot Switch
        UILabel *aimLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 150, 30)];
        aimLabel.text = @"Aimbot (Smooth)";
        aimLabel.textColor = [UIColor whiteColor];
        aimLabel.font = [UIFont systemFontOfSize:14];
        [self.menuPanel addSubview:aimLabel];

        UISwitch *aimSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(190, 130, 0, 0)];
        [aimSwitch addTarget:self action:@selector(toggleAimbot:) forControlEvents:UIControlEventValueChanged];
        [self.menuPanel addSubview:aimSwitch];

        [window addSubview:self.menuPanel];
    });
}

- (void)toggleMenu:(id)sender {
    self.menuPanel.hidden = !self.menuPanel.hidden;
}

- (void)toggleESP:(UISwitch *)sender {
    g_ESPEnabled = sender.isOn;
}

- (void)toggleAimbot:(UISwitch *)sender {
    g_AimbotEnabled = sender.isOn;
}

@end

// Constructor: Oyun Başladığında Kütüphanenin Yüklenmesi
__attribute__((constructor)) static void entry() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[CheatMenuManager sharedInstance] setupMenu];
    });
}
