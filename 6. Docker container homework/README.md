# Docker container for the python app

## About 
There are two docker images was designed for this homework: 

* <b>[Gunicorned](gunicorned%20image)</b> - this image contains the Gunicorn python WGSI HTTP web server. The image is ready for deployment with the Nginx server in front of it. The total weight of the image is <b>9.1 MB</b> and <b>8.31 MB</b> compressed. It is possible beacause of the Gunicorn web server was added to the app code and now the app can be compiled to the standalone executable file by pyinstaller and staticx.
* <b>[Gunicornless](gunicornless%20image)</b> - this image is running on the Flask development server. Not ready for production. But weight of this image was decreased to <b>8.96 MB</b> and <b>8.18 MB</b> compressed. Lightest image possible for my app.

All of the apps inside the images are running by the rootless user 1001 and from scratch.

## Links 
Links for the images on Docker Hub:

* [Gunicorned](https://hub.docker.com/repository/docker/ivanlevitan/gunicorned)
* [Gunicornless](https://hub.docker.com/repository/docker/ivanlevitan/gunicornless)