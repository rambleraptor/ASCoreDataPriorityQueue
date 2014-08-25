#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ASCoreDataPriorityQueue : NSObject

#pragma mark - Init
- (id)initWithType:(NSString *)type andComparator:(NSComparator)compare;

#pragma mark - Information
- (BOOL)isEmpty;
- (NSString *)containsType;
- (NSUInteger)size;
- (NSMutableArray *) asQueue;

#pragma mark - Changing
- (id)push;
- (void)deleteObject:(id)object;

#pragma mark - Queue Functions
- (id)peek;
- (id)pop;

@end

