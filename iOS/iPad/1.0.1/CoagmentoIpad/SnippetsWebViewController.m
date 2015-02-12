//
//  SnippetsWebViewController.m
//  CoagmentoIpad
//
//  Created by Josue Reyes on 11/5/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "SnippetsWebViewController.h"

@interface SnippetsWebViewController ()

@end

@implementation SnippetsWebViewController
@synthesize webView;


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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



@end
