$(function(){
  var div_id = "tree";

  var visual_style = {
    global: { tooltipDelay: 500 },
    nodes: {
      shape:{ passthroughMapper: { attrName: "shape" } },
      color:{ passthroughMapper: { attrName: "color" } },
      borderWidth: 4,
      borderColor: "#2D2D2D",
      size:{ passthroughMapper: { attrName: "size" } },
      opacity:{ passthroughMapper: { attrName: "opacity" } },
      hoverGlowColor: "#FF3333",
      labelFontColor: "#2D2D2D",
      labelFontSize:{ passthroughMapper: { attrName: "fontsize" } },
      labelFontWeight: "bold",
      labelHorizontalAnchor:{ passthroughMapper: { attrName: "anchor" } },
      labelVerticalAnchor:"middle",
      tooltipText:{ passthroughMapper: { attrName: "tips" } },
      tooltipFontSize: 14,
      tooltipFontColor:"#2D2D2D",
      tooltipBackgroundColor:"#FFFFDD",
      tooltipBorderColor:"#666666"
    },
    edges: {
      width: 6,
      directed:{ passthroughMapper: { attrName: "directed" } },
      style:{ passthroughMapper: { attrName: "style" } },
      opacity:{ passthroughMapper: { attrName: "opacity" } }
    }
  };

  // initialization options
  var options = {
      // where you have the Cytoscape Web SWF
      swfPath: "/swf/CytoscapeWeb",
      // where you have the Flash installer SWF
      flashInstallerPath: "/swf/playerProductInstall",
  };

  var layout = {
    name: "Tree",
    options:{ orientation : "leftToRight" }
  };

  $.getJSON("/tree.json",  function(json){
    var networ_json = {
      dataSchema: {
        nodes: [ { name: "label",  type: "string" },
                 { name: "shape",  type: "string" },
                 { name: "size",   type: "number" },
                 { name: "color",  type: "string" },
                 { name: "anchor", type: "string" },
                 { name: "fontsize", type: "number" },
                 { name: "tips" ,  type: "string" },
                 { name: "opacity",  type: "number" }
        ],
        edges:[ { name: "directed", type: "boolean"},
                { name: "style",    type: "string" },
                { name: "opacity",  type: "number" }
        ]
      },
      data: json
    };

    // init and draw
    var vis = new org.cytoscapeweb.Visualization(div_id, options);
    vis.draw({
      network: networ_json,
      layout:layout,
      visualStyle: visual_style,
      nodeTooltipsEnabled: true,
    });
    vis.ready(function(){
      vis.zoom(0.5);
      master = vis.node('master');
      console.log(master);
      vis.panBy( master.x / 2, 0);
      vis.panEnabled(true);
    });


  });
});
