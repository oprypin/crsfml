# Web requests with HTTP

## Introduction

CrSFML provides a simple HTTP client class which you can use to communicate with HTTP servers. "Simple" means that it supports the most basic features of HTTP: POST, GET and HEAD request types, accessing HTTP header fields, and reading/writing the pages body.

If you need more advanced features, such as secured HTTP (HTTPS) for example, you're better off using a true HTTP library, like libcurl or cpp-netlib.

For basic interaction between your program and an HTTP server, it should be enough.

## SF::Http

To communicate with an HTTP server you must use the [Http]({{book.api}}/Http.html) class.

```ruby
http = SF::Http.new
http.set_host("http://www.some-server.org/")

# or
http = SF::Http.new("http://www.some-server.org/")
```

Note that setting the host doesn't trigger any connection. A temporary connection is created for each request.

The only other function in [Http]({{book.api}}/Http.html), sends requests. This is basically all that the class does.

```ruby
request = SF::HttpRequest.new
# fill the request...
response = http.send_request(request)
```

## Requests

An HTTP request, represented by the [HttpRequest]({{book.api}}/HttpRequest.html) class, contains the following information:

  * The method: POST (send content), GET (retrieve a resource), HEAD (retrieve a resource header, without its body)
  * The URI: the address of the resource (page, image, ...) to get/post, relative to the root directory
  * The HTTP version (it is 1.0 by default but you can choose a different version if you use specific features)
  * The header: a set of fields with key and value
  * The body of the page (used only with the POST method)

```ruby
request = SF::HttpRequest.new
request.method = SF::HttpRequest::Post
request.uri = "/page.html"
request.set_http_version(1, 1) # HTTP 1.1
request.set_field("From", "me")
request.set_field("Content-Type", "application/x-www-form-urlencoded")
request.body = "para1=value1&param2=value2"

response = http.send_request(request)
```

CrSFML automatically fills mandatory header fields, such as "Host", "Content-Length", etc. You can send your requests without worrying about them. CrSFML will do its best to make sure they are valid.

## Responses

If the [Http]({{book.api}}/Http.html) class could successfully connect to the host and send the request, a response is sent back and returned to the user, encapsulated in an instance of the [HttpResponse]({{book.api}}/HttpResponse.html) class. Responses contain the following members:

  * A status code which precisely indicates how the server processed the request (OK, redirected, not found, etc.)
  * The HTTP version of the server
  * The header: a set of fields with key and value
  * The body of the response

```ruby
response = http.send_request(request)
puts "status: #{response.status}"
puts "HTTP version: #{response.major_version}.{response.minor_version}
puts "Content-Type header:" + response.get_field("Content-Type")
puts "body: " + response.body
```

The status code can be used to check whether the request was successfully processed or not: codes 2xx represent success, codes 3xx represent a redirection, codes 4xx represent client errors, codes 5xx represent server errors, and codes 10xx represent CrSFML specific errors which are *not* part of the HTTP standard.

## Example: sending scores to an online server

Here is a short example that demonstrates how to perform a simple task: Sending a score to an online database.

```ruby
def send_score(score, name)
    # prepare the request
    request = SF::HttpRequest.new("/send-score.html", SF::HttpRequest::Post)

    # encode the parameters in the request body
    request.body = "name=" + name + "&score=" + score

    # send the request
    http = SF::Http.new("http://www.myserver.com/")
    response = http.send_request(request)

    # check the status
    if (response.status == SF::HttpResponse::Ok)
        # check the contents of the response
        puts response.body
    else
        puts "request failed"
    end
end
```

Of course, this is a very simple way to handle online scores. There's no protection: Anybody could easily send a false score. A more robust approach would probably involve an extra parameter, like a hash code that ensures that the request was sent by the program. That is beyond the scope of this tutorial.

And finally, here is a very simple example of what the PHP page on server might look like.

```php
<?php
$name = $_POST['name'];
$score = $_POST['score'];

if (write_to_database($name, $score)) { // this is not a PHP tutorial :)
    echo 'name and score added!';
} else {
    echo 'failed to write name and score to database...';
}
```

