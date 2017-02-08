//
//  SettingsViewController.m
//  DZ29UITableView Static Cell
//
//  Created by Vasilii on 06.02.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property(assign, nonatomic) int currentNumberOfField;

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
    for (UITextField *field in self.mainTextField) {
        field.delegate = self;
    }

    
   [[self.mainTextField objectAtIndex:0] becomeFirstResponder];
    
   [self loadSettings];// загружаем настройки!!! Здесь падает!!!
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Save and load

-(void) saveSettings {//без этого метода работает
    
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

- (void) loadSettings {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    // Ставим сохраненные значения под соответствующими полями.
    
    [[self.mainTextField objectAtIndex:0] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kSettingsName]]];
    
    [[self.mainTextField objectAtIndex:1] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kSettingsLastname]]];
    
    [[self.mainTextField objectAtIndex:2] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kSettingsLogin]]];
    
    [[self.mainTextField objectAtIndex:3] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kSettingsPassword]]];
    
    [[self.mainTextField objectAtIndex:4] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kSettingsAge]]];
    
    [[self.mainTextField objectAtIndex:5] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kSettingsPhoneNumber]]];
    
    [[self.mainTextField objectAtIndex:6] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kSettingsEmail]]];
    
    self.subscribeSwitch.on = [userDefaults boolForKey:kSettingsSubscribe];
    
    self.receivingNewsControl.selectedSegmentIndex = [userDefaults integerForKey:kSettingsReceivingNews];
    
    self.newsPerDaySlider.value = [userDefaults doubleForKey:kSettingsNewsAmount];
    
    
    
    self.newsCounLabel.text = [NSString stringWithFormat:@"%1.0f", self.newsPerDaySlider.value];

}

#pragma mark - My metods

-(void)setStandartLabels:(UITextField*) textField withConter:(int) counter {//метод ставит лейблы по умолчанию, если в соответсвующий textfield ничего не написано, т.е. длина текста равна 0
    
    if ([textField.text length] == 0) {
        switch (counter) {
            case 0:
                [[self.mainLabels objectAtIndex:0] setText:@"Name"];
                break;
            case 1:
                [[self.mainLabels objectAtIndex:1] setText:@"Lastname"];
                break;
            case 2:
                [[self.mainLabels objectAtIndex:2] setText:@"Login"];
                break;
            case 3:
                [[self.mainLabels objectAtIndex:3] setText:@"Pasword"];
                break;
            case 4:
                [[self.mainLabels objectAtIndex:4] setText:@"Age"];
                break;
            case 5:
                [[self.mainLabels objectAtIndex:5] setText:@"Phone"];
                break;
            case 6:
                [[self.mainLabels objectAtIndex:6] setText:@"E-mail"];
                break;
                
            default:
                break;
        }
    }
}


