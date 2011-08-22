//
//  Downloader.h
//
//  aflx - always flexible
//  http://www.aflx.de
//  ak@aflx.de
//
//  I have adapted the classname and signature of the method of this plugin for
//  Android and iOS.
//
//  Copyright 2011 Alexander Keller All rights reserved.
//
//  Thanks to Aaron K. Saunders
//  http://blog.clearlyinnovative.com
//

#import <Foundation/Foundation.h>
#import "PGPlugin.h"
	

@interface Downloader : PGPlugin	 {
    NSString* callbackID;  
}

@property (nonatomic, copy) NSString* callbackID;
-(void) downloadFile:(NSMutableArray*)paramArray withDict:(NSMutableDictionary*)options;
-(void) download:(NSMutableArray*)paramArray;
-(void) success:(NSMutableString*)filePath; 
-(void) fail:(NSMutableString*)errorStr; 
@end

