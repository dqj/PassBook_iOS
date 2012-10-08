//
//  PassBookViewController.h
//  PassBook
//
//  Created by dqj on 12-8-10.
//  Copyright (c) 2012年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PassKit/PKAddPassesViewController.h>
@interface PassBookViewController : UIViewController<PKAddPassesViewControllerDelegate>
{
    IBOutlet UIButton *add;
}
@property(nonatomic,retain)IBOutlet UIButton*add;
-(IBAction)add:(id)sender;
@end
