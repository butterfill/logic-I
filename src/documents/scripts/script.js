---
---

/**
 * (c) 2013 Stephen A. Butterfill
 * 
 */


$(function() {
  // Deck initialization
  $.deck('.slide', {
    fitMode: "center middle",
    designWidth: 800,
    designHeight: 600,
    fitMarginX: 0,
    fitMarginY: 0
  });
});

/**
 * jsPlumb defaults
 */
jsPlumb.Defaults.PaintStyle = {
  lineWidth:2,
  strokeStyle: 'rgba(255,255,0,1)',
  outlineColor: 'black',
  outlineWidth: 1
}
jsPlumb.Defaults.Endpoints = [
  ["Dot", {radius:3}],
  ["Dot", {radius:3}]
]

//- DOESNT WORK
$(document).ready(function(){
  jsPlumb.ready(function(){

    jsPlumb.importDefaults({
      PaintStyle : {
        lineWidth:2,
        strokeStyle: 'rgba(255,255,0,1)',
        outlineColor: 'black',
        outlineWidth: 1
      }
    })
    
  })
})
