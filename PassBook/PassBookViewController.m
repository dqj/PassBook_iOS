//
//  PassBookViewController.m
//  PassBook
//
//  Created by dqj on 12-8-10.
//  Copyright (c) 2012年 NetEase. All rights reserved.
//

#import "PassBookViewController.h"
#import <PassKit/PKPass.h>
#import <PassKit/PKPassLibrary.h>
#import <PassKit/PKAddPassesViewController.h>

@interface PassBookViewController ()

@end

@implementation PassBookViewController
@synthesize add;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}
-(IBAction)add:(id)sender
{
    /*
     To add a pass to the library:
     
     Use the isPassLibraryAvailable class method of the PKPassLibrary class to check that the pass library is available.
     Create an instance of the PKPass class for the pass, initializing it with the pass’s data.
     Use the containsPass: method of the PKPassLibrary class to check whether the pass is in the library. Your app can use this method to detect the presence of a pass, even if it doesn’t have the entitlements to read passes in the library.
     If the pass isn’t in the library, use an instance of the PKAddPassesViewController class to let the user add it.
    */
    if ([PKPassLibrary isPassLibraryAvailable]) {
        
        PKPassLibrary *passLibrary=[[PKPassLibrary alloc] init];
        
        NSArray *passes=[passLibrary passes];

        NSLog(@"%i",[passes count]);
        for (PKPass *pass in passes) {
            NSLog(@"%@,%@,%@,%@",[pass localizedDescription],[pass localizedName],[pass serialNumber],[pass relevantDate]);
        }
        //从本地文件中获得pkpass
        NSString *str=[[NSBundle mainBundle]pathForResource:@"example" ofType:@"pkpass"];
        NSData *data=[[NSData alloc] initWithContentsOfFile:str];
        
        NSError *error=nil;
        PKPass *pass=[[PKPass alloc] initWithData:data error:&error];

        if(!error){
            if(![passLibrary containsPass:pass]){
                PKAddPassesViewController *addPassVC=[[PKAddPassesViewController alloc] initWithPass:pass];
                //UIBarButtonItem *add=[[UIBarButtonItem alloc] initWithTitle:@"tianjia" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
                //[[self navigationItem] setBackBarButtonItem:add];
                //addPassVC.title=@"添加优惠卷";
                //addPassVC.navigationItem.title=@"tian";
                addPassVC.delegate=self;
                [self presentViewController:addPassVC animated:YES completion:^{}];
                
            }
            else{
                //如果存在与pass具有相同的passTypeIdentifier和serialNumber，那么就需要替换掉它
                [passLibrary replacePassWithPass:pass];
                //PKPass *passOri=[passLibrary passWithPassTypeIdentifier:[pass passTypeIdentifier] serialNumber:[pass serialNumber]];//查找某个pass
            }
        }
        else
            NSLog(@"%@",[error description]);
    }

}
-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addPassesViewControllerDidFinish:(PKAddPassesViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"here!");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
