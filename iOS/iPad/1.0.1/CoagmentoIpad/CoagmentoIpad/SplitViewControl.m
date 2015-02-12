//
//  SplitViewControl.m
//  CoagmentoIpad
//
//  Created by Josue Reyes on 10/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "SplitViewControl.h"
#import "CoagmentoViewController.h"
#import "CoagmentoMasterViewController.h"
#import "IDsingleton.h"

@interface SplitViewControl ()

@end

@implementation SplitViewControl
@synthesize signedIn, userIDnumbero, signIn, signIn2, storyboard, loadViewOK, loggedOff, myVCS;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    
    if (loadViewOK) {
   
       
       [super viewDidLoad];
    }
	// Do any additional setup after loading the view.
}

-(void)logOuttt{

    signIn = NO;
    userIDnumbero = nil;
    loggedOff = YES;
    
    [self log];
    
   //[super viewDidLoad];
    
    [self viewWillAppear:YES];
}

-(void)log{
    
    storyboard = [self storyboard];
    signIn = [storyboard instantiateViewControllerWithIdentifier:@"SignIn"];
    
    [self presentViewController:signIn animated:YES completion: nil];
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    window.rootViewController = signIn;
    
    
   
    myVCS = [self viewControllers];
    NSArray *masterArray2;
    masterArray2 = [[myVCS objectAtIndex:1] viewControllers];
    [[masterArray2 objectAtIndex:0]setDetail:nil];
    [self viewDidLoad];
    [[masterArray2 objectAtIndex:0] setSelectedIndex:0];
    self.signedIn = YES;
    //[self viewWillAppear:YES];
    
    
}

-(void)clearCMVC{
    //clearing the table for CoagmentoMasterViewController (this is triggered by logging out)
    myVCS = [self viewControllers];
    NSArray *masterArray2;
    masterArray2 = [[myVCS objectAtIndex:0] viewControllers];

    [[masterArray2 objectAtIndex:0]unloadTableData];

    
}

-(void)whatshappening{
    
    storyboard = [self storyboard];
    signIn = [storyboard instantiateViewControllerWithIdentifier:@"SignIn"];
    
    [self presentViewController:signIn animated:YES completion: nil];
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    window.rootViewController = signIn;
    
    if (loggedOff){
        
    }
    
  //  NSArray *myVCS;
    myVCS = [self viewControllers];
    NSArray *masterArray2;
    masterArray2 = [[myVCS objectAtIndex:1] viewControllers];
    [[masterArray2 objectAtIndex:0]setDetail:nil];

    
 //   [self viewDidLoad];
    [[masterArray2 objectAtIndex:0] setSelectedIndex:0];
    self.signedIn = YES;
   // [self viewWillAppear:YES];
    
    
}

- (void) viewDidAppear:(BOOL)animated{


    
    if (signedIn == YES) {
        IDsingleton *singleton = [[IDsingleton alloc] init];
        self.userIDnumbero = [singleton IDstring];
        
       // NSArray *myVCS;
        myVCS = [self viewControllers];
        NSArray *masterArray;
        NSArray *masterArray2;
        masterArray = [[myVCS objectAtIndex:0] viewControllers];
        masterArray2 = [[myVCS objectAtIndex:1] viewControllers];
       
        [[masterArray objectAtIndex:0]setDetail:self.userIDnumbero];
        loadViewOK = YES;
        [self viewDidLoad];
  
        
    }

    //Here we initialize the popup SIGN IN screen
    if (signedIn == NO) {
        
        self.userIDnumbero = nil;
     //   [self viewDidLoad];
        
        [self whatshappening];
        
    /*
        
        [self presentViewController:signIn animated:YES completion: nil];
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
    window.rootViewController = signIn;
   
    
        self.signedIn = YES;
    
    */
  
    }
}

-(void)setIDinMaster:(NSString*)string;{
    
    [[self.viewControllers firstObject] setUserIDnumero:string];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
