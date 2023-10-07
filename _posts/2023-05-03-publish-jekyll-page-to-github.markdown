---
layout: post
title:  "Publishing a Jekyll Site with Github Pages"
date:   2023-05-03 08:00:00 +0000
categories: [jekyll]
---
> [This blog post is part of a series around building a website with Jekyll for hosting on github pages]({% post_url 2023-05-07-jekyll %})

This post explains how a jekyll website can be published on github pages.

## Create github repository

In github create a new repository to host the source code for the blog site.  
Commit and push the generated jekyll site to the new github repo

{% highlight shell %}
git init
git add --all
git remote add origin https://github.com/yourrepo.git
git push -u origin main
{% endhighlight %}

A .gitignore file was already create during initialization of the Jekyll site.  It will make sure that the generated code is not pushed to github.  After activating github pages on the github repo a [github action](https://github.com/features/actions) will make sure the html code is regenerated from the Jekyll pages. 

Change the repo settings on github.com

> Settings > Pages 

Select the branch on which the code was pushed

![github pages settings](/assets/images/github_pages.png)

From the moment github pages is configured a github action will run to publish the site.  

![github pages action](/assets/images/github_pages_action.png)

After the github action has run the generated site can be consulted on the Url as shown on the github actions deploy step output.

Next post will show how to [add google analytics to the jekyll pages]({% post_url 2023-05-06-add-google-analytics-to-jekyll %})


