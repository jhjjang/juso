//
//  CompanyInfoViewController.m
//  juso
//
//  Created by jungho jang on 12. 1. 27..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import "CompanyInfoViewController.h"

@interface CompanyInfoViewController ()

@end

@implementation CompanyInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Info";
        self.tabBarItem.image = [UIImage imageNamed:@"navi03"];
    }
    return self;
    
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
