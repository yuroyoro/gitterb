$(function(){
  var form_serialize = function(){
    var params = $('#branch_selection_form').serialize();
    if( ! $('input#all').attr('checked') ) {
      params += '&all=false'
    }
    return params;
  };

  var refresh = function(){
    var uri = '/?' + form_serialize();
    window.location = uri;
    return false;
  };

  $('select#repo').change(refresh);
  $('select#branch').change(refresh);
  $('input#all').change(refresh);
  $('input#max_count').change(refresh);

  var detail_close = function(){
    $('div#detail').hide();
    return false;
  };

  $("div#detail").dblclick(detail_close);

  var div_id = "tree";

  var visual_style = {
    "global": { 'tooltipDelay': 500 },
    'nodes': {
      'shape'                  : { 'passthroughMapper' : { 'attrName' : "shape" } },
      'color'                  : { 'passthroughMapper' : { 'attrName' : "color" } },
      'borderColor'            : { 'passthroughMapper' : { 'attrName' : "borderColor" } },
      'borderWidth'            : 4,
      'size'                   : { 'passthroughMapper' : { 'attrName' : "size" } },
      'opacity'                : { 'passthroughMapper' : { 'attrName' : "opacity" } },
      'hoverGlowColor'         : "#FF3333",
      'labelFontColor'         : { 'passthroughMapper' : { 'attrName' : "labelFontColor" } },
      'labelFontSize'          : { 'passthroughMapper' : { 'attrName' : "fontsize" } },
      'labelFontWeight'        : "bold",
      'labelHorizontalAnchor'  : { 'passthroughMapper' : { 'attrName' : "anchor" } },
      'labelVerticalAnchor'    : { 'passthroughMapper' : { 'attrName' : "v_anchor" } },
      'tooltipText'            : { 'passthroughMapper' : { 'attrName' : "tips" } },
      'tooltipFontSize'        : 14,
      'tooltipFontColor'       : "#2D2D2D",
      'tooltipBackgroundColor' : "#EAF2F5",
      'tooltipBorderColor'     : "#666666"
    },
    'edges': {
      'width': 6,
      'directed' : { 'passthroughMapper' : { 'attrName' : "directed" } },
      'style'    : { 'passthroughMapper' : { 'attrName' : "style" } },
      'opacity'  : { 'passthroughMapper' : { 'attrName' : "opacity" } }
    }
  };

  // initialization options
  var options = {
      // where you have the Cytoscape Web SWF
      'swfPath': "/swf/CytoscapeWeb",
      // where you have the Flash installer SWF
      'flashInstallerPath': "/swf/playerProductInstall",
  };

  $.getJSON("/tree.json?" + form_serialize(),  function(json){
    var networ_json = {
      'dataSchema': {
        'nodes': [
          { 'name': "sha_1"          , 'type': "string" } ,
          { 'name': "label"          , 'type': "string" } ,
          { 'name': "shape"          , 'type': "string" } ,
          { 'name': "size"           , 'type': "number" } ,
          { 'name': "color"          , 'type': "string" } ,
          { 'name': "borderColor"    , 'type': "string" } ,
          { 'name': "labelFontColor" , 'type': "string" } ,
          { 'name': "anchor"         , 'type': "string" } ,
          { 'name': "v_anchor"       , 'type': "string" } ,
          { 'name': "fontsize"       , 'type': "number" } ,
          { 'name': "tips"           , 'type': "string" } ,
          { 'name': "opacity"        , 'type': "number" }
        ],
        'edges':[
          { 'name': "directed" , 'type': "boolean"} ,
          { 'name': "style"    , 'type': "string" } ,
          { 'name': "opacity"  , 'type': "number" }
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
      var target_branch = "b_" + json["target_branch"] || 'master';
      var target = vis.node(target_branch);
      vis.panBy( target.x * 0.95 , target.y * 0.7);
      vis.panEnabled(true);

      vis.addListener("click", "nodes",  function(e){
        var node = e.target;
        var sha_1 = node.data.sha_1;
        var detail = $('div#detail');
        var x = e.mouseX;
        if( x < ($('html').width() / 2 ) ){
          detail.css('left', '50%');
        }else{
          detail.css('left', '0');
        }
        detail.load('/commit/' + sha_1, function(){
          detail.show();
          $('a#close').click(detail_close);
        });

      });

    });


  });
});
