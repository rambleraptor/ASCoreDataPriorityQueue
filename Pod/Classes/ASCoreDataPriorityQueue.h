#import <Foundation/Foundation.h>
#define MR_SHORTHAND
#import <MagicalRecord/CoreData+MagicalRecord.h>


@interface ASCoreDataPriorityQueue : NSObject

#pragma mark - Init
- (id)initWithType:(Class)type andComparator:(NSComparator)compare;

#pragma mark - Information
- (BOOL)isEmpty;
- (Class)containsType;
- (NSUInteger)size;
- (NSMutableArray *) asQueue;

#pragma mark - Changing
- (id)push;
- (void)deleteObject:(id)object;

#pragma mark - Queue Functions
- (id)peek;
- (void)pop;

#pragma mark - Delete
- (void)clear;

@end

