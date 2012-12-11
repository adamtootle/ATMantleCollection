//
//  ATMantleCollection.m
//
//  Created by Adam Tootle on 12/8/12.
//  Copyright (c) 2012 Adam Tootle. All rights reserved.
//

#import "ATMantleCollection.h"
#import "MTLModel.h"

@interface MTLModelWithId : MTLModel
@property(nonatomic, assign)NSInteger id;
@end

@implementation ATMantleCollection

@synthesize objects = _objects;
static NSMutableDictionary* collections = nil;

+ (ATMantleCollection *)collectionForName:(NSString *)name
{
    if(!collections)
        collections = [NSMutableDictionary dictionary];
    
    if(![collections objectForKey:name])
        [collections setValue:[[ATMantleCollection alloc] init] forKey:name];
    
    return [collections objectForKey:name];
}

-(id)init
{
    self = [super init];
    if(self)
    {
        _objects = [NSMutableArray array];
    }
    return self;
}

- (id)initWithObjects:(NSArray *)objects
{
    self = [super init];
    if(self)
    {
        _objects = [NSMutableArray arrayWithArray:objects];
    }
    return self;
}

- (void)addObjects:(NSArray *)objects
{
    _objects = [NSMutableArray arrayWithArray:objects];
    for(id object in objects)
    {
        NSInteger objectId = [[object performSelector:@selector(id)] integerValue];
        if([self findById:objectId] != nil)
        {
            NSUInteger index = [_objects indexOfObject:[self findById:objectId]];
            [_objects setObject:object atIndexedSubscript:index];
        }
        else
        {
            [_objects insertObject:object atIndex:([_objects count])];
        }
    }
}

- (void)addObject:(id)object
{
    NSInteger objectId = [[object performSelector:@selector(id)] integerValue];
    if([self findById:objectId] != nil)
    {
        [_objects setObject:object atIndexedSubscript:[_objects indexOfObject:[self findById:objectId]]];
    }
    else
    {
        [_objects insertObject:object atIndex:([_objects count])];
    }
}

- (id)findById:(NSInteger)objectId
{
    NSArray *existingObjects = [_objects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"id == %i", objectId]];
    if([existingObjects count] > 0)
        return [existingObjects objectAtIndex:0];
    
    return nil;
}

- (NSInteger)count
{
    return [_objects count];
}

- (id)objectAtIndex:(NSInteger)index
{
    return [_objects objectAtIndex:index];
}

@end
