FROM python:alpine3.18

WORKDIR /src

COPY . . 


ENV DJANGO_SUPERUSER_USERNAME={{DJANGO_SUPERUSER_USERNAME}} 
ENV DJANGO_SUPERUSER_PASSWORD={{DJANGO_SUPERUSER_PASSWORD}}
ENV DJANGO_SUPERUSER_EMAIL={{DJANGO_SUPERUSER_EMAIL}}


RUN pip install django pillow django-ckeditor
RUN python3 manage.py makemigrations blog
RUN python3 manage.py migrate 
RUN python3 manage.py collectstatic --noinput
RUN python3 manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('$DJANGO_SUPERUSER_USERNAME', '$DJANGO_SUPERUSER_EMAIL', '$DJANGO_SUPERUSER_PASSWORD')"



EXPOSE 8000
CMD ["python3", "manage.py", "runserver"]
