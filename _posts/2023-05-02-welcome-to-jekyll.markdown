---
layout: post
title:  "Building a blog site with Jekyll, Github pages and docker"
date:   2023-05-02 19:24:31 +0000
categories: jekyll docker github pages
---
Yes this is my first blog post! What better to start with then to explain how this blog was created with Jekyll, Github pages and docker.

# Why Jekyll ?

[Jekyll](https://jekyllrb.com/) is an open source static file generator.  It allows you to write a static website in markup language.  As my expertise lies in other IT domains than front end design this sounded like a perfect match.

# Why Github pages

[Github pages](https://pages.github.com/) allows to host a website linked to a github repository.  Any content pushed on a github repository can immediately be served as a static website.  Additionally it's free and works well together with Jekyll.



Jekyll requires blog post files to be named according to the following format:

`YEAR-MONTH-DAY-title.MARKUP`

Where `YEAR` is a four-digit number, `MONTH` and `DAY` are both two-digit numbers, and `MARKUP` is the file extension representing the format used in the file. After that, include the necessary front matter. Take a look at the source for this post to get an idea about how it works.

Jekyll also offers powerful support for code snippets:

{% highlight ruby %}
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
{% endhighlight %}

Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

[jekyll-docs]: https://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/
