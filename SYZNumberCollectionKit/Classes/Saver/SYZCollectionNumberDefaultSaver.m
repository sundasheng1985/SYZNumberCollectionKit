//
//  SYZCollectionNumberDefaultSaver.m
//  SYZNumberCollectionKit
//
//  Created by sundasheng1985 on 03/16/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

#import "SYZCollectionNumberDefaultSaver.h"

@implementation SYZCollectionNumberDefaultSaver

#pragma mark - SYZNumberCollectorSaverDelegate
/** 保存数据
 格式为：
 type: {
 key: datas,
 key2: datas2
 }
 */
- (void)numberCollectorSaveData:(NSDictionary*)datas forKey:(NSString*)key withType:(NSString*)type {
    NSMutableDictionary* typeDatas = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:type] mutableCopy];
    typeDatas = typeDatas != nil ? typeDatas : [NSMutableDictionary new];
    typeDatas[key] = datas;
    [[NSUserDefaults standardUserDefaults] setObject:typeDatas forKey:type];
    [self _sync];
}

/** 获取数据*/
- (NSDictionary*)numberCollectoFetchDataForKey:(NSString*)key withType:(NSString*)type {
    NSDictionary* typeDatas = [[NSUserDefaults standardUserDefaults] dictionaryForKey:type];
    return typeDatas[key];
}

/** 清除key对应的数据*/
- (void)numberCollectorCleanDataForKey:(NSString*)key withType:(NSString*)type {
    NSMutableDictionary* typeDatas = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:type] mutableCopy];
    if (typeDatas == nil) return;
    [typeDatas removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:typeDatas forKey:type];
    [self _sync];
}

/** 清楚所有数据*/
- (void)numberCollectorCleanDataWithType:(NSString*)type {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:type];
}

#pragma mark - Private
- (void)_sync {
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
