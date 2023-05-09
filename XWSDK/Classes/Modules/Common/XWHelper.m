//
//  XWHelper.m
//  XWSDK
//
//  Created by Seven on 2023/5/6.
//

#import "XWHelper.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <UIKit/UIKit.h>
#import <YYKit/YYKit.h>


#define DESKEY   @"20231234567890platform"


@implementation XWHelper

+ (BOOL)isBlankString:(NSString *)string
{
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}


+ (void)callMobileWithWebView:(NSString *)mobile
{
    UIWebView *callWebView = [[UIWebView alloc] init];
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", mobile]];
    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
    [[[UIApplication sharedApplication] windows].firstObject addSubview:callWebView];
}


+ (UIImage *)screenView:(UIView *)view
{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (NSString *)tripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt
{
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)//解密
    {
        NSData *EncryptData = [[NSData alloc] initWithBase64EncodedString:plainText options:0];
        //        NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else
    {
        //加密
        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        //        NSLog(@"%@",plainText);
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
        //        NSLog(@"%s",        vplainText);
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    const void *vkey = (const void *)[DESKEY UTF8String];
    // NSString *initVec = @"init Vec";
    //const void *vinitVec = (const void *) [initVec UTF8String];
    //  Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    if (ccStatus == kCCSuccess)
    {
        
    }
    /*else if (ccStatus == kCC ParamError) return @"PARAM ERROR";
     else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
     else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
     else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
     else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
     else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED"; */
    
    NSString *result;
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes]
                                       encoding:NSUTF8StringEncoding];
        
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        //        result = [myData base64EncodedString];
        result = [myData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        
        
    }
    free(bufferPtr);
    return result;
}


+ (NSData*)getDeviceLoginRecordsKey
{
//    char *key = malloc(32);
//    memset(key, 0, 32);
//
////    MakeKey('I', [UIDeviceAdditions getECID], (char*)[[UIDevice currentDevice] identifierForVendor].UUIDString, (char*)[UIDeviceAdditions getMacAddress].UTF8String, key);
////    MakeKey('I', [UIDeviceAdditions getECID], (char*)[[UIDevice currentDevice] uniqueIdentifier].UTF8String, (char*)[UIDeviceAdditions getMacAddress].UTF8String, key);
//
//
//
//    if (!snData || ![snData isKindOfClass:[NSData class]] || [snData isEqualToData:[NSData data]]) {
//        return nil;
//    }
//
//    if (snData.length >= 16) {
//        memcpy(key, snData.bytes, 16);
//    }else {
//        memcpy(key, snData.bytes, snData.length);
//    }
//
//    *(int*)(key+16) = DeviceLoginRecords;
//
//    return [NSData dataWithBytesNoCopy:key length:32 freeWhenDone:YES];
    return nil;
}



+ (BOOL)validateNumber:(NSString *)number
{
    BOOL res = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


+ (NSString *)genRandomText:(int)length
{
    NSArray *array = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0"];
    NSMutableString *pwd = [[NSMutableString alloc] init];
    int count = 0;
    int i;
    while (count < length)
    {
        i = [self getRandomNumber:0 to:array.count];
        if (i >= 0 && i < array.count)
        {
            [pwd appendString:array[i]];
            count++;
        }
    }
    return [NSString stringWithFormat:@"%@", pwd];
}


+ (int)getRandomNumber:(int)from to:(NSUInteger)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}


+ (NSString *)getCarrierName
{
    //获取本机运营商名称
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    //当前手机所属运营商名称
    NSString *mobile;
    //先判断有没有SIM卡，如果没有则不获取本机运营商
    if (!carrier.isoCountryCode) {
        mobile = @"无运营商";
    }
    else
    {
        mobile = [carrier carrierName];
    }
    return  mobile;
}


+ (NSString *)getObjStr:(NSDictionary *)dictionary
{
    NSMutableString *discription = [NSMutableString string];
    for (NSString *key in dictionary) {
        NSString *value = [NSString stringWithFormat:@"%@", dictionary[key]];
        NSString *value1 = [value stringByURLEncode];
        [discription appendFormat:@"%@=%@&", [key stringByURLEncode], value1];
    }
    NSString *tempStr = [discription substringWithRange:NSMakeRange(0, discription.length - 1)];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    return tempStr;
}


@end
