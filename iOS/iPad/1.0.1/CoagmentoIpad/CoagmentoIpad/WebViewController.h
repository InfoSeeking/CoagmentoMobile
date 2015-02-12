//
//  WebViewController.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/24/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WebViewControllerDelegate <NSObject>

-(void) done;

@end

@interface WebViewController : UIViewController <UIWebViewDelegate>{
    UIWebView *webView;
     id delegate;
}



@property (strong, retain) IBOutlet UIWebView *webView;
@property (strong, nonatomic) id detailItem;
//@property (nonatomic, assign) id<WebViewControllerDelegate> delegate;

//-(IBAction)done:(id)sender;

@end
