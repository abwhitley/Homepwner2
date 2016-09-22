//
//  ItemsViewController.m
//  HomePwner2
//
//  Created by Austins Work on 9/19/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

#import "ItemsViewController.h"
#import "ItemStore.h"
#import "Item.h"
#import "ItemCellTableViewCell.h"
@interface ItemsViewController ()

@end

@implementation ItemsViewController

// MARK: - View Lifecycle
-(void) viewDidLoad{
    [super viewDidLoad];
    
    //Get the height of the status bar
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    UIEdgeInsets insets = UIEdgeInsetsMake(statusBarHeight, 0, 0, 0);
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 65;}

//MARK: -Table View Data Source and Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemStore.allItems.count;
}

-(UITableViewCell *) tableView: (UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    // Get a new or recycled cell
    ItemCellTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ItemCellTableViewCell"
                                                                       forIndexPath:indexPath];
    // Update the labels in case the dynamic font sizes have changed recently
    [cell updateLabels];


    
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the tableview
    Item *item = self.itemStore.allItems[indexPath.row];
    
    // Configure the cell with the item's properties
    cell.nameLabel.text = item.name;
    cell.serialNumberLabel.text = item.serialNumber;
    cell.valueLabel.text = [NSString stringWithFormat:@"$%d", item.valueInDollars];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
        // If the table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Item *item = self.itemStore.allItems [indexPath.row];
        
        NSString *title = [NSString stringWithFormat:@"Delete %@?", item.name];
        NSString *message = @"Are you sure that you want to delete this item?";
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:title
                                                                    message:message
                                                             preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete"
                                                               style:UIAlertActionStyleDestructive
                                                             handler:^(UIAlertAction * _Nonnull action){
                                                                 // Remove the item from the store
                                                                 [self.itemStore removeItem:item];
                                                                 // Also remove its cell from the table view
                                                                 [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                                                                       withRowAnimation:UITableViewRowAnimationAutomatic];
                               }];
        [ac addAction:cancelAction];
        [ac addAction:deleteAction];
        
        // Present the View Controller
        [self presentViewController:ac animated:YES completion:nil];  

    }
}

// MARK: - Actions

-(IBAction)addNewItem:(id)sender{
 
    // Create a new item and add it to the store
    Item *newItem = [self.itemStore createItem];
    // Figure out where that item is in the array
    NSUInteger itemIndex = [self.itemStore.allItems indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:itemIndex inSection:0];
    
    //Insert the row into table
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(IBAction)toggleEditingMode:(id)sender{
    
    //If your currently in Editing Mode...
    if(self.editing){
        //Change the text of the button to inform user
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        //Turn Off Editing Mode
        [self setEditing:NO animated:YES];
    }else{
        //Change the text of the button to inform user
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        //Turn on Editing Mode
        [self setEditing:YES animated:YES];
    }
    
}
- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.itemStore moveItemAtIndex:sourceIndexPath.row
                            toIndex:destinationIndexPath.row];
}

@end
