/**
 * aflx - always flexible
 * http://www.aflx.de
 * ak@aflx.de
 * 
 * Copyright 2011 Alexander Keller
 * All Rights Reserved.
 */

function Downloader() {
}
 
Downloader.prototype.downloadFile = function(fileUrl, dirName, fileName, overwrite, win, fail) {
	if(overwrite == false) {
		overwrite = "false";
	} else {
		overwrite = "true";
	}
		
    console.log("downloadFile(" + fileUrl + ", " + dirName + fileName + ")");
    
	PhoneGap.exec(win, fail, "Downloader", "downloadFile", [fileUrl, dirName + fileName]);
};
 
PhoneGap.addConstructor(function() {
	//PhoneGap.addPlugin("downloader", new Downloader());
});
