//
//  BookmarkWebView.m
//  CoagmentoIpad
//
//  Created by Josue Reyes on 11/4/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "BookmarkWebView.h"

@interface BookmarkWebView ()

@end

@implementation BookmarkWebView
@synthesize webView;

- (IBAction)backButton:(id)sender {
    
    
}


-(id)getURL{
    
    return _detailItem;
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
