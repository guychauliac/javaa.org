---
layout: post
title:  "Add google analytics to Jekyll pages minima theme"
date:   2023-05-06 18:00:00 +0000
categories: [jekyll]
---
> [This blog post is part of a series around building a website with Jekyll for hosting on github pages]({% post_url 2023-05-07-jekyll %})

In this blog post we will explore how google analytics can be added to a jekyll website and how it can be tested locally within a docker container.

By default when generating a new Jekyll site the '[Minima](https://github.com/jekyll/minima)' theme will be applied.  The minima theme has already incorporated support for google analytics, we'll see how to configure it later.  

First activate google analytics and create a new account with a new property and a new stream.  New google analytics accounts will 
be [GA4 accounts](https://developers.google.com/analytics/devguides/collection/ga4).

![change _config.yaml](/assets/images/google_analytics_stream.png)

Copy the measurement id and store it in the **_config.yaml** file

{% highlight yaml %}
# Google Analytics
google_analytics: G-XXXXXXXXXX
{% endhighlight %}


GA4 is not yet supported on the latest release version of minima theme. However it's already supported on the minima github repository.
Jekyll can be instructed to directly use the source code from github for a Jekyll theme. To do so add the 'jekyll-remote-theme' to the list of plugins in _config.yaml.  Next remove the line containing 'theme: minima' and replace it with 'remote_theme: jekyll/minima'

your _config.yaml will now contain:

{% highlight yaml %}
# Build settings
remote_theme: jekyll/minima

plugins:
  - jekyll-feed
  - jekyll-remote-theme

# Google Analytics
google_analytics: G-XXXXXXXXXX
{% endhighlight %}

Test the changes by pushing the changes to github, after github actions has updated the page browse to your website. 
Within a minute you should be able to see a visitor in google analytics within the report showing the realtime data

![change _config.yaml](/assets/images/google_analytics_realtime.png)

## Local testing with docker

The jekyll-remote-theme plugin is a Ruby Gem that is not yet installed on your docker environment.
To do so open the file 'Gemfile' and add a line for the plugin

{% highlight gem %}
gem "jekyll-remote-theme", "~> 0.4.3"
{% endhighlight %}

Make sure the version used is a version supported by  [github pages](https://pages.github.com/versions/)
On the docker container shell execute 'bundle install' to update to update the installed gems.  Then build the jekyll site again

{% highlight shell %}
bundle install
jekyll build
{% endhighlight %}

All these actions can be done while the jekyll server is still running.

In the next post we'll have look how to [put advertising on a Jekyll site]({% post_url 2023-05-08-add-google-adsense-to-jekyll %}) to generate some revenue.


 
