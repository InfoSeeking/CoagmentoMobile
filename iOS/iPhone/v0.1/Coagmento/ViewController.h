//
//  ViewController.h
//  Coagmento

#import <UIKit/UIKit.h>

@class Reachability;

@interface ViewController : UIViewController <UIWebViewDelegate>{
    IBOutlet UIWebView *webView;
    IBOutlet UIBarButtonItem *backButton;
    Reachability* internetReachable;
    Reachability* hostReachable;
}

-(void) checkNetworkStatus:(NSNotification *)notice;

@property (nonatomic, retain) UIWebView *webView;	

@end
