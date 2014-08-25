#import "ASCoreDataPriorityQueue.h"

@interface ASCoreDataPriorityQueue()
@property (nonatomic, strong) Class type;
@property (nonatomic, strong) UIManagedDocument *document;
@property (nonatomic, strong) NSComparator comparator;
@property (nonatomic, strong) NSFetchRequest *request;
@property (nonatomic, strong) NSMutableArray *queue;
@end

@implementation ASCoreDataPriorityQueue

#pragma mark - Init
- (id) initWithType:(Class)type andComparator:(NSComparator)compare{
    self.type = type;
    self.comparator = compare;
    
    [MagicalRecord setDefaultModelFromClass:type];
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    return self;
}

#pragma mark - Information
- (Class)containsType{
    return _type;
}

-(BOOL) isEmpty{
    return ![self count];
}

-(NSUInteger)size{
    return [self count];
}

-(NSMutableArray *) asQueue {
    [self updateCache];
    return self.queue;
}
#pragma mark - Changing
-(id)push{
    return [self.type MR_createEntity];
}

-(id)peek{
    [self updateCache];
    return [self.queue firstObject];
}

-(void)pop{
    [self updateCache];
    id object = [self peek];
    
    [self deleteObject:object];
    
}

-(void)deleteObject:(id)object{
    [object MR_deleteEntity];
}
#pragma mark - Utilities
-(NSInteger)count{
    return [self.type MR_countOfEntities];
}

-(void)updateCache{
    NSArray *items = [self.type MR_findAll];
    self.queue = [items mutableCopy];
    [self.queue sortUsingComparator:self.comparator];
}

-(void) dealloc{
    [MagicalRecord cleanUp];
}

-(void) clear{
    [self.type MR_truncateAll];
}
@end