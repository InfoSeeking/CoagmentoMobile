//
//  SignInVC.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 7/16/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "SignInVC.h"
#import "ID.h"

@interface SignInVC ()
//+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

@implementation SignInVC
@synthesize PasswordInput;
@synthesize UserNameInput;


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    
    //here we pass the USERID num to the next controller
    

     if ([self signupClicked] == NO) {

        CoagmentoViewController *dest = (CoagmentoViewController *)[segue destinationViewController];
       dest.Key= _userIDnum;
        dest.userIDnum = _userIDnum;
         
         
        
    }
    else {
        [self setSignupClicked:NO];
    }
    
   }

-(void)saveString:(NSString*)
    myString
{
    [[NSUserDefaults
      standardUserDefaults]
      setObject:myString
      forKey:@"String"];
     }


-(void)segue{
    if ([self correctCredentials] == YES) {
        [self performSegueWithIdentifier:@"toTabBar" sender:self];
        [self setCorrectCredentials:NO];
    }
   
}

- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}



- (IBAction)SignUp:(id)sender {
    
    [self setSignupClicked:YES];
    [self segue];
    
}

- (IBAction)loginClicked:(id)sender {
    
    if([[UserNameInput text] isEqualToString:@""] || [[PasswordInput text] isEqualToString:@""] ) {
        [self alertStatus:@"Please enter both a username and password." :nil];
        
    }else{
        [self fetchEntries];
    }
    
                    [self segue];

      NSLog(@"ID NUMBER: %@ ", [self userIDnum]);
      [UserNameInput resignFirstResponder];
      [PasswordInput resignFirstResponder];
    
    //clear text fields
      UserNameInput.text=@"";
      PasswordInput.text=@"";
     
}

-(void)fetchEntries {
   spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(155, 275)]; // I do this because I'm in landscape mode
    [self.view addSubview:spinner];
    [spinner startAnimating];
    NSString *urlString =[[NSString alloc] initWithFormat:@"http://www.coagmento.org/mobile/login.php?userName=%@&password=%@",[UserNameInput text],[PasswordInput text]];
    NSLog(@"URL: %@",urlString);

    xmlData = [[NSMutableData alloc]init];
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    connection = [[NSURLConnection alloc]initWithRequest:req delegate:self startImmediately:YES];
   
}

#pragma mark Connection


-(void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)error{
    connection = nil;
    xmlData = nil;
    
    [spinner stopAnimating];
    
    NSString *errorString = [NSString stringWithFormat:@"Make sure you have Internet access and try again."];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Connection Failed"
                                                        message:errorString
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [av show];

}

-(void)connection:(NSURLConnection *) conn didReceiveData:(NSData *)data{
    //add incoming chunks of data to the container
    [xmlData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)conn{
    //xmlCheck
    NSString *xmlCheck = [[NSString alloc]initWithData:xmlData encoding:NSUTF8StringEncoding];
    
    NSLog(@"xmlcheck: %@", xmlCheck);
    [self setWorking:YES];
    
    // Create the parser object with the data received from the web service
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    
    // Give it a delegate
    [parser setDelegate:self];
    
    // Tell it to start parsing - the document will be parsed and
    // the delegate of NSXMLParser will get all of its delegate messages
    // sent to it before this line finishes execution - it is blocking
    [parser parse];
    
    // Get rid of the XML data as we no longer need it
    xmlData = nil;
    
    // Get rid of the connection, no longer need it
    connection = nil;
    
    [spinner stopAnimating];
    
}

#pragma mark Parser

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
   
     
       if ([elementName isEqualToString:@"login"]) {
    
           if([elementName isEqualToString:@"userID"]){
               currentKey = @"userID";
//              return; 
           }
           
       }
    
}


-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    
    if ([self working]) {
        NSLog(@"STRING: %@",string);
        if (currentNum || !currentNum){
            currentNum = string;
            NSLog(@"KEY: %@", currentNum);
            [self setUserIDnum:string];
            [self setWorking: NO];
         
            
#pragma mark Password and Username Validation
            //HERE WE CHECK IF USER ID NUMBER IS VALID
            
            if ([_userIDnum isEqualToString:@"0"]) {
                [self alertStatus:@"That username or password is incorrect." :nil];
                [self setCorrectCredentials:NO];
                connection = nil;
                xmlData = nil;
                currentNum = nil;
                
                //clear text fields
                UserNameInput.text=@"";
                PasswordInput.text=@"";
            }
            else{
                ID *key = [[ID alloc]init];
                
                [key setUserIDnumber:_userIDnum];
                [self saveString:self.userIDnum];
                [self setCorrectCredentials:YES];
                [self segue];
                
            }
      }
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
   
    if ([elementName isEqual:@"userID"]){
        return;
    }

}

#pragma mark Initializations

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [UserNameInput becomeFirstResponder];
    }
    return self;
}

- (void)viewDidLoad
{
        
        [super viewDidLoad];
   	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
   // [super viewWillAppear:animated];
    //  [self initWithStyle:UITableViewStylePlain];
    
    
//    self.navigationController.navigationBarHidden = YES;
    
}

  


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)dissmissKeyboard:(id)sender {
    [UserNameInput resignFirstResponder];
    [PasswordInput resignFirstResponder];
    
}

#pragma mark Keyboard Attributes


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ( [textField isEqual: UserNameInput] )
    {
        [UserNameInput resignFirstResponder];
        [PasswordInput becomeFirstResponder];
        return NO;
    }
    
    else if ([textField isEqual:PasswordInput]){
        [self loginClicked:self];
        
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
    const float movementDuration = 0.25f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
