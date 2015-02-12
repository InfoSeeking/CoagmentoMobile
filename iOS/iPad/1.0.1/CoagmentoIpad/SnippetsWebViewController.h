//
//  SnippetsWebViewController.h
//  CoagmentoIpad
//
//  Created by Josue Reyes on 11/5/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnippetsWebViewController : UIViewController <UIWebViewDelegate>{
    UIWebView *webView;
    
}
@property (strong, retain) IBOutlet UIWebView *webView;


@property (strong, nonatomic) id detailItem;

@end
