//
//  ATMantleCollection.h
//
//  Created by Adam Tootle on 12/8/12.
//  Copyright (c) 2012 Adam Tootle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTLModel;

@interface ATMantleCollection : NSObject

@property(nonatomic, strong)NSMutableArray *objects;

+ (ATMantleCollection *)collectionForName:(NSString *)name;

-(id)initWithObjects:(NSArray *)objects;
-(void)addObjects:(NSArray *)objects;
-(void)addObject:(id)object;
-(id)findById:(NSInteger)objectId;
-(NSInteger)count;
-(id)objectAtIndex:(NSInteger)index;

@end
