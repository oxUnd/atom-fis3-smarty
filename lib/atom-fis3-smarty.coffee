AtomFis3SmartyView = require './atom-fis3-smarty-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomFis3Smarty =
  atomFis3SmartyView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomFis3SmartyView = new AtomFis3SmartyView(state.atomFis3SmartyViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomFis3SmartyView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-fis3-smarty:hello' : => @hello()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomFis3SmartyView.destroy()

  serialize: ->
    atomFis3SmartyViewState: @atomFis3SmartyView.serialize()

  hello: ->
    console.log 'hello'
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
