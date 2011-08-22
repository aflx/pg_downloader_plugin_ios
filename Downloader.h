//
//  Downloader.h
//
//  aflx - always flexible
//  http://www.aflx.de
//  ak@aflx.de
//
//  Copyright 2011 Alexander Keller All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGPlugin.h"
	

@interface Downloader : PGPlugin	 {
    NSString* callbackID;  
}

@property (nonatomic, copy) NSString* callbackID;
-(void) downloadFile:(NSMutableArray*)paramArray withDict:(NSMutableDictionary*)options;
//-(void) startDownload:(NSMutableArray*)paramArray;
-(void) download:(NSMutableArray*)paramArray;
-(void) success:(NSMutableString*)filePath; 
-(void) fail:(NSMutableString*)errorStr; 
@end

