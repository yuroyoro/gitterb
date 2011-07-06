$(function(){
  $('select#branch').change(function(){
    window.location = '/?' + $('#branch_selection_form').serialize();
    return false;
  });

  var div_id = "tree";

  var visual_style = {
    "global": { 'tooltipDelay': 500 },
    'nodes': {
      'shape':{ 'passthroughMapper': { 'attrName': "shape" } },
      'color':{ 'passthroughMapper': { 'attrName': "color" } },
      'borderColor':{ 'passthroughMapper': { 'attrName': "borderColor" } },
      'borderWidth': 4,
      'size':{ 'passthroughMapper': { 'attrName': "size" } },
      'opacity':{ 'passthroughMapper': { 'attrName': "opacity" } },
      'hoverGlowColor': "#FF3333",
      'labelFontColor': "#2D2D2D",
      'labelFontSize':{ 'passthroughMapper': { 'attrName': "fontsize" } },
      'labelFontWeight': "bold",
      'labelHorizontalAnchor':{ 'passthroughMapper': { 'attrName': "anchor" } },
      'labelVerticalAnchor':"middle",
      'tooltipText':{ 'passthroughMapper': { 'attrName': "tips" } },
      'tooltipFontSize': 14,
      'tooltipFontColor':"#2D2D2D",
      'tooltipBackgroundColor':"#FFFFDD",
      'tooltipBorderColor':"#666666"
    },
    'edges': {
      'width': 6,
      'directed':{ 'passthroughMapper': { 'attrName': "directed" } },
      'style':{ 'passthroughMapper': { 'attrName': "style" } },
      'opacity':{ 'passthroughMapper': { 'attrName': "opacity" } }
    }
  };

  // initialization options
  var options = {
      // where you have the Cytoscape Web SWF
      'swfPath': "/swf/CytoscapeWeb",
      // where you have the Flash installer SWF
      'flashInstallerPath': "/swf/playerProductInstall",
  };

  $.getJSON("/tree.json?" + $('#branch_selection_form').serialize(),  function(json){
    var networ_json = {
      'dataSchema': {
        'nodes': [ { 'name': "label",  'type': "string" },
                 { 'name': "shape",  'type': "string" },
                 { 'name': "size",   'type': "number" },
                 { 'name': "color",  'type': "string" },
                 { 'name': "borderColor",  'type': "string" },
                 { 'name': "anchor", 'type': "string" },
                 { 'name': "fontsize", 'type': "number" },
                 { 'name': "tips" ,  'type': "string" },
                 { 'name': "opacity",  'type': "number" }
        ],
        'edges':[ { 'name': "directed", 'type': "boolean"},
                { 'name': "style",    'type': "string" },
                { 'name': "opacity",  'type': "number" }
        ]
      },
      'data': json["data"]
    };

    var layout = {
      'name': "Preset",
      'options':{
        'fitToScreen': false,
        'points': json["points"]
      }
    };

    // init and draw
    var vis = new org.cytoscapeweb.Visualization(div_id, options);
    vis.draw({
      'network': networ_json,
      'layout':layout,
      'visualStyle': visual_style,
      'nodeTooltipsEnabled': true,
    });
    vis.ready(function(){
      vis.zoom(0.5);
      var target_branch = json["target_branch"] || 'master';
      var target = vis.node(target_branch);
      vis.panBy( target.x * 0.95 , target.y * 0.7);
      vis.panEnabled(true);
    });


  });
});
