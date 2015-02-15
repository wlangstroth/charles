<!doctype html>
<html>
  <head>
    <title>Charles the Gardener</title>
    <link href='http://fonts.googleapis.com/css?family=Walter+Turncoat' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="/normalize.css"/>
    <link rel="stylesheet" type="text/css" href="/bootstrap-tables.css"/>
    <link rel="stylesheet" type="text/css" href="/screen.css"/>
    <link href='https://api.tiles.mapbox.com/mapbox.js/v2.1.5/mapbox.css' rel='stylesheet'/>
    <script src='https://api.tiles.mapbox.com/mapbox.js/v2.1.5/mapbox.js'></script>
  </head>
  <body class="introcontent">
    <div id="content">
      <canvas id=mainTitle width="800" height="130">Flower Power</canvas>
      <h2 class="tagline">U-Pick Flower Garden</h2>
      <article class="main">
        <apply-content/>
      </article>
    </div>
    <script>
      var ctx = mainTitle.getContext('2d'),
          w = mainTitle.width,
          h = mainTitle.height,
          textHeight = h / 2,
          font = textHeight + 'px NouveauFLF',
          curve = h,
          angleSteps = 180 / w,
          os = document.createElement('canvas'),
          octx = os.getContext('2d');

      os.width = w;
      os.height = h;
      octx.font = font;
      octx.textBaseline = 'top';
      octx.textAlign = 'center';

      octx.clearRect(0, 0, w, h);
      ctx.clearRect(0, 0, w, h);

      //gradient = ctx.createLinearGradient(0, 0, w, 0);
      //gradient.addColorStop("0","magenta");
      //gradient.addColorStop("0.25","blue");
      //gradient.addColorStop("0.4","green");
      //gradient.addColorStop("0.65","orange");
      //gradient.addColorStop("1.0","red");

      octx.fillStyle = '#990000';
      octx.fillText('FLOWER POWER', w / 2, 0);

      i = w;
      dltY = curve / textHeight;
      y = 0;
      while (i--) {
        y = - curve * Math.sin(i * angleSteps * Math.PI / 180);
        ctx.drawImage(os, i, 0, 1, textHeight, i, h, 1, y);
      }
    </script>
  </body>
</html>
