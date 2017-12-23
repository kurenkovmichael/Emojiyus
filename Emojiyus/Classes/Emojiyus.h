//
//  Emojiyus.h
//  Emojiyus
//
//  Created by Михаил Куренков on 23.12.2017.
//

#import <Foundation/Foundation.h>

@interface Emojiyus : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithMappingJsonUrl:(NSURL *)mappingJsonUrl;

- (NSString *)emojify:(NSString *)string;

@end
