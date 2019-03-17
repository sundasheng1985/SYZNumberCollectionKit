//
//  SYZWeakObject.h
//  Pods
//
//  Created by LeeRay on 2018/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 弱引用对象保存 */
@interface SYZWeakObject : NSObject

- (instancetype)initWithWeakObject:(id)weakObj;

@property (nonatomic,weak) NSObject * weakObj;
@end

NS_ASSUME_NONNULL_END
