//
//  ATMantleCollection.m
//
//  Created by Adam Tootle on 12/8/12.
//  Copyright (c) 2012 Adam Tootle. All rights reserved.
//

#import "ATMantleCollection.h"
#import "MTLModel.h"



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
        if(object != nil)
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
        else
        {
            NSLog(@"[WARNING] ATMantleCollection - addObjects: cannot add an object that is nil");
        }
    }
}

-(void)addOrUpdateObject:(id)object;
{
    if(object == nil)
    {
        NSLog(@"[WARNING] ATMantleCollection - addOrUpdateObject: cannot add an object that is nil");
        return;
    }
    NSInteger objectId = [[object performSelector:@selector(id)] integerValue];
    id existingObject = [self findById:objectId];
    if(existingObject != nil)
    {
        [existingObject mergeValuesForKeysFromModel:object];
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

- (NSArray *)findByString:(NSString *)value forAttribute:(NSString *)attribute
{
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return [[evaluatedObject valueForKey:attribute] isEqualToString:value];
    }];
    
    NSArray *existingObjects = [_objects filteredArrayUsingPredicate:predicate];
    
    if([existingObjects count] > 0)
        return existingObjects;
    
    return [NSArray array];
}

- (NSInteger)count
{
    return [_objects count];
}

- (id)objectAtIndex:(NSInteger)index
{
    return [_objects objectAtIndex:index];
}

- (void)purge
{
    self.objects = [NSMutableArray array];
}

@end
