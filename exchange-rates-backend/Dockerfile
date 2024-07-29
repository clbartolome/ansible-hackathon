FROM registry.access.redhat.com/ubi8/python-39

WORKDIR /app

COPY requirements.txt requirements.txt
COPY . .

RUN pip install -r requirements.txt

# --- RUN AS ROOT ---
USER root
RUN chmod 666 app_rates.json
# -------------------

USER 1001
EXPOSE 5000

CMD ["python", "app.py"]
