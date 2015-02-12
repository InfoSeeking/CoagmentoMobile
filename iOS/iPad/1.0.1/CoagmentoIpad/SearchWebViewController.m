//
//  SearchWebViewController.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/25/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "SearchWebViewController.h"

@interface SearchWebViewController ()

@end

@implementation SearchWebViewController
@synthesize webView;



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
    
    NSString *URL = _detailItem;
    return URL;
    
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
