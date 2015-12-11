# Overview
Libipho: Linux-based individual photobooth

The Libipho project helps you to create a non-commercial individual photobooth by providing
instructions on

1. How to build a photobooth with a professional look
2. How to set up the photobooth for pictures with a studio-grade quality
3. How to set up hardware and software of the photobooth for showing the picture you have just taken with minimal delay.

For accessing the images from the camera, this project heavily relies on the awsome open source project 
[gphoto2](https://github.com/gphoto/gphoto2).

# This repository
This repository hosts the core part of the Libipho software.
It consists mainly of bash scripts that control the behaviour of the photobooth.
The scrips mainly serve the purpose of downloading the image from the camera,
processing the image and publishing the image using an internal web server.
On the internal web server, a gallery shows all images that have been taken so far.
Another page on the web server shows only the most recent image. In the photobooth,
this page is displayed on the screen that the user of Libipho sees.

If you want to have a look at the code, the scripts *libipho-scripts/capture.sh*
and *libipho-scripts/capture.sh* serve as a good starting point.
