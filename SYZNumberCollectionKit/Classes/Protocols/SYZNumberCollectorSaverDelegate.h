//
//  SYZNumberCollectorSaverDelegate.h
//  SYZNumberCollectionKit
//
//  Created by sundasheng1985 on 03/16/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SYZNumberCollectorSaverDelegate <NSObject>

/** 保存数据
格式为：
 type: {
     key: datas,
     key2: datas2
 }
 */
- (void)numberCollectorSaveData:(NSDictionary*)datas forKey:(NSString*)key withType:(NSString*)type;

/** 获取数据*/
- (NSDictionary*)numberCollectoFetchDataForKey:(NSString*)key withType:(NSString*)type;

/** 清除key对应的数据*/
- (void)numberCollectorCleanDataForKey:(NSString*)key withType:(NSString*)type;

/** 清楚所有数据*/
- (void)numberCollectorCleanDataWithType:(NSString*)type;

@end

NS_ASSUME_NONNULL_END
