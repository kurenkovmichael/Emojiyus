//
//  Emojiyus.m
//  Emojiyus
//
//  Created by Михаил Куренков on 23.12.2017.
//

#import "Emojiyus.h"

@interface Emojiyus () {
    NSMapTable *_emojis;
}

@end

@implementation Emojiyus

- (instancetype)initWithMappingJsonUrl:(NSURL *)mappingJsonUrl
{
    NSParameterAssert(mappingJsonUrl != nil);
    
    if (self = [super init]) {
        [self setupWithMappingJsonUrl:mappingJsonUrl];
    }
    return self;
}

- (NSString *)emojify:(NSString *)string
{
    if (string.length == 0) {
        return string;
    }
    
    NSMutableString *emojiString = [string mutableCopy];
    for (NSString *key in _emojis) {
        [emojiString replaceOccurrencesOfString:key
                                     withString:[_emojis objectForKey:key]
                                        options:NSCaseInsensitiveSearch
                                          range:NSMakeRange(0, [emojiString length])];
    }
    return emojiString;
}

#pragma mark - Private -> Setup

- (void)setupWithMappingJsonUrl:(NSURL *)mappingJsonUrl
{
    NSData *jsonData = [NSData dataWithContentsOfURL:mappingJsonUrl];
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    NSAssert(jsonObject == nil || [jsonObject isKindOfClass:[NSDictionary class]], @"Wrong mapping json.");
    NSDictionary *emojisDict = (NSDictionary *)jsonObject;
    
    _emojis = [NSMapTable strongToStrongObjectsMapTable];
    for (id key in emojisDict) {
        id value = [emojisDict objectForKey:key];
        if ([key isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]]) {
            [_emojis setObject:value forKey:key];
        }
    }
}

@end
