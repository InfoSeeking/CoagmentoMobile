//
//  ViewController.m
//  Coagmento

#import "ViewController.h"
#import "Reachability.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize webView;

- (void)initialize 
{
    //Get screen dimensions
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    int screenWidthInt = (int) screenHeight;
    int screenHeightInt = (int) screenWidth;
    
    //Set user agent String
    NSString *userAgent = [NSString stringWithFormat:
                           @"%@/%@/%@/%d/%d", @"iOS",
                           [[UIDevice currentDevice] systemVersion],
                           [[UIDevice currentDevice] model],
                           screenWidthInt, screenHeightInt];
    
    NSDictionary *dictionnary = [[NSDictionary alloc]
                                 initWithObjectsAndKeys:
                                 userAgent, @"UserAgent",
                                 nil];
    [[NSUserDefaults standardUserDefaults]
     registerDefaults:dictionnary];
    //[dictionnary release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Check for Internet connection
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    internetReachable = [[Reachability reachabilityForInternetConnection] retain];
    [internetReachable startNotifier];
    
    //Check if a pathway to Coagmento exists
    hostReachable = [[Reachability reachabilityWithHostName: @"www.coagmento.org"] retain];
    [hostReachable startNotifier];
    
    //Wait for notification
    
    NSString *fullURL = @"http://www.coagmento.org"; 
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = 
    [NSURLRequest requestWithURL:url]; 
    [webView loadRequest:requestObj];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(void) checkNetworkStatus:(NSNotification *)notice
{
    UIAlertView *networkAlert = [[UIAlertView alloc] initWithTitle: @"Network connectivity"
                                                    message: @"There may be no connectivity or the website may be unavailable. Please verify connectivity and try again."
                                                   delegate: self
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    //NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    
    
    switch (internetStatus)
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            [networkAlert show];
            [networkAlert release];
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            //self.internetActive = YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            //self.internetActive = YES;
            
            break;
        }
    }
}

@end
