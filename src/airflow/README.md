# Setup Private PyPi Server

1. Install Dependencies

```bash
sudo apt install -y apache2-utils
pip install passlib
```

2. Create the credential under 'energy-forecasting' name.
   (PyPi repository will know to load the credentials from the ~/.htpasswd/htpasswd.txt - Defined in the docker-compose.yml file)

```bash
mkdir ~/.htpasswd
htpasswd -sc ~/.htpasswd/htpasswd.txt energy-forecasting # Insert the password after running this command
```

3. Configure Pypi server credentials

```bash
poetry config repositories.<my-pypi-server> <pypi server URL>
poetry config http-basic.<my-pypi-server> <username> <password>
```

4. Deply libraries

```bash
poetry publish -r <my-pypi-server>
```

# Setup Airflow Server

1. Initialize the Airflow database

```bash
docker compose up airflow-init
```

2. Set up all service
   NOTE: Set up the private PyPi server credentials before running this command.

```bash
docker compose --env-file .env up --build -d
```
