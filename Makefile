run:
	pipenv run python manage.py runserver
dev:
	docker build -t django_image .
	docker run --rm -p 80:80 --mount  type=bind,source="$(shell pwd)",target=/usr/src/code --name django_container django_image python manage.py runserver 0.0.0.0:80
prod:
	docker build -t django_image .
	docker run --rm -d -p 80:80 --name django_container django_image gunicorn --bind 0.0.0.0:80 --workers 3 settings.wsgi:application
stop:
	docker stop django_container