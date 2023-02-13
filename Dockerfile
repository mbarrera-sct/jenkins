#This is a sample Image 
FROM ubuntu 
MAINTAINER miguelix 

RUN apt-get update 
RUN apt-get install nginx -y 
CMD [“echo”,”Imagen creada”] 
