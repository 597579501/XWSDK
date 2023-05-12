

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@protocol XWStoreContentDownloader;
@protocol XWStoreReceiptVerifier;
@protocol XWStoreTransactionPersistor;
@protocol XWStoreObserver;

extern NSString *const XWStoreErrorDomain;
extern NSInteger const XWStoreErrorCodeDownloadCanceled;
extern NSInteger const XWStoreErrorCodeUnknownProductIdentifier;
extern NSInteger const XWStoreErrorCodeUnableToCompleteVerification;


@interface XWStore : NSObject<SKPaymentTransactionObserver>


+ (XWStore*)defaultStore;

#pragma mark StoreKit Wrapper

+ (BOOL)canMakePayments;

- (void)addPayment:(NSString*)productIdentifier;


- (void)addPayment:(NSString*)productIdentifier
           success:(void (^)(SKPaymentTransaction *transaction))successBlock
           failure:(void (^)(SKPaymentTransaction *transaction, NSError *error))failureBlock;


- (void)addPayment:(NSString*)productIdentifier
              user:(NSString*)userIdentifier
           success:(void (^)(SKPaymentTransaction *transaction))successBlock
           failure:(void (^)(SKPaymentTransaction *transaction, NSError *error))failureBlock __attribute__((availability(ios,introduced=7.0)));

- (void)requestProducts:(NSSet*)identifiers;


- (void)requestProducts:(NSSet*)identifiers
                success:(void (^)(NSArray *products, NSArray *invalidProductIdentifiers))successBlock
                failure:(void (^)(NSError *error))failureBlock;


- (void)restoreTransactions;


- (void)restoreTransactionsOnSuccess:(void (^)(NSArray *transactions))successBlock
                             failure:(void (^)(NSError *error))failureBlock;



- (void)restoreTransactionsOfUser:(NSString*)userIdentifier
                        onSuccess:(void (^)(NSArray *transactions))successBlock
                          failure:(void (^)(NSError *error))failureBlock __attribute__((availability(ios,introduced=7.0)));

#pragma mark Receipt

+ (NSURL*)receiptURL __attribute__((availability(ios,introduced=7.0)));

- (void)refreshReceipt __attribute__((availability(ios,introduced=7.0)));


- (void)refreshReceiptOnSuccess:(void (^)(void))successBlock
                        failure:(void (^)(NSError *error))failureBlock __attribute__((availability(ios,introduced=7.0)));


@property (nonatomic, weak) id<XWStoreContentDownloader> contentDownloader;


@property (nonatomic, weak) id<XWStoreReceiptVerifier> receiptVerifier;


@property (nonatomic, weak) id<XWStoreTransactionPersistor> transactionPersistor;



- (SKProduct*)productForIdentifier:(NSString*)productIdentifier;

+ (NSString*)localizedPriceOfProduct:(SKProduct*)product;

- (void)addStoreObserver:(id<XWStoreObserver>)observer;


- (void)removeStoreObserver:(id<XWStoreObserver>)observer;

@end

@protocol XWStoreContentDownloader <NSObject>


- (void)downloadContentForTransaction:(SKPaymentTransaction*)transaction
                              success:(void (^)(void))successBlock
                             progress:(void (^)(float progress))progressBlock
                              failure:(void (^)(NSError *error))failureBlock;

@end

@protocol XWStoreTransactionPersistor<NSObject>

- (void)persistTransaction:(SKPaymentTransaction*)transaction;

@end

@protocol XWStoreReceiptVerifier <NSObject>


- (void)verifyTransaction:(SKPaymentTransaction*)transaction
                  success:(void (^)(void))successBlock
                  failure:(void (^)(NSError *error))failureBlock;

@end

@protocol XWStoreObserver<NSObject>
@optional


- (void)storeDownloadCanceled:(NSNotification*)notification __attribute__((availability(ios,introduced=6.0)));


- (void)storeDownloadFailed:(NSNotification*)notification __attribute__((availability(ios,introduced=6.0)));


- (void)storeDownloadFinished:(NSNotification*)notification __attribute__((availability(ios,introduced=6.0)));


- (void)storeDownloadPaused:(NSNotification*)notification __attribute__((availability(ios,introduced=6.0)));


- (void)storeDownloadUpdated:(NSNotification*)notification __attribute__((availability(ios,introduced=6.0)));

- (void)storeDHmentTransactionDeferred:(NSNotification*)notification __attribute__((availability(ios,introduced=8.0)));
- (void)storeDHmentTransactionFailed:(NSNotification*)notification;
- (void)storeDHmentTransactionFinished:(NSNotification*)notification;
- (void)storeProductsRequestFailed:(NSNotification*)notification;
- (void)storeProductsRequestFinished:(NSNotification*)notification;
- (void)storeRefreshReceiptFailed:(NSNotification*)notification __attribute__((availability(ios,introduced=7.0)));
- (void)storeRefreshReceiptFinished:(NSNotification*)notification __attribute__((availability(ios,introduced=7.0)));
- (void)storeRestoreTransactionsFailed:(NSNotification*)notification;
- (void)storeRestoreTransactionsFinished:(NSNotification*)notification;

@end


@interface NSNotification(XWStore)


@property (nonatomic, readonly) float rm_downloadProgress;


@property (nonatomic, readonly) NSArray *rm_invalidProductIdentifiers;


@property (nonatomic, readonly) NSString *rm_productIdentifier;


@property (nonatomic, readonly) NSArray *rm_products;

@property (nonatomic, readonly) SKDownload *rm_storeDownload __attribute__((availability(ios,introduced=6.0)));


@property (nonatomic, readonly) NSError *rm_storeError;


@property (nonatomic, readonly) SKPaymentTransaction *rm_transaction;

@property (nonatomic, readonly) NSArray *rm_transactions;

@end
