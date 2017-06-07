Simple Ghost Docker Image
=========================

The image is based on the official image in order to automatically track
updates. It fixes a few problems with the official image:

 - Ghost is started using `node index.js` rather than npm to avoid signal
   forwarding problems

 - A valid config.js is explicitly required

 - The image starts in production mode by default

 - The source folder is owned by the node user to prevent a logfile problem.

Hopefully the official image will be updated to fix most of these issues and
this image can go away.

If you intend to use Ghost in production, you may also want to look at using
mariadb or similar instead of the sqlite database and adding a reverse proxy in
front of Ghost.
