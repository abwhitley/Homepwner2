//
//  DetailViewController.m
//  HomePwner2
//
//  Created by Austins Work on 9/22/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

#import "DetailViewController.h"
#import "Item.h"

@interface DetailViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *serialNumberField;
@property (strong, nonatomic) IBOutlet UITextField *valueField;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end
@implementation DetailViewController
- (IBAction)backgroundTapped:(UITapGestureRecognizer *)sender {
        [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.nameField.text = self.item.name;
    self.serialNumberField.text = self.item.serialNumber;
    self.valueField.text =
    [[self valueFormatter] stringFromNumber:@(self.item.valueInDollars)];
    self.dateLabel.text = [[self dateFormatter] stringFromDate:self.item.dateCreated];
}
// MARK: - Formatters
- (NSNumberFormatter *)valueFormatter {
    static NSNumberFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSNumberFormatter new];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.minimumFractionDigits = 2;
        formatter.maximumFractionDigits = 2;
    });
    return formatter;
}
- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateStyle = NSDateFormatterMediumStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
    });
    return formatter;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // Clear the first responder
    [self.view endEditing:YES];
    // Update the item's properties from the text fields
    self.item.name = self.nameField.text;
    self.item.serialNumber = self.serialNumberField.text;
    NSNumber *numberInDollars = [[self valueFormatter] numberFromString:self.valueField.text];
    self.item.valueInDollars = numberInDollars.intValue;
}
// MARK: - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// MARK: - Accessors
- (void)setItem:(Item *)item {
    _item = item;
    self.navigationItem.title = item.name;
}


@end
