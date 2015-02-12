//
//  CSpacePopup.m
//  CoagmentoIpad
//
//  Created by Josue Reyes on 10/28/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "CSpacePopup.h"
#import "WebViewController.h"

@interface CSpacePopup ()

@end

@implementation CSpacePopup
@synthesize Time, Title, Type, URL, Date;

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
    }
}

-(void)segue{
    
    [self performSegueWithIdentifier:@"toWebView" sender:[self parentViewController]];
    
    
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toWebView"]) {
        
     
        NSString *detailitem = [[NSString alloc]init];
        detailitem = [[self detailItem] objectAtIndex:4];
        WebViewController *viewController = segue.destinationViewController;
        [viewController setDetailItem:detailitem];
    }
}


- (IBAction)dismissButton:(id)sender {
    

    [self dismissViewControllerAnimated:YES completion:NULL];

}
- (IBAction)goToLinkButton:(id)sender {
    [self segue];
   
    
}

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
    
    [Title setText: [[self detailItem] objectAtIndex:0]];
    [Type setText:[[self detailItem] objectAtIndex:1]];
    [URL setText:[[self detailItem] objectAtIndex:2]];
    [Date setText:[[self detailItem] objectAtIndex:3]];
    [Time setText:[[self detailItem] objectAtIndex:4]];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
