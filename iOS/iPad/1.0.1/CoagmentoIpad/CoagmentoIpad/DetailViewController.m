//
//  DetailViewController.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/24/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item



- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

-(void)segue{
    
    [self performSegueWithIdentifier:@"showWebView" sender:self];
}

- (IBAction)toWebView:(id)sender {
    [self segue];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showWebView"]) {
        
       NSString *url = [[self detailItem] objectAtIndex:2];
        
        [segue.destinationViewController setDetailItem:url];
    }
}


- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
      NSString *title =  [[self detailItem] objectAtIndex:0]; //title
      NSString *content =  [[self detailItem] objectAtIndex:1]; //content
      NSString *note =  [[self detailItem] objectAtIndex:3]; //note
        NSString *date = [[self detailItem]objectAtIndex:4];
        
        self.detailDate.text = date;
        self.detailNote.text = note;
        self.detailTitle.text = title;
        self.detailDescriptionLabel.text = content;
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
