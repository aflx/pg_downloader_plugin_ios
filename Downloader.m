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

#import "Downloader.h"


@implementation Downloader

@synthesize callbackID;


-(PGPlugin*) initWithWebView:(UIWebView*)theWebView {
    self = (Downloader*)[super initWithWebView:theWebView];
    return self;
}

//
// This function is called via PhoneGap.exec
//
-(void) downloadFile:(NSMutableArray*)paramArray withDict:(NSMutableDictionary*)options {
    self.callbackID = [paramArray pop];
    
    NSLog(@"Downloading file...",nil);
    
    [self performSelectorInBackground:@selector(download:) withObject:paramArray];
}

//
// Download and the the file
//
-(void) download:(NSMutableArray*)paramArray {
    NSString * sourceUrl = [paramArray objectAtIndex:0];
    NSString * dirName = [paramArray objectAtIndex:1];
    NSString * fileName = [paramArray objectAtIndex:2];
    NSString * filePath = [dirName stringByAppendingString:fileName ];
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:sourceUrl] ];
    
    NSLog(@"Write file %@", filePath);
    NSError *error=[[[NSError alloc]init] autorelease];
    
    @try {
    	BOOL response = [data writeToFile:filePath options:NSDataWritingFileProtectionNone error:&error];
        
        if ( response == NO ) {
        	// send our results back to the main thread
        	[self performSelectorOnMainThread:@selector(fail:) withObject:[error description] waitUntilDone:YES];
    	} else {
        	// jump back to main thread
        	[self performSelectorOnMainThread:@selector(success:) withObject:filePath waitUntilDone:YES];
    	}
        
    	[pool drain];
    }
    @catch (id exception) {
        NSLog(@"Exception %@", [error description]);
            
        // jump back to main thread
        [self performSelectorOnMainThread:@selector(fail:) withObject:[error description] waitUntilDone:YES];
    	[pool drain];
    }
}

//
// Call the plugin success function
//
-(void) success:(NSMutableString *)filePath {
    NSLog(@"Success", nil);
    
    PluginResult* pluginResult = [PluginResult resultWithStatus:PGCommandStatus_OK messageAsString: 
                                    [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self writeJavascript: [pluginResult toSuccessCallbackString:self.callbackID]];
}

//		
// Call the plugin failure function
//
-(void) fail:(NSMutableString *)errorStr {
    NSLog(@"Error: %@", [errorStr description]);
    
    PluginResult* pluginResult = [PluginResult resultWithStatus:PGCommandStatus_OK messageAsString: 
                                    [errorStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self writeJavascript: [pluginResult toErrorCallbackString:self.callbackID]];
    
}

- (void)dealloc {
    //if (params) {
//        [params release];
//    }
    [super dealloc];
}


@end
