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
    return [self emojify:string selectedRange:nil];
}

- (NSString *)emojify:(NSString *)string selectedRange:(inout NSRange *)selectedRange
{
    if (string.length == 0) {
        return string;
    }
    
    NSMutableString *emojiString = [string mutableCopy];
    for (NSString *key in _emojis) {
        [self replaceKey:key
                 toEmoji:[_emojis objectForKey:key]
                ofString:emojiString
           selectedRange:selectedRange];
    }
    return emojiString;
}

#pragma mark - Private

- (void)replaceKey:(NSString *)key
           toEmoji:(NSString *)emoji
          ofString:(inout NSMutableString *)string
     selectedRange:(inout NSRange *)inoutSelectedRange
{
    NSUInteger diff = emoji.length - key.length;
    
    NSRange selectedRange;
    if (inoutSelectedRange != NULL) {
        selectedRange = *inoutSelectedRange;
    } else {
        selectedRange = NSMakeRange(0, 0);
    }
    
    NSRange searchRange = NSMakeRange(0, 0);
    while (searchRange.location < string.length) {
        
        searchRange.length = string.length - searchRange.location;
        NSRange foundRange = [string rangeOfString:key options:NSCaseInsensitiveSearch range:searchRange];
        
        if (foundRange.location != NSNotFound) {
            [string replaceCharactersInRange:foundRange withString:emoji];
            if (selectedRange.location >= foundRange.location &&
                selectedRange.location + selectedRange.length < foundRange.location + foundRange.length) {
                selectedRange.location = foundRange.location + foundRange.length + diff;
                
            } else if (selectedRange.location + selectedRange.length >= foundRange.location + foundRange.length) {
                selectedRange.location += diff;
            }
            
            searchRange.location = foundRange.location + foundRange.length;
        } else {
            break;
        }
    }
    
    if (inoutSelectedRange != NULL) {
        *inoutSelectedRange = selectedRange;
    }
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
    for (id emoji in emojisDict) {
        id smiles = [emojisDict objectForKey:emoji];
        if ([emoji isKindOfClass:[NSString class]] && [smiles isKindOfClass:[NSArray class]]) {
            for (id smile in (NSArray *)smiles) {
                if ([smile isKindOfClass:[NSString class]]) {
                    [_emojis setObject:emoji forKey:smile];
                }
            }
        }
    }
}

@end
