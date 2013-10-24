# jQuery.pagify

Client-side pagination plugin.

## Usage

Call on the element containing elements to be paginated.

A `<nav>` element containing a `<ul>` to navigate through the pages will be inserted in the DOM directly after said element.

Example generated markup:

```html
<nav class="pagify_controls">
  <ul>
    <li><a href="#" class="pagify_prev">prev</a></li>
    <li><a href="#" class="pagify_page pagify_active">1</a></li>
    <li><a href="#" class="pagify_page">2</a></li>
    <li><a href="#" class="pagify_next">next</a></li>
  </ul>
</nav>
````

## Options

```javascript
$("#page_container").pagify({
  append_controls: 'after'    // where to append controls - 'before', 'after' or 'both'
  show_pagecontrols: true     // show page number controls
  show_nextprev: true         // show 'next' and 'prev' buttons
  next_label: 'next'          // button text
  prev_label: 'prev'          // button text
  current_page: 1             // starting page
  per_page: 5                 // items per page
});
```

## Methods

If items are added or removed asynchronously, call the 'refresh' method. Your page number will be maintained (but maybe not the currently displayed items, depending on how the items were changed).

```javascript
$("#page_container").pagify('refresh');
```