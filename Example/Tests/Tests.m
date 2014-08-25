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
    
    beforeAll(^{
        NSComparator comparator = ^NSComparisonResult(TestModel *obj1, TestModel *obj2) {
            if ([obj1.number intValue] > [obj2.number intValue]) {
                return NSOrderedDescending;
            }
            else {
                return NSOrderedAscending;
            }
        };
        queue = [[ASCoreDataPriorityQueue alloc] initWithType:[TestModel class] andComparator:comparator];
        
    });
    
    beforeEach(^{
        // Fill queue with objects
        TestModel *obj1 = [queue push];
        obj1.number = @1;
        TestModel *obj2 = [queue push];
        obj2.number = @2;
        TestModel *obj3 = [queue push];
        obj3.number = @3;
        TestModel *obj4 = [queue push];
        obj4.number = @4;
    });
    
    it(@"should not return empty", ^{
        expect([queue isEmpty]).to.beFalsy();
    });
    
    it(@"should return the proper size", ^{
        expect([queue size]).to.equal([[queue asQueue] count]);
    });
    
    it(@"should add object in sorted order using push", ^{
        NSMutableArray *fullqueue = [[NSMutableArray alloc] initWithArray:@[@1, @2, @3, @4, @5]];
        TestModel *obj1 = [queue push];
        obj1.number = @5;
        NSArray *queuearray = [queue asQueue];
        for(int i=0; i<[fullqueue count]; i++){
            TestModel *item = [queuearray objectAtIndex:i];
            expect(item.number).to.equal(fullqueue[i]);
        }
        
    });
    
    it(@"should delete objects", ^{
        TestModel *obj1;
        obj1.number = @4;
        [queue deleteObject:obj1];
        NSMutableArray *fullqueue = [[NSMutableArray alloc] initWithArray:@[@1, @2, @3]];
        NSMutableArray *queuearray = [queue asQueue];
        for(int i=0; i<[fullqueue count]; i++){
            TestModel *item = [queuearray objectAtIndex:i];
            expect(item.number).to.equal(fullqueue[i]);
        }
    });
    
    it(@"should peek at the lowest item", ^{
        expect([[queue peek] valueForKey:@"number"]).to.equal(@1);
    });
    
    it(@"should push and pop properly", ^{
        TestModel *obj1 = [queue push];
        obj1.number = @5;
        NSArray *array = @[@1, @2, @3, @4, @5];
        for (NSNumber *number in array){
            TestModel *poppednumber = [queue peek];
            expect(poppednumber.number).to.equal(number);
            [queue pop];
        }
    });
    
    it(@"should clear the queue", ^{
        [queue clear];
        expect([queue asQueue]).to.beEmpty();
    });
    
    afterEach(^{
        [queue clear];
    });
    
});

SpecEnd

