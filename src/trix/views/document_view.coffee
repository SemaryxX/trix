#= require trix/views/block_view

{defer} = Trix.Helpers
{walkTree} = Trix.DOM

class Trix.DocumentView extends Trix.ObjectView
  constructor: ->
    super
    @document = @object
    {@element} = @options

  render: ->
    @childViews = []

    @element.removeChild(@element.lastChild) while @element.lastChild

    unless @document.isEmpty()
      objects = Trix.ObjectGroup.groupObjects(@document.getBlocks(), asTree: true)
      for object in objects
        view = @findOrCreateCachedChildView(Trix.BlockView, object)
        @element.appendChild(node) for node in view.getNodes()

    @didRender()

  didRender: ->
    defer => @garbageCollectCachedViews()

  focus: ->
    @element.focus()
