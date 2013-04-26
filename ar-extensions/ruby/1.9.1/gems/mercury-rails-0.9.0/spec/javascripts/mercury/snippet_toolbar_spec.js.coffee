describe "Mercury.SnippetToolbar", ->

  template 'mercury/snippet_toolbar.html'

  beforeEach ->
    $.fx.off = true

  afterEach ->
    @snippetToolbar = null
    delete(@snippetToolbar)
    $(window).unbind('mercury:hide:toolbar')
    $(window).unbind('mercury:show:toolbar')

  describe "constructor", ->

    beforeEach ->
      spyOn(Mercury.SnippetToolbar.prototype, 'build').andCallFake(=>)
      spyOn(Mercury.SnippetToolbar.prototype, 'bindEvents').andCallFake(=>)

    it "expects document", ->
      @snippetToolbar = new Mercury.SnippetToolbar($('document'))
      expect(@snippetToolbar.document).toEqual($('document'))

    it "accepts options", ->
      @snippetToolbar = new Mercury.SnippetToolbar($('document'))
      expect(@snippetToolbar.document).toEqual($('document'))


  describe "#build", ->

    it "builds an element", ->
      @snippetToolbar = new Mercury.SnippetToolbar($('document'), {appendTo: '#test'})
      html = $('<div>').html(@snippetToolbar.element).html()
      expect(html).toContain('class="mercury-toolbar mercury-snippet-toolbar"')
      expect(html).toContain('style="display:none"')

    it "appends to any element", ->
      @snippetToolbar = new Mercury.SnippetToolbar($('document'), {appendTo: '#snippet_toolbar_container'})
      expect($('#snippet_toolbar_container .mercury-toolbar').length).toEqual(1)


  describe "observed events", ->

    beforeEach ->
      @snippetToolbar = new Mercury.SnippetToolbar($('document'), {appendTo: '#test'})

    describe "custom event: show:toolbar", ->

      it "does nothing if there's no snippet", ->
        spy = spyOn(Mercury.SnippetToolbar.prototype, 'show').andCallFake(=>)
        Mercury.trigger('show:toolbar', {snippet: null})
        expect(spy.callCount).toEqual(0)

      it "calls show", ->
        spy = spyOn(Mercury.SnippetToolbar.prototype, 'show').andCallFake(=>)
        Mercury.trigger('show:toolbar', {snippet: $('#snippet')})
        expect(spy.callCount).toEqual(1)

    describe "custom event: hide:toolbar", ->

      it "does nothing if it's not for the snippet toolbar", ->
        spy = spyOn(Mercury.SnippetToolbar.prototype, 'hide').andCallFake(=>)
        Mercury.trigger('hide:toolbar', {type: 'foo'})
        expect(spy.callCount).toEqual(0)

      it "calls hide", ->
        spy = spyOn(Mercury.SnippetToolbar.prototype, 'hide').andCallFake(=>)
        Mercury.trigger('hide:toolbar', {type: 'snippet'})
        expect(spy.callCount).toEqual(1)

    describe "mousemove", ->

      it "clears the hide timeout", ->
        spy = spyOn(window, 'clearTimeout').andCallFake(=>)
        jasmine.simulate.mousemove($('#test .mercury-snippet-toolbar').get(0))
        expect(spy.callCount).toEqual(1)

    describe "mouseout", ->

      it "calls hide", ->
        spy = spyOn(Mercury.SnippetToolbar.prototype, 'hide').andCallFake(=>)
        jasmine.simulate.mouseout($('#test .mercury-snippet-toolbar').get(0))
        expect(spy.callCount).toEqual(1)

    describe "releasing events", ->

      it 'makes the following events releasable', ->
        events = (eventName for [target, eventName, handler] in @snippetToolbar._boundEvents)
        expect(events).toEqual(['show:toolbar', 'hide:toolbar', 'scroll'])

      it 'calls off to unbind the events on release', ->
        targets = (target for [target, eventName, handler] in @snippetToolbar._boundEvents)
        # we bind to Mercury twice so pop the first one off for spying
        targets.shift()
        spys = (spyOn(target, 'off') for target in targets)
        @snippetToolbar.release()
        expect(spy).toHaveBeenCalled() for spy in spys

  describe "#show", ->

    beforeEach ->
      @snippetToolbar = new Mercury.SnippetToolbar($('document'), {appendTo: '#test'})
      @positionSpy = spyOn(Mercury.SnippetToolbar.prototype, 'position').andCallFake(=>)
      @appearSpy = spyOn(Mercury.SnippetToolbar.prototype, 'appear').andCallFake(=>)

    it "expects a snippet", ->
      @snippetToolbar.show({snippet: 'foo'})
      expect(@snippetToolbar.snippet).toEqual({snippet: 'foo'})

    it "calls position", ->
      @snippetToolbar.show()
      expect(@positionSpy.callCount).toEqual(1)

    it "calls appear", ->
      @snippetToolbar.show()
      expect(@appearSpy.callCount).toEqual(1)


  describe "#position", ->

    beforeEach ->
      Mercury.displayRect = {top: 20}
      @snippetToolbar = new Mercury.SnippetToolbar($('document'), {appendTo: '#test', visible: true})
      @snippetToolbar.snippet = $('#snippet')

    it "positions itself based on the snippet", ->
      @snippetToolbar.element.show()
      @snippetToolbar.position()
      # use a tolerance since there are measurement differences between browsers we want it between 14-18
      expect(@snippetToolbar.element.offset().top).toBeLessThan(19)
      expect(@snippetToolbar.element.offset().top).toBeGreaterThan(13)
      expect(@snippetToolbar.element.offset().left).toEqual(200)


  describe "#appear", ->

    beforeEach ->
      @snippetToolbar = new Mercury.SnippetToolbar($('document'), {appendTo: '#test'})

    it "clears the hide timeout", ->
      spy = spyOn(window, 'clearTimeout').andCallFake(=>)
      @snippetToolbar.appear()
      expect(spy.callCount).toEqual(1)

    it "sets visible", ->
      @snippetToolbar.appear()
      expect(@snippetToolbar.visible).toEqual(true)

    it "shows the element", ->
      @snippetToolbar.appear()
      expect(@snippetToolbar.element.css('display')).toEqual('block')


  describe "#hide", ->

    beforeEach ->
      @snippetToolbar = new Mercury.SnippetToolbar($('document'), {appendTo: '#test'})

    afterEach -> @snippetToolbar.release()

    it "it clears the hide timeout", ->
      spy = spyOn(window, 'clearTimeout').andCallFake(=>)
      @snippetToolbar.hide()
      expect(spy.callCount).toEqual(1)

    describe "immediately", ->

      beforeEach ->
        @snippetToolbar.element.show()

      it "hides the element", ->
        @snippetToolbar.hide(true)
        expect(@snippetToolbar.element.css('display')).toEqual('none')

      it "sets visible", ->
        @snippetToolbar.visible = true
        @snippetToolbar.hide(true)
        expect(@snippetToolbar.visible).toEqual(false)

    describe "not immediately", ->

      beforeEach ->
        @snippetToolbar.element.show()
        @setTimeoutSpy = spyOn(window, 'setTimeout')

      it "sets a timeout", ->
        @setTimeoutSpy.andCallFake(=>)
        @snippetToolbar.hide()
        expect(@setTimeoutSpy.callCount).toEqual(1)

      it "hides the element", ->
        @setTimeoutSpy.andCallFake((callback, timeout) => callback())
        @snippetToolbar.hide()
        expect(@snippetToolbar.element.css('display')).toEqual('none')

      it "sets visible", ->
        @setTimeoutSpy.andCallFake((callback, timeout) => callback())
        @snippetToolbar.hide()
        expect(@snippetToolbar.visible).toEqual(false)

