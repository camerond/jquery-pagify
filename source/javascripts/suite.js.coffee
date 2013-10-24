(($) ->

  tester =
    generateItems: (num) ->
      for i in [1..num]
        @$el.append($("<div />").text("Item Number #{i}"))
    checkActivePage: (page) ->
      @$el.data("pagify").$controls.find(".pagify_active").shouldHaveText(page)
    checkItems: (str) ->
      ok true, "Checking for items #{str}"
      items = str.split(',')
      @$el.find(":visible").each (i) ->
        $(this).shouldHaveText("Item Number #{items[i]}")
    init: (opts, num) ->
      @$el = $("#test_items")
      @generateItems(num ?= 20)
      @$el.pagify(opts)

  $.fn.shouldBe = (attr) ->
    ok @.is(attr), "#{@.selector} should be #{attr}"
    @

  $.fn.shouldHaveText = (text) ->
    equal @.text(), text, "#{text} is displayed within #{@.selector}"
    @

  test "it is chainable", ->
    deepEqual(tester.init().pagify().hide().show(), $("#test_items"))

  test "it properly appends and associates pagination controls", ->
    $t = tester.init()
    $t.next().shouldBe("nav.pagify_controls")
    $t.data("pagify").$controls.shouldBe("nav.pagify_controls")

  test "it properly initializes to page 1 and shows items 1 through 5", ->
    $controls = tester.init().data("pagify").$controls
    equal $controls.find('li.pagify_page').length, 4, "20 elements, 5 per page = 4 pages"
    tester.checkActivePage(1)
    tester.checkItems('1,2,3,4,5')

  test "go to page by clicking its number", ->
    $controls = tester.init().data("pagify").$controls
    $controls.find(".pagify_page:eq(1) a").click()
    tester.checkActivePage(2)
    tester.checkItems('6,7,8,9,10')

  test "go to next page via 'next' and 'prev' buttons", ->
    $controls = tester.init().data("pagify").$controls
    $controls.find(".pagify_next a").click()
    tester.checkActivePage(2)
    tester.checkItems('6,7,8,9,10')
    $controls.find(".pagify_prev a").click()
    tester.checkActivePage(1)
    tester.checkItems('1,2,3,4,5')

  test "make sure next and prev stop at bounds", ->
    $controls = tester.init({}, 11).data("pagify").$controls
    $controls.find(".pagify_next a").click().click().click()
    tester.checkActivePage(3)
    tester.checkItems('11')
    $controls.find(".pagify_prev a").click().click().click()
    tester.checkActivePage(1)
    tester.checkItems('1,2,3,4,5')

  module "Options"

  test "items per page", ->
    tester.init(
      per_page: 3
    )
    tester.checkActivePage(1)
    tester.checkItems('1,2,3')
    $(".pagify_next a").click()
    tester.checkActivePage(2)
    tester.checkItems('4,5,6')

  test "starting page", ->
    tester.init(
      current_page: 3
    )
    tester.checkActivePage(3)
    tester.checkItems('11,12,13,14,15')

  test "append controls before element only", ->
    $t = tester.init(
      append_controls: "before"
    )
    $t.prev().shouldBe(".pagify_controls")
    equal $t.next().length, 0, "no controls after element"

  test "append controls both places", ->
    $t = tester.init(
      append_controls: "both"
    )
    $t.prev().shouldBe(".pagify_controls")
    $t.next().shouldBe(".pagify_controls")

  module "Methods"

  test "refresh method", ->
    $t = tester.init({}, 10)
    $t.append($("<div />").text("Item Number 11"))

    $(".pagify_next a").click()
    tester.checkActivePage(2)
    tester.checkItems('6,7,8,9,10')
    $('.pagify_page').last().shouldHaveText('2')

    $t.pagify('refresh')

    $(".pagify_next a").click()
    $('.pagify_page').last().shouldHaveText('3')
    tester.checkActivePage(3)
    tester.checkItems('11')

)(jQuery)