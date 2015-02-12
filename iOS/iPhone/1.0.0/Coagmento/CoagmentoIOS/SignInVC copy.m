//
//  SignInVC.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 7/16/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "SignInVC.h"



@interface SignInVC ()

@end

@implementation SignInVC
@synthesize PasswordInput;
@synthesize UserNameInput;

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
     NSLog(@"SignIn-viewdidload");
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [UserNameInput becomeFirstResponder];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SignInClick:(id)sender {
    
    //here we collect both username and password and put them into strings so that they can later be parsed
    NSString *username = [[NSString alloc] initWithFormat:@"%@", [UserNameInput text]];
    NSString *password = [[NSString alloc] initWithFormat:@"%@", [PasswordInput text]];
    
    //here we tell the text fields to resign first responder and dismiss keyboard
    [UserNameInput resignFirstResponder];
    [PasswordInput resignFirstResponder];
    
    
}

- (IBAction)dissmissKeyboard:(id)sender {
    [UserNameInput resignFirstResponder];
    [PasswordInput resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ( [textField isEqual: UserNameInput] )
    {
        [UserNameInput resignFirstResponder];
        [PasswordInput becomeFirstResponder];
        return NO;
    }
    
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -70; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
