//
//  SignInVC.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 7/16/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectsTVC.h"
#import "CoagmentoViewController.h"



@interface SignInVC : UIViewController<NSXMLParserDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    NSInteger *num;
    NSString *currentNum;
    NSString *currentKey;
    UIActivityIndicatorView *spinner;
    
}

@property (nonatomic, assign) BOOL signupClicked;
@property (nonatomic, assign) BOOL working;
@property (nonatomic, assign) BOOL correctCredentials;
@property (nonatomic, weak) NSString *userIDnum;
@property (weak, nonatomic) IBOutlet UITextField *UserNameInput;
@property (weak, nonatomic) IBOutlet UITextField *PasswordInput;


- (IBAction)dissmissKeyboard:(id)sender;

- (IBAction)loginClicked:(id)sender;

-(void)fetchEntries;


@end