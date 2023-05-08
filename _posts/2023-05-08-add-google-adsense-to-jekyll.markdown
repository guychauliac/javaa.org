---
layout: post
title:  "Adding advertising to Jekyll"
date:   2023-05-08 18:37:00 +0000
categories: [jekyll,docker,github pages]
---
> [This blog post is part of a series around building a website with Jekyll]({% post_url 2023-05-07-jekyll %})

As this is the first time I'm adding advertising on a site I'll be updating this post when I gain more insights.

For my blog site I'll be using Google AdSense, setting it up is pretty easy, just follow the procedure as described on the [getting started wizard](https://adsense.google.com/start/)

After creation of a site within Google AdSense 2 actions need to be done to get ads on your site


## 1. Include AdSense javascript code snippet on each page

Within Google AdSense navigate to

> Sites > Your site

Open the connect your site section and copy the code snippet

![AdSense code snippet](/assets/images/google_adsense_code_snippet.png)

The code snippet needs to be included on each page.  To achieve this we'll need to make a change in the includes html content of the minima theme.  More specifically the script needs to be added in the <head> of each page.  From the github repository for the minima theme copy the [head.html](https://github.com/jekyll/minima/blob/master/_includes/head.html) and store it in your jekyll site at the same location as where it's located on github. e.g. _includes/head.html

Then copy paste the google adsense script and past it before the head closing tag within head.html

## 2. Include ads.txt in the root of the site

![AdSense Ads.txt](/assets/images/google_adsense_ads.txt.png)

Copy the content of Ads.txt snippet and store it in the root of your Jekyll site.

## Publish and validate AdSense snippets

Publish the changes to the github repo, after the github action to publish the site has finished verify in the browser that:

* the ads.txt is available at https://yoursite/ads.txt
* each html head section contains the Google AdSense javascript section that was included by inspecting the html source code

## Validate ad generation

Google AdSense will now review your site, which can take up to 2 weeks.

![AdSense review](/assets/images/google_adsense_review.png)

Before this review no ads will be shown on your site.  In the 'Site' section the status of your site can be checked:

![AdSense status](/assets/images/google_adsense_status.png)








