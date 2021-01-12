var page = require('webpage').create();

page.viewportSize = {
  width: 1388,
  height: 792
};

page.open('http://www.google.com', function() {
    page.render('viewport_js.png');
    phantom.exit();
});
