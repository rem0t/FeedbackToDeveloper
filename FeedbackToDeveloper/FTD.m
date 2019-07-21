//
//  FTD.m
//  FeedbackToDeveloper
//
//  Created by Влад Калаев on 21/07/2019.
//  Copyright © 2019 Vlad Kalaev. All rights reserved.
//

#import "FTD.h"
#import <MessageUI/MessageUI.h>


@interface FTD () <MFMailComposeViewControllerDelegate>

@end

@implementation FTD

- (void)sendMail:(UIViewController *)vc { // добавить yandex.mail mail.ru
    
    NSString *versionAndBuild = [NSString stringWithFormat:@"AppVersion%@Build%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
    NSString *customURLGmail = [NSString stringWithFormat:@"googlegmail:///co?to=developer@indoorsnavi.pro,kalaev@indoorsnavi.pro&subject=%@&body=",versionAndBuild];
    NSString *customURLSpark = [NSString stringWithFormat:@"readdle-spark://compose?subject=%@&body=&recipient=developer@indoorsnavi.pro,kalaev@indoorsnavi.pro",versionAndBuild];
    NSString *customURLOutlook = [NSString stringWithFormat:@"ms-outlook://compose?to=developer@indoorsnavi.pro,kalaev@indoorsnavi.pro&subject=%@&body=",versionAndBuild];
    
//    if([MFMailComposeViewController canSendMail]) {
//
//        MFMailComposeViewController* composeMail = [[MFMailComposeViewController alloc] init];
//        composeMail.mailComposeDelegate = self;
//
//        [composeMail setToRecipients:@[@"developerMail@mail.com",@"testerMail@mail.com"]];
//
//        [composeMail setSubject:versionAndBuild];
//
//        [vc presentViewController:composeMail animated:YES completion:nil];
//
//    } else
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:customURLGmail]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURLGmail] options:@{} completionHandler:nil];
    }
    else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:customURLSpark]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURLSpark] options:@{} completionHandler:nil];
    }
    else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:customURLOutlook]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURLOutlook] options:@{} completionHandler:nil];
    }
    else
    {
        [self presentAlertControllerShowAppMailWithTitle:@"" message:@""]; //NSLocalizedString(@"letter", nil)
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    NSString *strError = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"badSendMail", nil),[error localizedDescription]];
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            
            [self presentAlertControllerWithTitle:NSLocalizedString(@"goodUser", nil) message:nil];
            
            break;
        case MFMailComposeResultFailed:
            
            [self presentAlertControllerWithTitle:strError message:nil];
            
            break;
        default:
            break;
    }
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:NULL];
}

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
    
    [UIView animateWithDuration:0 delay:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
    } completion:^(BOOL finished) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
    }];
}

- (void)presentAlertControllerShowAppMailWithTitle:(NSString *)title message:(NSString *)message {
    
    [UIView animateWithDuration:0 delay:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
    } completion:^(BOOL finished) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Показать в App Store" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self openAppSoreMail];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Отменить" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
    }];
}

- (void)openAppSoreMail {
    
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/ru/app/%D0%BF%D0%BE%D1%87%D1%82%D0%B0/id1108187098?mt=8"];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}


@end
