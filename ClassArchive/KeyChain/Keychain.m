//
//  Keychain.m
//  ZiRuYi
//
//  Created by DuanHongwu on 15/06/26.
//  Copyright (c) 2015年 CreditCloud. All rights reserved.
//

#import "Keychain.h"
#import <Security/Security.h>


/** 备注：
 *  __bridge只做类型转换，但是不修改对象（内存）管理权；
 *  __bridge_retained（也可以使用CFBridgingRetain）将Objective-C的对象转换为Core Foundation的对象，同时将对象（内存）的管理权交给我们，后续需要使用CFRelease或者相关方法来释放对象；
 *  __bridge_transfer（也可以使用CFBridgingRelease）将Core Foundation的对象转换为Objective-C的对象，同时将对象（内存）的管理权交给ARC。
 */

#define CHECK_OSSTATUS_ERROR(x) (x == noErr) ? YES : NO

@interface Keychain ()

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)key;

@end

@implementation Keychain

#pragma mark - Private
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)key
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword, (__bridge_transfer id)kSecClass, // kSecClassInternetPassword
            key, (__bridge_transfer id)kSecAttrService,
            key, (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock, (__bridge_transfer id)kSecAttrAccessible,
            nil];
}

#pragma mark - Public
+ (BOOL)saveValue:(id)value forKey:(NSString *)key
{
    // Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    
    // Delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    
    // Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:(__bridge_transfer id)kSecValueData];
    
    // Add item to keychain with the search dictionary
    OSStatus result = SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
    
    return CHECK_OSSTATUS_ERROR(result);
}

+ (BOOL)deleteValueForKey:(NSString *)key
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    
    OSStatus result = SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    
    return CHECK_OSSTATUS_ERROR(result);
}

+ (id)loadValueForKey:(NSString *)key
{
    id value = nil;
    CFDataRef keyData = NULL;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    
    // Configure the search setting
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        
        @try {
            
            value = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
            
        } @catch (NSException *e) {
            
            NSLog(@"Unarchive of %@ failed: %@", key, e);
            value = nil;
            
        } @finally {
        }
    }
    
    return value;
}

@end
