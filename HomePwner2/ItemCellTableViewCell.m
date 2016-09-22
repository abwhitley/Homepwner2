//
//  ItemCellTableViewCell.m
//  HomePwner2
//
//  Created by Austins Work on 9/22/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

#import "ItemCellTableViewCell.h"

@implementation ItemCellTableViewCell
- (void)updateLabels {
    UIFont *bodyFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.nameLabel.font = bodyFont;
    self.valueLabel.font = bodyFont;
    UIFont *captionFont = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    self.serialNumberLabel.font = captionFont;
}

@end
