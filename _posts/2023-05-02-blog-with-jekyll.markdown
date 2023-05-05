---
layout: post
title:  "Building a blog site with Jekyll, Github pages and docker"
date:   2023-05-02 19:24:31 +0000
categories: jekyll docker github pages
---
Yes this is my first blog post! What better to start with then to explain how this blog was created with Jekyll, Github pages and docker.

## Why Jekyll ?

[Jekyll](https://jekyllrb.com/) is an open source static file generator.  It allows you to write a static website in markup language.  As my expertise lies in other IT domains than front end design this sounded like a perfect match.

## Why Github pages ?

[Github pages](https://pages.github.com/) allows to host a website linked to a github repository.  Any content pushed on a github repository can immediately be served as a static website.  Additionally it's free and works well together with Jekyll.

## Why docker ?

I want to be able to test the blog website locally.  Jekyll is running on Ruby.  As I'm developping on a windows machine I did not want to go trough the hastle of having to install Ruby.  However I must say that in the end it took me a while to get things running in docker.

### Preparing a docker image

Github pages can only be used with a [specific version of Ruby And Jekyll](https://pages.github.com/versions/). 
Let's define a docker images that uses the Ruby 2.7 alpine images and use apk to install the Jekyll 3.9.3 Gem:

Create a dockerfile:

{% highlight docker %}
FROM ruby:2.7-alpine
RUN apk update
RUN apk add --no-cache build-base gcc cmake git
RUN gem update --system && gem update bundler && gem install bundler jekyll:3.9.3
{% endhighlight %}

Now build the docker image:

{% highlight docker %}
docker build -t jekyll .
{% endhighlight %}
	
During my tests I did not succeed mounting a windows folder to a path in the container so I decided to work with a docker volume instead.
Create the volume:

{% highlight docker %}
docker create volume jekyllvolume
{% endhighlight %}	

Launch a shell in the docker container:

{% highlight docker %}
docker run -it --name jekyllvolume -p 8080:4000 -v jekyllvolume:/usr/src jekyll sh
	
-p 8080:4000 will map port 4000 inside of the container to port 8080 on the host
-v jekyllvolume:/usr/src will mount the volume 'jekyllvolume' to the path /usr/src in the docker container
{% endhighlight %}	

### Launch Jekyll in the container 
	
Within the shell of the container test if Jekyll 3.9.3 is correctly available

{% highlight shell %}
Jekyll --version
{% endhighlight %}	
	
Navigate to the /usr/src folder and create our fresh Jekyll site

{% highlight shell %}
cd /usr/src
jekyll new mysite
{% endhighlight %}	
	
A folder mysite is being created with several new files
Go inside of the folder and start serving the Jekyll website

{% highlight shell %}
cd mysite
jekyll serve --hosts 0.0.0.0
{% endhighlight %}	
	
The --hosts 0.0.0.0 will tell Jekyll to run on all network interfaces.  

Check on the host system if the Jekyll website can be reached by browsing to [http://localhost:8080](http://localhost:8080)

## Publishing to github pages

Next post will talk about how to [publish a jekyll page on github pages]({% post_url 2023-05-03-publish-jekyll-page-to-github %})