#pragma mark - UITxetFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.mainTextField.lastObject]) {
        [textField resignFirstResponder];
    }else{
        //[[self.mainTextField objectAtIndex:self.currentNumberOfField] resignFirstResponder];//клавиатура уезжает
        [[self.mainTextField objectAtIndex:[self.mainTextField indexOfObject:textField] + 1] becomeFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField { // метод запрещает редактирование
    self.currentNumberOfField = (int)[self.mainTextField indexOfObject:textField]; // индекс поля в массиве по которому кликнули
    for (int i = 0; i < [self.mainTextField count]; i++) {
        if ([[[self.mainTextField objectAtIndex:i]text] length] == 0) {
            
            [self setStandartLabels:[self.mainTextField objectAtIndex:i] withConter:i];
        }
        
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {//метод вызывается при нажатии clear button
    textField.text = @"";
    [self setStandartLabels:textField withConter:self.currentNumberOfField];
    //так же выставляет умолчание
    return NO;
}

//проверяю на ошибку
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {//вызывается перед тем как мы добавляем символ
    
    
    if ([textField isEqual:[self.mainTextField objectAtIndex:5]]) {
        int i = (int)[self.mainTextField indexOfObject:textField];
        
        NSString* checkSring = [textField.text stringByAppendingString:string];
        if ([string length] != 1) {
            checkSring = [checkSring substringToIndex:[checkSring length] -1];
        }
        NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];//все отличное от цифр чтобы не поподало в набор
        NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) {
            return NO;
        }
        NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];//создаем строку
        
        //+XX (XXX) XXX-XXXX
        
        NSArray* validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];//компоненты при разделении
        
        newString = [validComponents componentsJoinedByString:@""];//соеденяем пустым символом
        
        // XXXXXXXXXXXX
        NSMutableString* resultString = [NSMutableString string];
        
        static const int localNumberMaxLength = 7;//создаем константу для общей длины
        static const int areaCodeMaxLength = 3;
        static const int countryCodeMaxLength = 3;
        // Делаем локальный номер (ХХХ-ХХХХ)
        NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);//для номера
        
        if (localNumberLength > 0) {
            
            NSString* number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
            
            [resultString appendString:number];//добавляем в наш результат
            
            if ([resultString length] > 3) {//если больше 3 цифр ставим разделитель
                [resultString insertString:@"-" atIndex:3];
            }
            
        }
        //делаем номер региона (ХХХ)
        if ([newString length] > localNumberMaxLength) {//для месного номера
            
            NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
            
            NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
            
            NSString* area = [newString substringWithRange:areaRange];
            
            area = [NSString stringWithFormat:@"(%@) ", area];//добавляем скобки
            
            [resultString insertString:area atIndex:0];
        }
        //Делаем номер страны (+ХХХ)
        if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {//для кода страны
            
            NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
            
            NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
            
            NSString* countryCode = [newString substringWithRange:countryCodeRange];
            
            countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
            
            [resultString insertString:countryCode atIndex:0];
        }
        if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
            return NO;
        }
        textField.text = resultString;
        
        [[self.mainTextField objectAtIndex:i] setText:resultString];
        
        return NO;
    }
    
    
    else if ([textField isEqual:[self.mainTextField objectAtIndex:6]]) {
        
        int i = (int)[self.mainTextField indexOfObject:textField];
        
        NSString* checkSring = [textField.text stringByAppendingString:string];
        if ([string length] != 1) {
            checkSring = [checkSring substringToIndex:[checkSring length] -1];
        }
        NSCharacterSet* aSet = [NSCharacterSet characterSetWithCharactersInString:@"@"];//набор с символом @
        NSCharacterSet* illegatSet = [NSCharacterSet characterSetWithCharactersInString:@" !#$%^&*()+={}[]№:;?/|~`"];
        NSArray* atCoomponents = [checkSring componentsSeparatedByCharactersInSet:aSet];
        NSArray* illegatComponents = [ checkSring componentsSeparatedByCharactersInSet:illegatSet];
        NSLog(@"illegatCompontns - %@", illegatSet);
        if ([atCoomponents count] > 2 || [illegatComponents count] > 1) {//собака вводится только один раз
            
            return NO;
        }
        [[self.mainLabels objectAtIndex:i] setText:checkSring];
        
        return [checkSring length] <= 19;//ограничение для поля email
    } else {
        //выаодим данные текстовых полей
        int i = (int)[self.mainTextField indexOfObject:textField];
        
        NSString* checkSring = [textField.text stringByAppendingString:string];
        
        if ([string length] != 1) {// условие удаление символа
            checkSring = [checkSring substringToIndex:[checkSring length] - 1];
        }
        [[self.mainLabels objectAtIndex:i] setText:checkSring];//меняем сиволы в лейбел
        
        return YES;
    }
}

#pragma mark - Actions

- (IBAction)actionTextChanged:(UITextField *)sender {
    [self saveSettings]; // сохраняем значения текстовых полей
}



- (IBAction)actionValueChanged:(id)sender {
    
    if ([sender isEqual:self.newsPerDaySlider]) {
        
        self.newsCounLabel.text = [NSString stringWithFormat:@"%1.0f", self.newsPerDaySlider.value];
        
    }
    
    [self saveSettings]; // сохраняем сюда значения слайдера, свитча и сегментед контрола.
    

}
@end
