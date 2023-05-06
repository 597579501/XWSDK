//
//  XWHelper.h
//  XWSDK
//
//  Created by Seven on 2023/5/6.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

NS_ASSUME_NONNULL_BEGIN

@interface XWHelper : NSObject
+ (BOOL)isBlankString:(NSString *)string;
+ (void)callMobileWithWebView:(NSString *)mobile;
+ (UIImage *)screenView:(UIView *)view;
+ (NSString *)getObjStr:(NSObject *)paramObject;




/**
 获取随机书

 @param length 随机数长
 @return return value description
 */
+ (NSString *)genRandomText:(int)length;


/**
 判断是否输入纯数字

 @param number number description
 @return return value description
 */
+ (BOOL)validateNumber:(NSString *)number;

/**
 加密解密

 @param plainText 需要加密/解密的string
 @param encryptOrDecrypt  kCCEncrypt加密 0kCCDecrypt解密
 @return return value description
 */
+ (NSString *)tripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt;

/**
 获取运营商
 */
+ (NSString *)getCarrierName;

@end

NS_ASSUME_NONNULL_END
