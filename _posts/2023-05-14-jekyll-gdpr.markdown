---
layout: post
title:  "Building a GDPR compliant Jekyll site"
date:   2023-05-14 19:45:00 +0000
categories: [jekyll]
---
> [This blog post is part of a series around building a website with Jekyll]({% post_url 2023-05-07-jekyll %})

## What is personal data ?
A jekyll website used within the EU that collects data that can lead to the identification a living individual is obliged to follow the regulations as stated by the [General Data Protection Regulation (GDPR)](https://gdpr.eu/tag/gdpr/).  This data is being referred to as [personal data](https://gdpr.eu/eu-gdpr-personal-data/).

Tracking cookies used by Google Analytics and Google AdSense is being considered as personal data and as such the [regulations of GDPR](https://gdpr.eu/cookies/) needs to be followed.

The GDPR regulations state that personal data can only be processed as long as a user consent is being obtained.

For a website that uses cookies with data that can lead to the identification of a person it means a consent needs to be obtained to get the users agreement about the processing of such cookies.

## Writing a GDPR compliant privacy notice
Another goal of the GDPR is to be transparent towards the public and inform them about how their data is used.  The way that personal data is being processed needs to be described in a public document: the 'privacy notice'.

A [template for a privacy notice](https://gdpr.eu/privacy-notice/) can be found on the [eu gdpr website](https://gdpr.eu/).

To create the [privacy document that is available on this blog](/privacy) site I took the liberty of asking it to ChatGPT with the prompt:

{% highlight markdown %}
Give me a GDPR policy that I need to add to my site if my site is using google analytics and google AdSense.  
Format the policy as markdown.
{% endhighlight %}
	
Make sure to verify that each phrasing in the generated policy is true and is matching the way your site is using personal data and cookies.

## Asking for user consent

Asking user consent involves also informing the user about the usage of private data and asking him to consent for each type of private data that is being collected.  Only when the user gives his consent for a certain type of private data the corresponding script that collect and generate the private data and cookies can be activated.

During my search for an easy way to build a cookie consent dialog I came across this [excellent github repo](https://github.com/orestbida/cookieconsent).

The tutorial is very clear, these are the steps I did to include the cookie consent dialog on this Jekyll site

**copy cookieconsent.js, cookieconsent-init.js and cookieconsent.css** and store them in /assets/js and /assets/css 

**copy [head.html](https://github.com/jekyll/minima/blob/master/_includes/head.html) from the minima theme** and store it in /_includes. Modify head.html, add the css stylesheet for the cookie consent dialog

{% highlight html %}
<link rel="stylesheet" href="/assets/css/cookieconsent.css" media="print" onload="this.media='all'">
{% endhighlight %}

**copy [base.html](https://github.com/jekyll/minima/blob/master/_layouts/base.html) from the minima theme** and store it in /_layouts. Modify base.html and add the following line just before </body>

{% highlight liquid %}
{% raw %}
{%- include cookie-consent.html -%}
{% endraw %}
{% endhighlight %}
	
**create cookie-consent.html in /_includes.**  Load scripts cookieconsent.js and cookieconsent-init.js. Put all scripts that required cookie consent in this html page and make sure to include type="text/plain" and data-cookiecategory="<category>" on each script.  The data categories match the ones defined in cookieconsent-init.js, make sure to align them.

The example below shows how to conditionally load the scripts of google Analytics and google AdSense. google_analytics and google_adsense need to be defined in _config.yaml.

{% highlight html %}
{% raw %}
<script defer src="/assets/js/cookieconsent.js"></script>
<script defer src="/assets/js/cookieconsent-init.js"></script>

{%- if jekyll.environment == 'production' and site.google_adsense -%}
<script defer type="text/plain" data-cookiecategory="targeting" src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client={{ site.google_adsense }}" crossorigin="anonymous"></script>
{%- endif -%}

{%- if jekyll.environment == 'production' and site.google_analytics -%}
<script async type="text/plain" data-cookiecategory="analytics" src="https://www.googletagmanager.com/gtag/js?id={{ site.google_analytics }}"></script>
<script type="text/plain" data-cookiecategory="analytics">
	  window['ga-disable-{{ site.google_analytics }}'] = window.doNotTrack === "1" || navigator.doNotTrack === "1" || navigator.doNotTrack === "yes" || navigator.msDoNotTrack === "1";
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){window.dataLayer.push(arguments);}
	  gtag('js', new Date());
	
	  gtag('config', '{{ site.google_analytics }}');
</script>
{%- endif -%}
{% endraw %}
{% endhighlight %}

**Test the correctness of the cookie consent dialog** and loading of corresponding scripts by inspecting the developer console in the browser.


