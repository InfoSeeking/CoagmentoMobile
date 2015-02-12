//
//  SignUpWebView.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 10/15/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "SignUpWebView.h"

@interface SignUpWebView ()

@end

@implementation SignUpWebView

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
    NSString *urlString = @"http://www.coagmento.org/mobile/signup.php";
    
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
