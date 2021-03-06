//
//  Item.m
//  HomePwner2
//
//  Created by Austins Work on 9/19/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

#import "Item.h"
@interface Item () <NSCoding>
@end

@implementation Item
-(instancetype) initWithName:(NSString *)name
                serialNumber:(NSString *)serialNumber
              valueInDollars:(int)valueInDollars{
    self = [super init];
    if(self){
        _name = [name copy];
        _serialNumber = [serialNumber copy];
        _valueInDollars = valueInDollars;
        _dateCreated = [NSDate date];
        _itemKey = [NSUUID UUID].UUIDString;
    }
    return self;
}
-(instancetype) init {
    return [self initWithName: @"New Item" serialNumber: @"" valueInDollars: 0];
}
-(instancetype)initWithRandomValues{
    NSArray *adjetives = @[@"Fluffy", @"Rusty", @"Shiny"];
    NSArray *nouns = @[@"Bear",@"Spork",@"Mac"];
    
    NSString *adjetive = adjetives [arc4random_uniform((int)adjetives.count)];
    NSString *noun = nouns [arc4random_uniform((int)nouns.count)];
    NSString *name = [NSString stringWithFormat:@"%@ %@", adjetive, noun];
    
    NSString *serial = [[[NSUUID UUID] UUIDString] substringToIndex:5];
    
    int value = (int)arc4random_uniform(100);
    
    return [self initWithName:name
                 serialNumber:serial
               valueInDollars:value];
}

// MARK: - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:self.itemKey forKey:@"itemKey"];
    [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [aCoder encodeInt:self.valueInDollars forKey:@"valueInDollars"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
        _itemKey = [aDecoder decodeObjectForKey:@"itemKey"];
        _serialNumber = [aDecoder decodeObjectForKey:@"serialNumber"];
        _valueInDollars = [aDecoder decodeIntForKey:@"valueInDollars"];
    }
    return self;
}
@end
