<!DOCTYPE html>
<html>
    <head>
        <title>Flower Power U-Pick Flower Garden</title>
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Patrick+Hand+SC">
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="/css/screen.css">
        <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/jquery.slick/1.5.0/slick.css"/>
    </head>
    <body>

      <apply template="header"></apply>

      <apply-content/>

      <apply template="footer"></apply>

      <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
      <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
      <script src="//cdn.jsdelivr.net/jquery.slick/1.5.0/slick.min.js"></script>
      <script>
        $(function(){
            $('.carousel').slick({
                infinite: true,
                speed: 300,
                slidesToShow: 1,
                centerMode: true,
                variableWidth: true,
                lazyLoad: 'ondemand'
            });
        });
      </script>

  </body>
</html>
