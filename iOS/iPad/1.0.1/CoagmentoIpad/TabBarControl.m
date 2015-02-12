//
//  TabBarControl.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/22/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "TabBarControl.h"

@interface TabBarControl ()


@end

@implementation TabBarControl;
@synthesize ProjID, ProjTitle, customizableViewControllers, Key, myannotations, mycspace, mymembers, mysearches, mysnippets, mywebpages;

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
    [super viewDidLoad];
    
    
    [self.navigationItem setHidesBackButton:NO animated:NO];
	// Do any additional setup after loading the view.
    self.navigationItem.title = ProjTitle;
    
    [[self viewControllers] objectAtIndex:0];
    [[[self viewControllers] objectAtIndex:1] setDetailItem:[self getDetailArray]];
    [[[self viewControllers] objectAtIndex:2] setDetailItem:[self getDetailArray]];
    [[[self viewControllers] objectAtIndex:3] setDetailItem:[self getDetailArray]];
    [[[self viewControllers] objectAtIndex:4] setDetailItem:[self getDetailArray]];
    
    
    /*
    UIImage* cspace1 = [UIImage imageNamed:@"cs_space copy.png"];
    UIImage* cspace2 = [UIImage imageNamed:@"cs_space_blue copy.png"];
    
    UIImage* collection1 = [UIImage imageNamed:@"collections copy.png"];
    UIImage* collection2 = [UIImage imageNamed:@"collections_blu copy.png"];
    
    UIImage* members1 = [UIImage imageNamed:@"members copy.png"];
    UIImage* members2 = [UIImage imageNamed:@"members_blu copy.png"];
    
    UIImage* searches1 = [UIImage imageNamed:@"searches copy.png"];
    UIImage* searches2 = [UIImage imageNamed:@"searches_blu copy.png"];
    
    UIImage* webpages1 = [UIImage imageNamed:@"web_pages copy.png"];
    UIImage* webpages2 = [UIImage imageNamed:@"web_pages_blu copy.png"];

    
   [[[self viewControllers] objectAtIndex:0] initWithTitle:@"CSpace" image:cspace1 selectedImage:cspace2];
   [[[self viewControllers] objectAtIndex:1] initWithTitle:@"Webpages" image:webpages1 selectedImage:webpages2];
    [[[self viewControllers] objectAtIndex:2] initWithTitle:@"Searches" image:searches1 selectedImage:searches2];
    [[[self viewControllers] objectAtIndex:3] initWithTitle:@"Collection" image:collection1 selectedImage:collection2];
    [[[self viewControllers] objectAtIndex:4] initWithTitle:@"Members" image:members1 selectedImage:members2];
  */
   
    
    
    //DID WE PASS IN THE PROJECT OBJECT FROM HOME?
    NSLog(@"PROJECT NAME: %@",ProjTitle);
    
    
}
     
     
-(NSMutableArray *)getDetailArray{
    NSMutableArray * array = [[NSMutableArray alloc] initWithObjects:ProjID, ProjTitle, nil];
    return array;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setDetail:(NSMutableArray *)detail{
    ProjTitle = [detail objectAtIndex:0];
    ProjID = [detail objectAtIndex:1];
}

-(id)getProjTitle{
    return ProjTitle;
}

-(id)getProjID{
    return ProjID;
}



@end
