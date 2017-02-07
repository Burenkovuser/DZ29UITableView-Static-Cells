//
//  SettingsViewController.m
//  DZ29UITableView Static Cell
//
//  Created by Vasilii on 06.02.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

// Ключи, под которыми будем хранить соответствующие значения полей (k от слова ключ)
static NSString* kSettingsName          = @"Name";
static NSString* kSettingsLastname      = @"Lastname";
static NSString* kSettingsLogin         = @"Login";
static NSString* kSettingsPassword      = @"Password";
static NSString* kSettingsAge           = @"Age";
static NSString* kSettingsPhoneNumber   = @"PhoneNumber";
static NSString* kSettingsEmail         = @"Email";
static NSString* kSettingsSubscribe     = @"Subscribe";
static NSString* kSettingsReceivingNews = @"ReceivingNews";
static NSString* kSettingsNewsAmount    = @"NewsAmount";

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Save and load

-(void) saveSettings {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];//это синглтон поэтому инициализируюется через standardUserDefaults
    
    // Кладем значения, которые хотим сохранить после перезапуска, под соответствующими ключами
    [userDefaults setObject:[[self.mainTextField objectAtIndex:0] text] forKey:kSettingsName];//берем проперти поле по индексу, тексту, ключу
    [userDefaults setObject:[[self.mainTextField objectAtIndex:1] text] forKey:kSettingsLastname];
    
    [userDefaults setObject:[[self.mainTextField objectAtIndex:2] text] forKey:kSettingsLogin];
    
    [userDefaults setObject:[[self.mainTextField objectAtIndex:3] text] forKey:kSettingsPassword];
    
    [userDefaults setObject:[[self.mainTextField objectAtIndex:4] text] forKey:kSettingsAge];
    
    [userDefaults setObject:[[self.mainTextField objectAtIndex:5] text] forKey:kSettingsPhoneNumber];
    
    [userDefaults setObject:[[self.mainTextField objectAtIndex:6] text] forKey:kSettingsEmail];
    
    [userDefaults setBool:self.subscribeSwitch.isOn forKey:kSettingsSubscribe];//для переключателя контрола BOOL
    
    [userDefaults setInteger:self.receivingNewsControl.selectedSegmentIndex forKey:kSettingsReceivingNews]; //для сегмента инт
    
    [userDefaults setDouble:self.newsPerDaySlider.value forKey:kSettingsNewsAmount];//для сайдера дабл
    
      [userDefaults synchronize]; // значения будут сохраняться даже после вылета приложения
   
}

#pragma mark - Actions
- (IBAction)textFieldAction:(UITextField *)sender {
}
- (IBAction)actionTextFieldChanged:(UITextField *)sender {
}

- (IBAction)subscriptionActions:(id)sender {
}
@end
