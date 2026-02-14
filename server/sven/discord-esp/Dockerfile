FROM python:3.14.3-slim-trixie

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

# https://stackoverflow.com/questions/29663459/why-doesnt-python-app-print-anything-when-run-in-a-detached-docker-container
CMD ["python", "-u", "bot.py"]