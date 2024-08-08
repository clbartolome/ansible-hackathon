# ansible-hackathon

#TODO: Description  

## Installation

Prerequisites:
- OpenShift cluster with admin rights
- OpenShift GitOps installed with default configuration
- Ansible Automation Platform installed in OpenShift as an operator

## Exchange Rates Application

This application consists of two parts:

1. A [backend](exchange-rates-backend/README.md) developed with Flask that provides a REST service to get and update exchange rates.

2. A [frontend](exchange-rates-frontend/README.md) developed with React that consumes the REST service and displays the exchange rates in a graphical interface.

Application images has already been generated and uploaded to Quay.io:

- **Backend**: quay.io/calopezb/exchange-rates-back:1.0.1
- **Fronend**: quay.io/calopezb/exchange-rates-front:1.0.1

### Deploy locally with Podman (demo)

> [!NOTE]  
> if using a podman machine, run this before initializing the machine to be able to mount frontend configuration (create /tmp/config directory if needed): `podman machine init --volume /tmp/config:/tmp/config`

```sh
# Build Backend
podman build -t back exchange-rates-backend/.

# Run Backend
podman run -d \
  --name exchange-backend \
  -p 3000:5000 \
  back

# Test - get App Rates
curl localhost:3000/app_rates

# Test - get BCE USD Rate
curl localhost:3000/bce_rates/USD

# Test - modify USD value in App Rates
curl -X PUT http://127.0.0.1:3000/app_rates \
  -H "Content-Type: application/json" \
  -d '{
    "currency": "USD",
    "value": 1.07
  }'

# Build Frontend
podman build -t front exchange-rates-frontend/.

# Create configuration file)
mkdir /tmp/config
cat <<EOF > /tmp/config/config.json
{
  "REACT_APP_BACKEND": "http://127.0.0.1:3000"
}
EOF

# Run Frontend
podman run -d \
  --name exchange-frontend \
  --volume /tmp/config/config.json:/app/build/config/config.json \
  -p 8080:5000 \
  front

# Open localhost:8080
```

### Deploy in OpenShift (demo)

- Create a namespace:
```sh
oc new-project ansible-hackathon
```

- Review template parameters:
```sh
oc process --parameters -f deploy/exchange-rates-template.yaml
```

- Process template:
```sh
oc process \ 
  -p USER=demo \ 
  -p NAMESPACE=ansible-hackathon \ 
  -p HOST=apps.hetzner.calopezb.com \ 
  -f deploy/exchange-rates-template.yaml | oc create -f -
```




