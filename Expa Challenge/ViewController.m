//
//  ViewController.m
//  Expa Challenge
//
//  Created by Zachary Nagengast on 12/26/13.
//  Copyright (c) 2013 Zauce Tech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize idText, fbPhoto, timeLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //attach function to idText when the value changes
    [idText addTarget:self
                    action:@selector(updatePhoto:)
          forControlEvents:UIControlEventEditingChanged];
    
    //start with textfield selected
    [idText becomeFirstResponder];
    
    //make image pretty
    fbPhoto.layer.masksToBounds = YES;
    fbPhoto.layer.cornerRadius = 10;
}

-(IBAction)updatePhoto:(id)sender{
    if (timer) {
        [timer invalidate];
    }
    //time how long it takes to load in ms
    startTime = [[NSDate date] timeIntervalSince1970];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:self
                                   selector:@selector(warmUpTime)
                                   userInfo:nil
                                    repeats:YES];
    [loading setHidden:false];
    [fbPhoto setHidden:true];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        //request the photo asynchronously
        NSURL *requestUrl = [NSURL URLWithString:[NSString stringWithFormat: @"https://graph.facebook.com/%@/picture", idText.text]];
        NSData *photoData = [NSData dataWithContentsOfURL:requestUrl];
        
        //stop the warmup timer
        [timer invalidate];
        
        //switch back to the main queue to update the UI
        dispatch_async( dispatch_get_main_queue(), ^{
            
            // show the photo
            fbPhoto.image = [UIImage imageWithData:photoData];
            [fbPhoto setHidden:false];
            [loading setHidden:true];
        });
    });
}

-(void)warmUpTime{
    //show warm up time in seconds
    [timeLabel setText:[NSString stringWithFormat:@"Load Time: %1.2f",([[NSDate date] timeIntervalSince1970] - startTime)]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
