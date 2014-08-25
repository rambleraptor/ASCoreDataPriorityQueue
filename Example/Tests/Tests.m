//
//  ASCoreDataPriorityQueueTests.m
//  ASCoreDataPriorityQueueTests
//
//  Created by Alex Stephen on 08/14/2014.
//  Copyright (c) 2014 Alex Stephen. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "ASCoreDataPriorityQueue.h"
#import "TestModel.h"

SpecBegin(ASCoreDataPriorityQueue)

describe(@"ASCoreDataPriorityQueue", ^{
    __block ASCoreDataPriorityQueue *queue;
    
    beforeEach(^{
        NSComparator comparator = ^NSComparisonResult(TestModel *obj1, TestModel *obj2) {
            if ([obj1 valueForKey:@"number"] > [obj2 valueForKey:@"number"]) {
                return NSOrderedDescending;
            }
            else {
                return NSOrderedAscending;
            }
        };
        queue = [[ASCoreDataPriorityQueue alloc] initWithType:[TestModel class] andComparator:comparator];
        
        // Fill queue with objects
        TestModel *obj1 = [queue push];
        [obj1 setValue:@1 forKey:@"number"];
        TestModel *obj2 = [queue push];
        [obj1 setValue:@2 forKey:@"number"];
        TestModel *obj3 = [queue push];
        [obj1 setValue:@3 forKey:@"number"];
        TestModel *obj4 = [queue push];
        [obj1 setValue:@4 forKey:@"number"];
    });
    
    it(@"should not return empty", ^{
        expect([queue isEmpty]).to.beTruthy();
    });
    
    it(@"should return the proper size", ^{
        expect([queue size]).to.equal([[queue asQueue] count]);
    });
    
    it(@"should add object in sorted order using push", ^{
        NSMutableArray *fullqueue = [[NSMutableArray alloc] initWithArray:@[@1, @2, @3, @4, @5]];
        NSManagedObject *obj1 = [queue push];
        [obj1 setValue:@5 forKey:@"number"];
        expect([queue asQueue]).to.equal(fullqueue);
    });
    
    it(@"should delete objects", ^{
        [queue deleteObject:@4];
        expect([queue asQueue]).to.equal(@[@1,@2,@3]);
    });
    
    it(@"should peek at the lowest item", ^{
        expect([queue peek]).to.equal(@1);
    });
    
    it(@"should remove objects and return them", ^{
        NSNumber *firstnumber = [queue pop];
        expect(firstnumber).to.equal(@1);
        expect([queue asQueue]).to.equal(@[@2,@3,@4]);
    });
    
    it(@"should push and pop properly", ^{
        NSManagedObject *obj1 = [queue push];
        [obj1 setValue:@5 forKey:@"number"];
        NSArray *array = @[@1, @2, @3, @4, @5];
        for (NSNumber *number in array){
            NSNumber *poppednumber = [queue pop];
            expect(poppednumber).to.equal(number);
        }
    });
    
    afterEach(^{
        [queue clear];
        queue = nil;
    });
    
});

SpecEnd

