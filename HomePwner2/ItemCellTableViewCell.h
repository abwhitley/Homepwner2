//
//  ItemCellTableViewCell.h
//  HomePwner2
//
//  Created by Austins Work on 9/22/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCellTableViewCell : UITableViewCell
@property (nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (nonatomic) IBOutlet UILabel *valueLabel;


- (void)updateLabels;
@end
