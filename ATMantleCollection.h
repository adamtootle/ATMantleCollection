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
-(void)addOrUpdateObject:(id)object;
-(id)findById:(NSInteger)objectId;
-(NSArray*)findByString:(NSString*)value forAttribute:(NSString*)attribute;
-(NSArray*)findByValue:(id)value forAttribute:(NSString*)attribute;
-(NSInteger)count;
-(id)objectAtIndex:(NSInteger)index;
-(void)purge;

@end
