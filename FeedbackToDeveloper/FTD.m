//
//  FTD.m
//  FeedbackToDeveloper
//
//  Created by Влад Калаев on 21/07/2019.
//  Copyright © 2019 Vlad Kalaev. All rights reserved.
//

#import "FTD.h"

@interface FTD ()

@property (strong, nonatomic) NSString *versionAndBuild;

@end

@implementation FTD

- (instancetype)init {
    
    self = [super init];
    if ( self )
    {
        self.versionAndBuild = [NSString stringWithFormat:@"AppVersion%@Build%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
        
    }
    return self;
    
}

- (void)sendMail { // добавить yandex.mail mail.ru
    
    NSMutableDictionary *mails = [NSMutableDictionary new];
    
    mails[@"spark"] = @0;
    mails[@"gmail"] = @0;
    mails[@"mailApple"] = @0;
    mails[@"outlook"] = @0;
    
    if ([[UIApplication sharedApplication] canOpenURL:[self gmail]])
    {
        [mails setValue:@1 forKey:@"gmail"];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[self spark]])
    {
        [mails setValue:@1 forKey:@"spark"];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[self outlook]])
    {
        [mails setValue:@1 forKey:@"outlook"];
    }
    if([[UIApplication sharedApplication] canOpenURL:[self mailApple]])
    {
        [mails setValue:@1 forKey:@"mailApple"];
    }
    else
    {
        NSLog(@" нет почтового клиента  ");
    }
    
    [self actionSheetConfiguratiorWithConfigurator:mails];
}

- (void)actionSheetConfiguratiorWithConfigurator:(NSDictionary *)configurator {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Выберите почтовый клиент"
                                                                         message:nil
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    if ([[configurator valueForKey:@"gmail"] isEqual:@1]) {
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gmail" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[self gmail] options:@{} completionHandler:nil];
        }]];
    }
    
    if ([[configurator valueForKey:@"outlook"] isEqual:@1]) {
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Outlook" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[self outlook] options:@{} completionHandler:nil];
        }]];
    }
    
    
    if ([[configurator valueForKey:@"spark"] isEqual:@1]) {
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Spark" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[self spark] options:@{} completionHandler:nil];
        }]];
        
    }
    
    if ([[configurator valueForKey:@"mailApple"] isEqual:@1]) {
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Почта" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[self mailApple] options:@{} completionHandler:nil];
        }]];
        
    }
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:^{ }];
    }]];
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:actionSheet animated:YES completion:nil];
    
}

#pragma mark - URL configuration

- (NSURL*)gmail {
    NSString *customURLGmail = [NSString
                                stringWithFormat:@"googlegmail:///co?to=developer@mail.ru,developer1@mail.ru&subject=%@&body=",
                                self.versionAndBuild];
    NSURL *urlGmail = [[NSURL alloc] initWithString:customURLGmail];
    return urlGmail;
}

- (NSURL*)spark {
    NSString *customURLSpark = [NSString
                                stringWithFormat:@"readdle-spark://compose?subject=%@&body=&recipient=developer@mail.ru,developer1@mail.ru",
                                self.versionAndBuild];
    NSURL *urlSpark = [[NSURL alloc] initWithString:customURLSpark];
    return urlSpark;
}

- (NSURL*)outlook {
    NSString *customURLOutlook = [NSString
                                  stringWithFormat:@"ms-outlook://compose?to=developer@mail.ru,developer1@mail.ru&subject=%@&body=",
                                  self.versionAndBuild];
    NSURL *urlOutlook = [[NSURL alloc] initWithString:customURLOutlook];
    return urlOutlook;
}

- (NSURL*)mailApple {
    NSString *customURLOutlook = [NSString
                                  stringWithFormat:@"mailto:developer@mail.ru,developer1@mail.ru?subject=%@",
                                  self.versionAndBuild];
    NSURL *urlOutlook = [[NSURL alloc] initWithString:customURLOutlook];
    return urlOutlook;
}

@end
