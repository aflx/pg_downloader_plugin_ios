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

enum FileTransferError {
	FILE_NOT_FOUND_ERR = 1,
    INVALID_URL_ERR = 2,
    CONNECTION_ERR = 3
};
typedef int FileTransferError;

@interface Downloader : PGPlugin	 { 
}

- (void) download:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

-(void) downloadFile:(NSMutableArray*)arguments;
-(void) downloadSuccess:(NSMutableArray*)arguments; 
-(void) downloadFail:(NSMutableArray*)arguments; 

-(NSMutableDictionary*) createFileTransferError:(NSString*)code AndSource:(NSString*)source AndTarget:(NSString*)target;
@end

