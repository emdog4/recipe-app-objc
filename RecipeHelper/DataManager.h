//
//  DataManager.h

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataManager : NSObject

@property (nonatomic, readonly, strong) NSManagedObjectModel *objectModel;
@property (nonatomic, readonly, strong) NSManagedObjectContext *mainObjectContext;
@property (nonatomic, readonly, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (DataManager*)sharedInstance;
- (BOOL)save;
- (NSManagedObjectContext*)managedObjectContext;
- (void)preloadData;

@end
