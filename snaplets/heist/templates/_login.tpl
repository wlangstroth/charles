<form class="form-signin" method="post" action="/login">
    <h2 class="form-signin-heading">Please sign in</h2>
    <p class="login-error"><loginError/></p>
    <label for="name" class="sr-only">Email address</label>
    <input type="text" id="login" name="login" class="form-control" placeholder="Username" autofocus>
    <label for="password" class="sr-only">Password</label>
    <input type="password" id="password" name="password" class="form-control" placeholder="Password">
    <input class="btn btn-lg btn-primary btn-block" type="submit" value="Sign in"/>
</form>
