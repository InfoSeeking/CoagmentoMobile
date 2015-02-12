//
//  SearchWebViewController.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/25/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchWebViewController: UIViewController <UIWebViewDelegate>{
    UIWebView *webView;
   
}


@property (strong, retain) IBOutlet UIWebView *webView;
@property (strong, nonatomic) id detailItem;

@end
