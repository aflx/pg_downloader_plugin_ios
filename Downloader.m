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
// Copyright 2011 Alexander Heinrich All rights reserved.
//
// Thanks to Aaron K. Saunders
// http://blog.clearlyinnovative.com
//

#import "Downloader.h"
#import "File.h"


@implementation Downloader


-(PGPlugin*) initWithWebView:(UIWebView*)theWebView {
    self = (Downloader*)[super initWithWebView:theWebView];
    return self;
}

- (void) download:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options 
{
    NSLog(@"File Transfer downloading file...");
    
    [self performSelectorInBackground:@selector(downloadFile:) withObject:arguments];
}

-(void) downloadFile:(NSMutableArray*)arguments {
    NSString * callbackId = [arguments objectAtIndex:0];
    NSString * sourceUrl = [arguments objectAtIndex:1];
    NSString * filePath = [arguments objectAtIndex:2];
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:sourceUrl] ];
    NSArray * results = nil;
    
    NSLog(@"Write file %@", filePath);
    NSError *error=[[[NSError alloc]init] autorelease];
    
    @try {
        NSString * parentPath = [ filePath stringByDeletingLastPathComponent ];
        
        // check if the path exists => create directories if needed
        if(![[NSFileManager defaultManager] fileExistsAtPath:parentPath ]) [[NSFileManager defaultManager] createDirectoryAtPath:parentPath withIntermediateDirectories:YES attributes:nil error:nil];
        
    	BOOL response = [data writeToFile:filePath options:NSDataWritingFileProtectionNone error:&error];
        
        if ( response == NO ) {
        	// send our results back to the main thread
            results = [NSArray arrayWithObjects: callbackId, [NSString stringWithFormat:@"%d", INVALID_URL_ERR], sourceUrl, filePath, nil];
        	[self performSelectorOnMainThread:@selector(downloadFail:) withObject:results waitUntilDone:YES];
    	} else {
        	// jump back to main thread
            results = [NSArray arrayWithObjects: callbackId, filePath, nil];
        	[self performSelectorOnMainThread:@selector(downloadSuccess:) withObject:results waitUntilDone:YES];
    	}
    }
    @catch (id exception) {
        // jump back to main thread
        results = [NSArray arrayWithObjects: callbackId, [NSString stringWithFormat:@"%d", FILE_NOT_FOUND_ERR], sourceUrl, filePath, nil];
        [self performSelectorOnMainThread:@selector(downloadFail:) withObject:results waitUntilDone:YES];
    }
    
    [pool drain];
}

-(void) downloadSuccess:(NSMutableArray *)arguments 
{
    NSString * callbackId = [arguments objectAtIndex:0];
    NSString * filePath = [arguments objectAtIndex:1];

    BOOL bDirRequest = NO;

    NSLog(@"File Transfert Download success");
    
    PGFile * file = [[PGFile alloc] init];
    
    PluginResult* result = [PluginResult resultWithStatus: PGCommandStatus_OK messageAsDictionary: [file getDirectoryEntry: filePath isDirectory: bDirRequest] cast: @"window.localFileSystem._castEntry"];
    [self writeJavascript: [result toSuccessCallbackString:callbackId]];
}

-(void) downloadFail:(NSMutableArray *)arguments 
{
    NSString * callbackId = [arguments objectAtIndex:0];
    NSString * code = [arguments objectAtIndex:1];
    NSString * source = [arguments objectAtIndex:2];
    NSString * target = [arguments objectAtIndex:3];

    NSLog(@"File Transfer Error: %@", source);
    
    PluginResult* pluginResult = [PluginResult resultWithStatus:PGCommandStatus_OK messageAsDictionary: [self createFileTransferError:code AndSource:source AndTarget:target]];
                                    
    [self writeJavascript: [pluginResult toErrorCallbackString:callbackId]];
}

-(NSMutableDictionary*) createFileTransferError:(NSString*)code AndSource:(NSString*)source AndTarget:(NSString*)target
{
    NSMutableDictionary* result = [NSMutableDictionary dictionaryWithCapacity:3];
    [result setObject: code forKey:@"code"];
	[result setObject: source forKey:@"source"];
	[result setObject: target forKey:@"target"];
    
    return result;
}

- (void)dealloc {
    [super dealloc];
}


@end
