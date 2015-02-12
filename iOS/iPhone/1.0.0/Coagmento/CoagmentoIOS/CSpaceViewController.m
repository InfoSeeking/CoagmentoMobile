//
//  CSpaceViewController.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/15/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "CSpaceViewController.h"


@interface CSpaceViewController ()

@end

@implementation CSpaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      

    }
    return self;
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:NO];
}



- (void)viewDidLoad
{

    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CSpaceAll:(id)sender {
}

- (IBAction)Bookmarks:(id)sender {
}

- (IBAction)Snippets:(id)sender {
}

- (IBAction)Webpages:(id)sender {
}

- (IBAction)Annotations:(id)sender {
}

- (IBAction)Searches:(id)sender {
}
@end
