//
//  ViewController.m
//  FeedbackToDeveloper
//
//  Created by Влад Калаев on 21/07/2019.
//  Copyright © 2019 Vlad Kalaev. All rights reserved.
//

#import "ViewController.h"
#import "FTD.h"

@interface ViewController ()

- (IBAction)button:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)button:(id)sender {
  
    FTD *ftd = [FTD new];
    [ftd sendMail];
    
}

@end
