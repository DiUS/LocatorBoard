ua = navigator.userAgent
iStuff = ua.match(/iPhone/i) || ua.match(/iPad/i)
typeOfCanvas = typeof HTMLCanvasElement
nativeCanvasSupport = (typeOfCanvas == 'object' || typeOfCanvas == 'function')
textSupport = nativeCanvasSupport && (typeof document.createElement('canvas').getContext('2d').fillText == 'function')

#  I'm setting this based on the fact that ExCanvas provides text support for IE
#  and that as of today iPhone/iPad current text support is lame
labelType = (!nativeCanvasSupport || (textSupport && !iStuff)) ? 'Native': 'HTML';
nativeTextSupport = labelType == 'Native';
useGradients = nativeCanvasSupport;
animate = !(iStuff || !nativeCanvasSupport);

this.initRGraph = ->
  graph = '[{id:"190_0", adjacencies:["node0"]}, {id:"node0", name:"node0 name", data:{"some other key":"some other value"}, adjacencies:["node1", "node2", "node3", "node4", "node5"]}, {id:"node1", name:"node1 name", data:{"some other key":"some other value"}, adjacencies:["node0", "node2", "node3", "node4", "node5"]}, {id:"node2", name:"node2 name", data:{"some other key":"some other value"}, adjacencies:["node0", "node1", "node3", "node4", "node5"]}, {id:"node3", name:"node3 name", data:{"some other key":"some other value"}, adjacencies:["node0", "node1", "node2", "node4", "node5"]}, {id:"node4", name:"node4 name", data:{"some other key":"some other value"}, adjacencies:["node0", "node1", "node2", "node3", "node5"]}, {id:"node5", name:"node5 name", data:{"some other key":"some other value"}, adjacencies:["node0", "node1", "node2", "node3", "node4"]}, {id:"4619_46", adjacencies:["190_0"]}, {id:"236585_30", adjacencies:["190_0"]}, {id:"131161_18", adjacencies:["190_0"]}, {id:"41529_12", adjacencies:["190_0"]}]'
  rgraph = new $jit.RGraph(
    injectInto: 'infovis'
  # Optional: Create a background canvas
  # for painting concentric circles.
    background:
      CanvasStyles:
        'strokeStyle': '#555'
        'shadowBlur': 50
        'shadowColor': '#ccc'
  # Set Edge and Node colors.
    Node:
      color: '#ddeeff'
      overridable: true
    Edge:
      overridable: true
      color: '#C17878'
      lineWidth: 1.5

    # Add navigation capabilities:
    # zooming by scrolling and panning.
    Navigation:
      enable: true
      panning: true
      zooming: 10

  # Add the node's name into the label
  # This method is called only once, on label creation.
    onCreateLabel: (domElement, node) ->
      domElement.innerHTML = node.name
      domElement.onclick = -> rgraph.onClick(node.id)

  # Change the node's style based on its position.
  # This method is called each time a label is rendered/positioned
  # during an animation.
    onPlaceLabel: (domElement, node) ->
      style = domElement.style
      style.display = ''
      style.cursor = 'pointer'

      if node._depth <= 1
        style.fontSize = "0.8em"
        style.color = "#ccc"
      else if node._depth == 2
        style.fontSize = "0.7em"
        style.color = "#494949"
      else
        style.fontSize = "0.5em"
        style.color = "#393939"

      left = parseInt(style.left)
      w = domElement.offsetWidth
      style.left = (left - w / 2) + 'px'
  )

  # init data
  $.get('/rgraph.json', (data) ->
    console.log data
    rgraph.loadJSON(data)

    # add some extra edges to the tree
    # to make it a graph (just for fun)
    rgraph.graph.addAdjacence(
      { 'id': '236585_30' }
      { 'id': '236583_23'}, null)
    rgraph.graph.addAdjacence({ 'id': '236585_30'}, {'id': '4619_46'}, null)

    # Compute positions and plot
    rgraph.refresh()

    rgraph.compute('end')
    rgraph.fx.animate(modes:['polar'], duration: 2000)
  )

