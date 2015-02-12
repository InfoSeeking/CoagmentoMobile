//
//  SignIn.h
//  CoagmentoIpad
//
//  Created by Josue Reyes on 10/20/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDsingleton.h"

@protocol SecondDelegate <NSObject>
-(void) secondViewControllerDismissed:(NSString *)stringForFirst;
-(void) getKey:(NSString *)key;
-(NSString *)setKey;
@end



@interface SignIn : UIViewController<NSXMLParserDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    NSInteger *num;
    NSString *currentNum;
    NSString *currentKey;
    UIActivityIndicatorView *spinner;
    id myDelegate;
    IDsingleton *singleton;
    }

@property (nonatomic, assign) BOOL signupClicked;
@property (nonatomic, assign) BOOL working;
@property (nonatomic, assign) BOOL correctCredentials;
@property (nonatomic, weak) NSString *userIDnumber;
@property (weak, nonatomic) IBOutlet UITextField *UserNameInput;
@property (weak, nonatomic) IBOutlet UITextField *PasswordInput;
@property (nonatomic, weak) id <SecondDelegate> myDelegate;


- (IBAction)dissmissKeyboard:(id)sender;
- (IBAction)loginClicked:(id)sender;
-(void)fetchEntries;

@end
