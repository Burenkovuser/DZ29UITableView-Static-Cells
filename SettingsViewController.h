//
//  SettingsViewController.h
//  DZ29UITableView Static Cell
//
//  Created by Vasilii on 06.02.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *mainTextField;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *mainLabels;

@property (weak, nonatomic) IBOutlet UISwitch *subscribeSwitch;

@property (weak, nonatomic) IBOutlet UISegmentedControl *receivingNewsControl;

@property (weak, nonatomic) IBOutlet UISlider *newsPerDaySlider;

@property (weak, nonatomic) IBOutlet UILabel *newsCounLabel;

- (IBAction)actionTextChanged:(UITextField *)sender;

- (IBAction)actionValueChanged:(id)sender;

@end

