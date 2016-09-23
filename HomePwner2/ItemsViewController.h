//
//  ItemsViewController.h
//  HomePwner2
//
//  Created by Austins Work on 9/19/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemStore;
@class ImageStore;

@interface ItemsViewController : UITableViewController

@property (nonatomic) ItemStore *itemStore;
@property (nonatomic) ImageStore *imageStore;

@end
