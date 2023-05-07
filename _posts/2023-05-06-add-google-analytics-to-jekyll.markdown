---
layout: post
title:  "Building a blog site with Jekyll, Github pages and docker"
date:   2023-05-06 18:00:00 +0000
categories: [jekyll,docker,github pages]
---

activate google analytics
get code from google analytics

store it in _config.yaml:
google_analytics: G-WNNTGH0123

add plugin jekyll-remote-theme

plugins:
  - jekyll-feed
  - jekyll-remote-theme
  
 remove theme and add remote-theme:
 
 remote_theme: jekyll/minima
 
 this is needed because of the new google analytics mechanisme called '??' which is not yet supported on the released version, see blog: ???
 