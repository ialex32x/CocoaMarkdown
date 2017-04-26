//
//  CMHTMLFontTransformer.h
//  myjournal
//
//  Created by huliangjie on 10/4/2017.
//  Copyright © 2017 Fenix Apps. All rights reserved.
//

#ifndef CMHTMLFontTransformer_h
#define CMHTMLFontTransformer_h

#import <Foundation/Foundation.h>

#import <CocoaMarkdown/CMHTMLElementTransformer.h>
#import <CocoaMarkdown/CMPlatformDefines.h>

@interface CMHTMLFontTransformer : NSObject <CMHTMLElementTransformer>

- (instancetype)init;

@end

#endif /* CMHTMLFontTransformer_h */
