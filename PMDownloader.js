PMDownloader = function() {
};

PMDownloader.prototype.download = function(success, fail, params) {
	var me = this;
	var fileUrl = params[0];
	var fileName = params[1];
	
	// NOTICE: 	If you enable this, the file content will be loaded to a variable!
	// 			Do not enable this, if the file is to big!
	if (Phonemock.enableDownload) {
		var xhr; 
	    try {
	    	xhr = new ActiveXObject('Msxml2.XMLHTTP');   
	    } catch (e) {
	        try {   
	        	xhr = new ActiveXObject('Microsoft.XMLHTTP');    
	        } catch (e2) {
	        	try { 
	        		xhr = new XMLHttpRequest();     
	        	} catch (e3) {  
	        		xhr = false;   
	        	}
	        }
	     }
	    
		xhr.overrideMimeType('text/plain; charset=x-user-defined');
	    xhr.onreadystatechange = function() {
	    	if(xhr.readyState == 4) {
	        	if (xhr.responseText) {
	        		var file = new PMFile();
	        		file.write(
	        			function() {
		        			Phonemock.success(success, fileName);
		        		}, 
		        		function() {
		    	        	Phonemock.fail(fail, error);
		        		}, 
		        		[fileName, xhr.responseText]
	        		);
		        } else {
		        	Phonemock.fail(fail, error);
		        }
	        }
	    }; 
	
	   xhr.open("GET", fileUrl, XMLHttpRequest.SYNC); 
	   xhr.send(null); 
	} else {
		// Write a dummy file.
		var file = new PMFile();
        file.write(
            function() {
                Phonemock.success(success, fileName);
            }, 
            function() {
                Phonemock.fail(fail, error);
            }, 
            [fileName, "Content of " + fileName]
        );
	}
		
};