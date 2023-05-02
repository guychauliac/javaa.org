# maxxq.org

https://www.youtube.com/watch?v=owHfKAbJ6_M

# Run Jekyll in docker container

*build the docker container*

	docker build -t maxxqjekyll .

*run the docker container in interactive shell*

	docker run -it maxxqjekyll sh
	
*create new site*
	
	cd /usr
	jekyll new maxxq 
	
Site now exists in /usr/maxxq


*build site*

	 cd /usr/maxxq
	 jekyll build
	 
Generated html content now exists in /usr/maxxq/_site

*run site*

	cd /usr/maxxq
	jekyll serve
	
Site is now running in the container at http://127.0.0.1:4000/
However it cannot be tested yet from the host as no ports are being exposed

*stop and restart the docker container with port mapping*
	
	CRTL-C 											#to stop the jekyll process
	exit 											#exit the container
	docker run -it -p 8080:4000 maxxqjekyll sh	#restart the container with port mapping
	cd /usr
	jekyll new maxxq 								#recreate the site as data is not persisted in a docker container
	cd /usr/maxxq
	jekyll serve --host 0.0.0.0					#start the jekyll server again, important to use --host 0.0.0.0, otherwise the port is not exposed on the interface that is exposed out of the docker container
	
*stop and restart container with volume mapping*
	
	docker create volume maxxq											#volume is create in docker desktop, like this data is persisted outside of the docker container but yet in a way that is not host specific
	docker run -it --name maxxqjekyll -p 8080:4000 -v maxxq:/usr/src maxxqjekyll sh 	#mount the volumen to the default /usr/src folder which is empty
	
*clone the github repo*

	cd /usr/src
	git clone git clone https://github.com/guychauliac/maxxq.org
	
*initialize the jekyll website in the current directory*
	
	jekyll new . --force    #--force will overwrite existing jekyll files
	
* container starfossen *

	docker run -it --name starefossen -p 8080:4000 -v maxxq:/usr/src starefossen/github-pages



