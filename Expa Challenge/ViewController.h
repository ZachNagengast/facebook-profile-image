//
//  ViewController.h
//  Expa Challenge
//
//  Created by Zachary Nagengast on 12/26/13.
//  Copyright (c) 2013 Zauce Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    IBOutlet UIImageView *fbPhoto;
    IBOutlet UITextField *idText;
    IBOutlet UIActivityIndicatorView *loading;
    NSTimer *timer;
    IBOutlet UILabel *timeLabel;
    double startTime;
}

@property (nonatomic, retain) IBOutlet UIImageView *fbPhoto;
@property (nonatomic, retain) IBOutlet UITextField *idText;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;

-(IBAction)updatePhoto:(id)sender;

@end
