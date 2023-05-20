---
layout: post
title:  "Intro - Creating a website with jekyll for hosting on github pages"
date:   2023-05-02 23:30:00 +0000
categories: [jekyll]
---
> [This blog post is part of a series around building a website with Jekyll for hosting on github pages]({% post_url 2023-05-07-jekyll %})

Yes this is my first blog post! What better to start with then to explain how this blog was created with Jekyll, Github pages and docker.

In this blogpost series I will explain how to setup a blog website with Jekyll. How to test it locally with docker and how it can be published to github pages.

## Why Jekyll ?

[Jekyll](https://jekyllrb.com/) is an open source static file generator.  It allows you to write a static website in markup language.  As my expertise lies in other IT domains than front end design this sounded like a perfect match.

## Why Github pages ?

[Github pages](https://pages.github.com/) allows to host a website linked to a github repository.  Any content pushed on a github repository can immediately be served as a static website.  Additionally it's free and works well together with Jekyll.

## Why docker ?

I want to be able to test the blog website locally.  Jekyll is running on Ruby.  As I'm developping on a windows machine I did not want to go trough the hastle of having to install Ruby. 

