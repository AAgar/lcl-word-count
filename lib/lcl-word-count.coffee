LclWordCountView = require './lcl-word-count-view'
{CompositeDisposable} = require 'atom'

module.exports = LclWordCount =
  lclWordCountView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @lclWordCountView = new LclWordCountView(state.lclWordCountViewState)
    console.log @lclWordCountView
    @modalPanel = atom.workspace.addModalPanel(item: @lclWordCountView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'lcl-word-count:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @lclWordCountView.destroy()

  serialize: ->
    lclWordCountViewState: @lclWordCountView.serialize()

  toggle: ->

    console.log "im here"
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
    editor = atom.workspace.getActiveTextEditor()
    words = editor.getText().split(/\s+/).length
    @lclWordCountView.setCount(words)
    @modalPanel.show()
