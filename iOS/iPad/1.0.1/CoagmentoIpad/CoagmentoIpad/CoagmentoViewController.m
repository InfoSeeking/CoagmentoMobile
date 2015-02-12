//
//  CoagmentoViewController.m
//  CoagmentoIpad
//
//  Created by Josue Reyes on 10/8/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "CoagmentoViewController.h"
#import "SignIn.h"
#import "SplitViewControl.h"
#import "IDsingleton.h"


@interface CoagmentoViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation CoagmentoViewController
@synthesize myDelegatee = _myDelegatee;


@synthesize userIDnum, ProjID, ProjTitle, customizableViewControllers, Key, myannotations, mycspace, mymembers, mysearches, mysnippets, mywebpages, storyboard, signIn;

#pragma mark - Managing the detail item

 
-(id)getUserID{
    return userIDnum;
}

- (IBAction)logOut:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Log out of Coagmento?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [actionSheet showInView:self.view];

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex ==1){

        [self logOut];
       
    }
    
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
    
  
}



- (void)viewDidLoad
{
    [self.navigationItem setHidesBackButton:YES animated:NO];


    self.navigationItem.title = ProjTitle;
  
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

-(void)passDataToTabs{
    
    NSMutableArray *detailArrayCheck = [self getDetailArray];
    
    if ([detailArrayCheck count] > 0){
        [[[self viewControllers] objectAtIndex:0] setDetailItem:[self getDetailArray]];
        [[[self viewControllers] objectAtIndex:1] setDetailItem:[self getDetailArray]];
        [[[self viewControllers] objectAtIndex:2] setDetailItem:[self getDetailArray]];
        [[[self viewControllers] objectAtIndex:3] setDetailItem:[self getDetailArray]];
        [[[self viewControllers] objectAtIndex:4] setDetailItem:[self getDetailArray]];
    }

    [[self selectedViewController] viewDidLoad];

   

    self.navigationItem.title = ProjTitle;

    
}
-(void)setCSpaceImages:(NSMutableArray *)images{
    
    
}

-(NSMutableArray *)getDetailArray{
    NSMutableArray * array = [[NSMutableArray alloc] initWithObjects:ProjID, ProjTitle, Key, nil];
    return array;
    
}




-(void)setDetail:(NSMutableArray *)detail{
    ProjTitle = [detail objectAtIndex:0];
    ProjID = [detail objectAtIndex:1];
    Key = [detail objectAtIndex:2];
    [self passDataToTabs];
    [self viewDidLoad];
}

-(id)getProjTitle{
    return ProjTitle;
}

-(id)getProjID{
    return ProjID;
}

-(id)getKey{
    return Key;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Master Detail Delegate

-(void)masterAction:(id)sender{
    
    [self setDetailItem:sender];
}

-(NSString *)getMeTheID{
    
    return self.userIDnum;
}

#pragma mark - Split view


-(void)logOut{

    id obj = self.splitViewController;
    id controllers = self.viewControllers;
    id cspacecontroller = [controllers objectAtIndex:0];
    [cspacecontroller setDetailItem:nil];
    
    [obj clearCMVC];
    [cspacecontroller removeNaughtyLingeringCells];
    
    
    [obj logOuttt];
    
 
}


- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Projects", @"Projects");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}



- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}


@end
