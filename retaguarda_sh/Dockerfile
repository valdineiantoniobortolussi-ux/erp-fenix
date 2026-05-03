FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y     build-essential     default-libmysqlclient-dev     pkg-config     && rm -rf /var/lib/apt/lists/*

COPY src/requirements.txt* .
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

COPY src/ .

ENV FLASK_APP=app.py
ENV CONFIG_MODE=production

CMD ["python", "app.py"]
