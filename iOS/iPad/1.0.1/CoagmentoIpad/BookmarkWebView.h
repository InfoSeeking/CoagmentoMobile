//
//  BookmarkWebView.h
//  CoagmentoIpad
//
//  Created by Josue Reyes on 11/4/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookmarkWebView : UIViewController<UIWebViewDelegate>{
    UIWebView *webView;
    
}
@property (strong, retain) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (strong, nonatomic) id detailItem;

@end
