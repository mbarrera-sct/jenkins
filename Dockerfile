FROM ubuntu 
MAINTAINER miguel felix barrera diaz

RUN apt-get update 
RUN apt-get install nginx -y 
CMD [“echo”,”Imagen creada”] 
