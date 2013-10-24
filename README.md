# jQuery.pagify

Client-side pagination plugin.

## Usage

Call on the element containing elements to be paginated.

A `<nav>` element containing a `<ul>` to navigate through the pages will be inserted in the DOM directly after said element.

## Options

```javascript
$("#page_container").pagify({
  append_controls: 'after'                  // where to append pagination controls - 'before', 'after' or 'both'
  show_pagecontrols: true                   // show links for each page number in pagination controls
  show_nextprev: true                       // show 'next' and 'prev' buttons in addition to page number buttons
  next_label: 'next'                        // button text
  prev_label: 'prev'                        // button text
  current_page: 1                           // starting page
  per_page: 5                               // items per page
});
```

## Methods

If items are added or removed asynchronously, call the 'refresh' method. Your page number will be maintained (but maybe not the currently displayed items, depending on how the items were changed).

```javascript
$("#page_container").pagify('refresh');
```