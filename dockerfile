# Create a Jekyll container from a Ruby Alpine Image

# At a minimum use Ruby 2.7 or later with Jekyll 3.9 or later: https://pages.github.com/versions/

FROM 2.7-alpine 

# Add Jekyll dependencies to alpin

RUN apk update
RUN apk add --no-cache build-base gcc cmake git

# Update the Ruby bundler and install Jekyll

RUN gem udpate bundler && gem install bundler jekyll 




