#= require jquery
#= require jquery_ujs
#= require AC_OETags.min.js
#= require cytoscapeweb.min.js
#= require json2.min.js

$ ->
  form_serialize = ->
    params = $('#branch_selection_form').serialize()
    if not $('input#all').attr('checked') then params += '&all=false'
    params

  refresh = ->
    uri = '/?' + form_serialize()
    window.location = uri
    false

  detail_close = ->
    $('div#detail').hide()
    false

  $('select#repo').change(refresh)
  $('select#branch').change(refresh)
  $('input#all').change(refresh)
  $('input#max_count').change(refresh)
  $("div#detail").dblclick(detail_close)

  div_id = "tree"

  visual_style = {
    "global": { 'tooltipDelay': 500 }
    'nodes': {
      'shape'                  : { 'passthroughMapper' : { 'attrName' : "shape" } }
      'color'                  : { 'passthroughMapper' : { 'attrName' : "color" } }
      'borderColor'            : { 'passthroughMapper' : { 'attrName' : "borderColor" } }
      'borderWidth'            : 4
      'size'                   : { 'passthroughMapper' : { 'attrName' : "size" } }
      'opacity'                : { 'passthroughMapper' : { 'attrName' : "opacity" } }
      'hoverGlowColor'         : "#FF3333"
      'labelFontColor'         : { 'passthroughMapper' : { 'attrName' : "labelFontColor" } }
      'labelFontSize'          : { 'passthroughMapper' : { 'attrName' : "fontsize" } }
      'labelFontWeight'        : "bold"
      'labelHorizontalAnchor'  : { 'passthroughMapper' : { 'attrName' : "anchor" } }
      'labelVerticalAnchor'    : { 'passthroughMapper' : { 'attrName' : "v_anchor" } }
      'tooltipText'            : { 'passthroughMapper' : { 'attrName' : "tips" } }
      'tooltipFontSize'        : 14
      'tooltipFontColor'       : "#2D2D2D"
      'tooltipBackgroundColor' : "#EAF2F5"
      'tooltipBorderColor'     : "#666666"
    }
    'edges': {
      'width': 6
      'directed' : { 'passthroughMapper' : { 'attrName' : "directed" } }
      'style'    : { 'passthroughMapper' : { 'attrName' : "style" } }
      'color'    : { 'passthroughMapper' : { 'attrName' : "color" } }
      'opacity'  : { 'passthroughMapper' : { 'attrName' : "opacity" } }
    }
  }

  # initialization options
  options =
    # where you have the Cytoscape Web SWF
    'swfPath': "/swf/CytoscapeWeb"
    # where you have the Flash installer SWF
    'flashInstallerPath': "/swf/playerProductInstall"

  $.getJSON("/tree.json?" + form_serialize(),  (json) ->
    networ_json = {
      'dataSchema': {
        'nodes': [
          { 'name': "sha_1"          , 'type': "string" }
          { 'name': "label"          , 'type': "string" }
          { 'name': "shape"          , 'type': "string" }
          { 'name': "size"           , 'type': "number" }
          { 'name': "color"          , 'type': "string" }
          { 'name': "borderColor"    , 'type': "string" }
          { 'name': "labelFontColor" , 'type': "string" }
          { 'name': "anchor"         , 'type': "string" }
          { 'name': "v_anchor"       , 'type': "string" }
          { 'name': "fontsize"       , 'type': "number" }
          { 'name': "tips"           , 'type': "string" }
          { 'name': "opacity"        , 'type': "number" }
        ]
        'edges':[
          { 'name': "directed" , 'type': "boolean"}
          { 'name': "style"    , 'type': "string" }
          { 'name': "color"    , 'type': "string" }
          { 'name': "opacity"  , 'type': "number" }
        ]
      }
      'data': json["data"]
    }

    layout =
      'name': "Preset"
      'options':{
        'fitToScreen': false
        'points': json["points"]
      }

    # init and draw
    vis = new org.cytoscapeweb.Visualization(div_id, options)

    draw_options =
      'network': networ_json
      'layout':layout
      'visualStyle': visual_style
      'nodeTooltipsEnabled': true

    vis.draw(draw_options)
    vis.ready( ->
      vis.zoom(0.5)
      target_branch = "b_" + json["target_branch"] || 'master'
      target = vis.node(target_branch)
      vis.panBy( target.x * 0.95 , target.y * 0.7)
      vis.panEnabled(true)

      vis.addListener("click", "nodes",  (e) ->

        node = e.target
        sha_1 = node.data.sha_1
        if not sha_1
          return

        detail = $('div#detail')
        x = e.mouseX

        if x < ($('html').width() / 2 )
          detail.css('left', '45%')
        else
          detail.css('left', '0')

        commit_uri = '/commit/' + sha_1
        if $('select#repo').val()
          commit_uri += '?repo=' + $('select#repo').val()

        detail.load(commit_uri, ->
          detail.show()
          $('a#close').click(detail_close)
        )
      )
    )
  )
