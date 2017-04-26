//
//  CMHTMLFontTransformer.m
//  myjournal
//
//  Created by huliangjie on 10/4/2017.
//  Copyright © 2017 Fenix Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaMarkdown/Ono.h>

#import "CMHTMLFontTransformer.h"

@implementation CMHTMLFontTransformer

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

+ (NSString *)tagName {
    return @"font";
}

- (NSAttributedString *)attributedStringForElement:(ONOXMLElement *)element attributes:(NSDictionary *)attributes {
    CMAssertCorrectTag(element);
    
    NSMutableDictionary *allAttributes = [attributes mutableCopy];
    
    NSString *sizeStr = element.attributes[@"size"];
    CGFloat fontSize = sizeStr ? [sizeStr floatValue] : [UIFont labelFontSize];
    
    NSString *faceStr = element.attributes[@"face"];
    UIFont *font = nil;
    
    if (faceStr) {
        font = [UIFont fontWithName:faceStr size:fontSize];
    }
    
    if (!font) {
        //NSLog(@"fail to use font: %@. fallback.", faceStr);
        font = [[UIFont preferredFontForTextStyle:UIFontTextStyleBody] fontWithSize:fontSize];
    }
    
    allAttributes[NSFontAttributeName] = font;
    
    NSString *colorStr = element.attributes[@"color"];
    if (colorStr) {
        if ([colorStr compare:@"#" options:kNilOptions range:NSMakeRange(0, 1)] == NSOrderedSame) {
            NSString *hexStr = [colorStr substringFromIndex:1];
            int hexNumber = 0;
            if (hexStr.length <= 6) {
                const char *hexChar = [hexStr cStringUsingEncoding:NSUTF8StringEncoding];
                sscanf(hexChar, "%x", &hexNumber);
            }
            CGFloat red = ((hexNumber >> 16) & 0xff) / 255.0;
            CGFloat green = ((hexNumber >> 8) & 0xff) / 255.0;
            CGFloat blue = (hexNumber & 0xff) / 255.0;
            allAttributes[NSForegroundColorAttributeName] = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
            //NSLog(@"%@ %lu", [UIColor colorWithInteger:colorInt], (long)colorInt);
        }
    }
    
    return [[NSAttributedString alloc] initWithString:element.stringValue attributes:allAttributes];
}

@end
