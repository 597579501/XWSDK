
#import <Foundation/Foundation.h>
#import "XWStore.h"


@interface XWStoreKeychainPersistence : NSObject<XWStoreTransactionPersistor>


- (void)removeTransactions;


- (BOOL)consumeProductOfIdentifier:(NSString*)productIdentifier;


- (NSInteger)countProductOfdentifier:(NSString*)productIdentifier;


- (BOOL)isPurchasedProductOfIdentifier:(NSString*)productIdentifier;


@property (nonatomic, readonly, copy) NSSet *purchasedProductIdentifiers;

@end
