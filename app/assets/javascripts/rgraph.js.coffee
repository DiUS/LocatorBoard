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
      lineWidth: 0.5,
      alpha: 0.3

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
      if (node._depth > 1)
        style.display = 'none'
      else
        style.cursor = 'pointer'
        style.color = "#FFFFFF"
        alpha = 1 - (2 * node._depth / 10)
        style.opacity = alpha
        style.fontSize = "#{if node._depth is 0 then 0.8 else 0.5}em";



      left = parseInt(style.left)
      w = domElement.offsetWidth
      style.left = (left - w / 2) + 'px'
  )

  # init data
  $.getJSON("/data.json", {}, (data) ->

    _(data.data).each (item) ->
      console.log item
      id1 = _(item.user1).classify()
      node = rgraph.graph.getNode(id1)
      if not node
        rgraph.graph.addNode(id: id1, name: item.user1, item)
      id2 = _(item.user2).classify()
      node2 = rgraph.graph.getNode(id2)
      if not node2
        rgraph.graph.addNode(id: id2, name: item.user2, item)
      if not rgraph.graph.getAdjacence(id1, id2)
        rgraph.graph.addAdjacence({ 'id': id1 }, { 'id': id2}, null)

      if not rgraph.root
        rgraph.root = id1

    rgraph.refresh()

#    rgraph.compute('end')
    rgraph.fx.animate(modes:['polar'], duration: 2000)
  )

