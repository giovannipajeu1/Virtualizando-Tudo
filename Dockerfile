FROM python:alpine3.18

WORKDIR /src

COPY . . 


RUN pip install django
RUN  pip install pillow
RUN pip install django-ckeditor
RUN python3 manage.py makemigrations blog
RUN python3 manage.py migrate 


EXPOSE 8000
ENTRYPOINT [ "python3", "manage.py", "runserver" ]