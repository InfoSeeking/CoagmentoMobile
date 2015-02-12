//
//  WebViewController.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/24/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "WebViewController.h"


@interface WebViewController ()

@end

@implementation WebViewController
@synthesize webView;
- (IBAction)backButton:(id)sender {
 
    [self dismissViewControllerAnimated:YES completion:NULL];
  
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
    }
}


-(id)getURL{
    
    return _detailItem;
}



- (void)viewDidLoad
{
    NSString *urlString = [self getURL];
    
    NSURL *url = [NSURL URLWithString:urlString];
       
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestURL];
    
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
