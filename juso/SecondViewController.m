//
//  SecondViewController.m
//  juso
//
//  Created by jungho jang on 12. 1. 13..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController
@synthesize addressListTable;
@synthesize filePath;
@synthesize addressData;
@synthesize dict;
@synthesize editBtn;



-(NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:saveFile];
}

- (IBAction)editTable:(id)sender {
    [addressListTable setEditing:!addressListTable.editing animated:YES];
    
    
    if (addressListTable.editing) {
        //[editBtn setTitle:@"Done" forState:0];
        [editBtn setTitle:@"완료"];
    }else{
        [editBtn setTitle:@"수정"];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = NSLocalizedString(@"Second", @"Second");
        self.title = @"즐겨찾기";
        self.tabBarItem.image = [UIImage imageNamed:@"navi02"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    filePath = [[NSString alloc] initWithFormat:@"%@",[self dataFilePath]];
    dict = [[NSMutableDictionary alloc] init];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg01.png"]];
    
    imageView.alpha = 0.8f;
    [addressListTable setBackgroundView:imageView];
}

- (void)viewDidUnload
{
    [self setAddressListTable:nil];
    [self setFilePath:nil];
    [self setEditBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        addressData = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        [addressListTable reloadData];
    }else{
        
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [addressData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    

    // Configure the cell...
    dict = [addressData objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"oldAddress"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.detailTextLabel.text = [dict objectForKey:@"newAddress"];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:13];

    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    [addressData removeObjectAtIndex:row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [[NSFileManager defaultManager] removeItemAtPath:[self dataFilePath] error:nil];
    [addressData writeToFile:[self dataFilePath] atomically:YES];
    
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller. 
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    dict = [addressData objectAtIndex:indexPath.row];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:[dict objectForKey:@"newAddress"]
                                                   delegate:self
                                          cancelButtonTitle:@"확인"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
