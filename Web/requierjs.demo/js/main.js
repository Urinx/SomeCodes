require.config({
	  // By default load any module IDs from js/lib
	  baseUrl:'js/lib',
	  // except, if the module ID starts with "app",
    // load it from the js/app directory. paths
    // config is relative to the baseUrl, and
    // never includes a ".js" extension since
    // the paths config could be for a directory.
    paths:{
        jquery:[
            'jquery-2.1.1.min',
            'jquery-2.1.1',
            '//cdnjs.cloudflare.com/ajax/libs/jquery/2.0.0/jquery.min.js'
        ],
    	app:'../app'
    }
});

// Start the main app logic.
require(['jquery','canvasjs','backbone','app/bar'],function($,canvasjs,backbone,bar){
	  // jQuery, canvas and the app/bar module are all
    // loaded and can be used here now.

    $(document).ready(function(){
        $(document.body).css( "background", "#232323" );
        bar.test();
    });
});