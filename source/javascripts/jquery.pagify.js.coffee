# jQuery Pagify Plugin
# http://github.com/camerond/jquery-pagify
# version 0.5.1
#
# Copyright (c) 2013 Cameron Daigle, http://camerondaigle.com
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(($) ->

  pagify =
    name: 'pagify'
    append_controls: 'after'
    show_pagecontrols: true
    show_nextprev: true
    next_label: 'next'
    prev_label: 'prev'
    current_page: 1
    per_page: 5
    getAllControls: ->
      $c = @$controls
      @$secondary_controls && $c.add(@$secondary_controls)
      $c
    addEvents: ->
      @getAllControls()
        .on('click', ".#{@name}_next a", $.proxy(@goNext, @))
        .on('click', ".#{@name}_prev a", $.proxy(@goPrev, @))
        .on('click', ".#{@name}_page a", $.proxy(@clickPage, @))
    countPages: ->
      Math.ceil(@$el.children().length / @per_page)
    createControls: ->
      @$controls = $("<nav class='#{@name}_controls'><ul></ul></nav>");
      $ul = @$controls.find("ul")
      for i in [1..@total_pages]
        $ul.append($("<li class='#{@name}_page'><a href='#'>#{i}</a></li>"))
      if @append_controls == 'both'
        @$el.after(@$controls)
        @$secondary_controls = @$controls.clone(true)
        @$el.before(@$secondary_controls)
      else
        @$el[@append_controls](@$controls)
    createNextPrev: ->
      @$next = $("<li />")
        .addClass("#{@name}_next")
        .append($("<a />"), text: @next_label)
      @$prev = $("<li />")
        .addClass("#{@name}_prev")
        .append($("<a />"), text: @prev_label)
      @$controls.find("ul").append(@$next).prepend(@$prev)
    navigateTo: (page) ->
      idx = @per_page * (page - 1)
      @getAllControls()
        .find("li.#{@name}_page").removeClass("#{@name}_active")
        .eq(page - 1).addClass("#{@name}_active")
      @$el
        .children().hide()
        .slice(idx, idx + @per_page).show()
      @current_page = page
    clickPage: (e) ->
      e.stopPropagation()
      @navigateTo($(e.target).text())
    goNext: (e) ->
      e.stopPropagation()
      if @current_page < @total_pages
        @navigateTo(@current_page + 1)
    goPrev: (e) ->
      e.stopPropagation()
      if @current_page > 1
        @navigateTo(@current_page - 1)
    refresh: ->
      p = $(this).data(pagify.name)
      p.getAllControls().off(".#{p.name}").remove()
      p.init()
    init: ->
      @total_pages = @countPages()
      @show_pagecontrols && @createControls()
      @show_nextprev && @createNextPrev()
      @addEvents()
      @navigateTo(@current_page)

  $.fn[pagify.name] = (opts) ->
    $els = @
    method = if $.isPlainObject(opts) or !opts then '' else opts
    if method and pagify[method]
      pagify[method].apply($els, Array.prototype.slice.call(arguments, 1))
    else if !method
      $els.each ->
        plugin_instance = $.extend(
          true,
          $el: $(@),
          pagify,
          opts
        )
        $(@).data(pagify.name, plugin_instance)
        plugin_instance.init()
    else
      $.error('Method #{method} does not exist on jQuery. #{pagify.name}');
    return $els;

)(jQuery)