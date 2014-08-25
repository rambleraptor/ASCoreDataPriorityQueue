#import "ASCoreDataPriorityQueue.h"

@interface ASCoreDataPriorityQueue()
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) UIManagedDocument *document;
@property (nonatomic, strong) NSComparator comparator;
@property (nonatomic, strong) NSFetchRequest *request;
@property (nonatomic, strong) NSMutableArray *queue;
@end

@implementation ASCoreDataPriorityQueue

#pragma mark - Init
- (id) initWithType:(NSString *)type andComparator:(NSComparator)compare{
    self.type = type;
    self.comparator = compare;
    
    // Setup UIManagedDocument for storing objects in CoreData
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[fileManager
                                  URLsForDirectory:NSDocumentDirectory
                                         inDomains:NSUserDomainMask] firstObject];
    NSString *documentName = @"ASPriorityQueue";
    NSURL *url = [documentsDirectory URLByAppendingPathComponent:documentName];
    self.document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[url path]]){
        [self.document openWithCompletionHandler:nil];
    }
    
    else{
        [self.document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:nil];
    }
    [self setupFetch];
    [self updateCache];
    return self;
}

#pragma mark - Information
- (NSString *)containsType{
    return _type;
}

-(BOOL) isEmpty{
    return [self count];
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
    if(self.document.documentState == UIDocumentStateNormal){
        NSManagedObjectContext *context = self.document.managedObjectContext;
        return [NSEntityDescription insertNewObjectForEntityForName:self.type inManagedObjectContext:context];
    }
    return nil;
}

-(id)peek{
    [self updateCache];
    return [self.queue firstObject];
}

-(id)pop{
    [self updateCache];
    id object = [self peek];
    
    [self deleteObject:object];
    return object;
    
}

-(void)deleteObject:(id)object{
    NSManagedObjectContext *context = self.document.managedObjectContext;
    [context deleteObject:object];
}
#pragma mark - Utilities
-(NSInteger)count{
    if(self.document.documentState == UIDocumentStateNormal){
        NSManagedObjectContext *context = self.document.managedObjectContext;
        NSError *error;
        NSArray *items = [context executeFetchRequest:self.request error:&error];
        return [items count];
    }
    return 0;
}

-(void)updateCache{
    NSManagedObjectContext *context = self.document.managedObjectContext;
    NSError *error;
    NSArray *items = [context executeFetchRequest:self.request error:&error];
    self.queue = [items mutableCopy];
    [self.queue sortUsingComparator:self.comparator];
}

-(void)setupFetch{
    self.request = [NSFetchRequest fetchRequestWithEntityName:self.type];
    self.request.fetchBatchSize = 1;
    self.request.fetchLimit = 1;
}

@end