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
 
Downloader.prototype.downloadFile = function(sourceUrl, filePath, successCallback, errorCallback) {
	PhoneGap.exec(successCallback, errorCallback, 'Downloader', 'download', [sourceUrl, filePath]);
};
