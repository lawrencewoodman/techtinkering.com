---
layout: article
title: How to share an SSL certificate and still use cookies
tags:
  - PHP
  - Programming
  - Security
  - SSL
  - Web Development
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
Website hosting companies often provide a shared SSL certificate, but this presents the web designer with the problem of how to use it for a site that uses cookies.  I have read many people say that this can't be done.  However, this article will show a simple way of using a shared SSL certificate with cookies for a login page.


## Explanation of the problem
When the data is entered into the login form it is passed to a script handling it on a secure server.  The secure server will be using a different session from the one connected with the login page because the session cookie is associated with a specific server.  Therefore when you change a session variable to reflect that the user has logged in successfully you will find that this has only changed the variable for the session on the secure server.  When you return to the insecure part of the site you will be returning to the original session, so you won't be able to see any changes made to reflect the success of the login.

## The method
In order to update the session variables to reflect the success of the login and for them to be seen by the insecure session we need to pass the insecure session ID to the secure session.  

In the login page you need the following PHP to record the session ID.

{% highlight php %}
<?php
session_start();

//------------------------------------------------
// Record the session id so that it can be passed
// and used in the secure session
//------------------------------------------------
if( SID == "" )
  $insecureSID = $_REQUEST[PHPSESSID];
else
  $insecureSID = session_id();
?>
{% endhighlight %}

Then you need to pass this session ID to the PHP script handling the form on the secure server.  You will need to ask your hosting company for the url of the secure server and replace it in the code below.  The code snippet also checks which server is being accessed.  This is so that you can test the rest of the functionality without using SSL certificates.

{% highlight php %}
<?php
// Put the address of your test server here
$testServer = "127.0.0.1";
// Put the address of your secure server here and the root of the website
$secureServerPrefix = "https://secure.server.net/~myaccount/mywebsite.com";

// If not logged into test server
if( $_SERVER[SERVER_ADDR] != $testServer )  
  $serverPrefix = $secureServerPrefix;

$htmlOutput .= "<form method=\"post\" action=\"".$serverPrefix/login.handler.php."\">";

$htmlOutput .= "<input type=\"hidden\" name=\"insecureSID\" value=\"".$insecureSID."\">"; 
?>
{% endhighlight %}

The next piece of PHP code is located near the beginning of `login.handler.php`, which handles the form above.  It again tests to see if this is being run on a test server without a shared SSL certificate.  The code sets the current session ID to that of the insecure session.  This does not make the passing of the details from the form insecure, it just means that we can access the insecure session's variables.

Then the `$webPrefix` and `$_SERVER[DOCUMENT_ROOT]` variables are set so that if we need to `include` a file, or if we need to use `header`, the correct location will be referred to.

{% highlight php %}
<?php
// Put the address of your test server here
$testServer = "127.0.0.1";  

// If not logged into the test server
if( $_SERVER[SERVER_ADDR] != $testServer ) {

  // Use the normal connection session not the secure server session
  if( isset($_POST[insecureSID]) ){
    session_id($_POST[insecureSID]);
  } 

  //--------------------------------------
  // Point everything to the right places
  //--------------------------------------

  // Set this to the address of your website
  $webPrefix = "http://mywebsite.com";   

  // Set this the location on hosting companies server where your website resides
  $_SERVER[DOCUMENT_ROOT] = "/home/myaccount/www/mywebsite.com";
}

session_start();
?>
{% endhighlight %}

Once the script has determined if it is a successful login, the appropriate session variables can be set and we can then return to the insecure server using the `$webPrefix` variable:
{% highlight php %}
header("Location: ".$webPrefix."/loggedInPage.html");
{% endhighlight %}

## Further enhancement
To increase the security of this method you could also check that the referrer is as you expect using `$_SERVER[HTTP_REFERER]`.  This is not foolproof as it can be faked, but it is useful to reduce the likelihood of low-level attacks. 
