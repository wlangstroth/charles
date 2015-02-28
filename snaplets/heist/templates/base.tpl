<!DOCTYPE html>
<html>
  <head>
    <title>Flower Power U-Pick Flower Garden</title>
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/screen.css">
    <link rel="stylesheet" href="https://api.tiles.mapbox.com/mapbox.js/v2.1.5/mapbox.css">
    <script src="https://api.tiles.mapbox.com/mapbox.js/v2.1.5/mapbox.js"></script>
  </head>
  <body>
    <div class="container">
      <h1 id="main-title"><img src="/img/flower-power-title.png"></h1>
      <div class="row">
        <div class="col-sm-8">
          <apply-content/>
        </div>
        <div class="col-sm-3 col-sm-offset-1">
            <div class="sidebar-module">
                <div class="btn-group-vertical" role="group" style="width: 100%">
                    <a class="btn btn-default" role="button" style="text-align: left" href="/#perennial-list"><span class="glyphicon glyphicon-leaf" aria-hidden="true"> Perennials</span></a>
                    <a class="btn btn-default" role="button" style="text-align: left" href="/#gallery"><span class="glyphicon glyphicon-leaf" aria-hidden="true"> Gallery</span></a>
                    <a class="btn btn-default" role="button" style="text-align: left" href="/#about"><span class="glyphicon glyphicon-leaf" aria-hidden="true"> About</span></a>
                </div>
            <div id="map"></div>
            <script>
              L.mapbox.accessToken = 'pk.eyJ1Ijoid2xhbmdzdHJvdGgiLCJhIjoiNG9JaXEzMCJ9.63e2HCjhXmt8JfqLKwF8fg';
              var map = L.mapbox.map('map', 'wlangstroth.l779a5cb');
              map.setZoom(15);
            </script>
            <h2>Garden News</h2>
            <a class="twitter-timeline" href="https://twitter.com/thegardenerisin" data-widget-id="569954747025997824" data-chrome="noheader nofooter">Tweets by @thegardenerisin</a>
            <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
          </div>
        </div>
      </div>
      <a name="perennial-list"/>
      <apply template="_perennial-list"/>
    </div>
  </body>
</html>
