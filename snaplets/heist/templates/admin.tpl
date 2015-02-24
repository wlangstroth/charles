<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>admin | charles the gardener</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <style>
      body {
        min-height: 2000px;
        padding-top: 30px;
      }
    </style>
  </head>
  <body>
    <ifLoggedIn>
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="/admin">Flower Power</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li>
            <a class="active" href="/admin/flowers">Flowers</a>
            </li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
              <li><a href="/logout">Log out</a></li>
          </ul>
        </div>
      </div>
    </nav>
    <div class="container">
      <apply-content/>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    </ifLoggedIn>
    <ifLoggedOut>
    <div class="container">
        <p>You need to <a href="/login">Log in</a></p>
    </div>
    </ifLoggedOut>
  </body>
</html>
