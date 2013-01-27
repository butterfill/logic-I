/**
 * A phantomjs script (version 1.2 only) to 
 * convert a deck.js presentation to png files
 *
 * based on a similar idea in slipp, see
 *   https://github.com/Seldaek/slippy/blob/master/bin/phantom-slippy-to-pdf.js
 *
 * Stephen A. Butterfill, 2011
 */


var _current=0, slides, viewport, output;

// settings
viewport = { width: 1024, height: 768};

// check args supplied
if (phantom.args.length !== 2) {
    console.log('Usage: supply two parameters, input-file output-dirname');
    phantom.exit();
} 
   
var page = new WebPage();
page.viewportSize = viewport;
console.log('opening page');
page.open(phantom.args[0], function(status){
    if( status === "failed" ) {
        console.log("page open failed");
        phantom.exit();
    }
    
    console.log('rendering ...');
    window.setTimeout(function(){
        _current = 1;
        var slides = page.evaluate(function(){
            return window.$.deck('getSlides').length;
        });
        output = phantom.args[1];

        for (;_current<=slides;_current++) {
            console.log('rendering slide '+_current+' to png');
            page.render(output+'slide'+"000".substring(_current.toString().length)+_current+'.png');
            page.evaluate(function(){
                window.$.deck('next');
            });
        }
        console.log('done');

        phantom.exit();

    }, 500);
    

});



