//
//  DetailViewController.h
//  HomePwner2
//
//  Created by Austins Work on 9/22/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;
@class ImageStore;

@interface DetailViewController : UIViewController
@property (nonatomic) Item *item;
@property (nonatomic) ImageStore *imageStore;
@end
