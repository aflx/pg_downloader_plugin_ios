//
// Downloader.m
//
// aflx - always flexible
// http://www.aflx.de
// ak@aflx.de
//
// I have adapted the classname and signature of the method of this plugin for
// Android and iOS.
//
// Copyright 2011 Alexander Keller All rights reserved.
//
// Thanks to Aaron K. Saunders
// http://blog.clearlyinnovative.com
//

#import <Foundation/Foundation.h>
#import "PGPlugin.h"
	

@interface Downloader : PGPlugin	 {
    NSString* callbackID;  
}

- (void) download:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

-(void) downloadFile:(NSMutableArray*)arguments;
-(void) downloadSuccess:(NSMutableArray*)arguments; 
-(void) downloadFail:(NSMutableArray*)arguments; 
@end

