#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SYZNumberCollectorTypeBuilder.h"
#import "SYZNumberColLeaf.h"
#import "SYZNumberCollectionerDelegate.h"
#import "SYZNumberCollectorSaverDelegate.h"
#import "SYZCollectionNumberDefaultSaver.h"
#import "SYZNumberCollectionKit.h"
#import "SYZNumberCollector.h"
#import "SYZNumberCollectionTransaction.h"

FOUNDATION_EXPORT double SYZNumberCollectionKitVersionNumber;
FOUNDATION_EXPORT const unsigned char SYZNumberCollectionKitVersionString[];

