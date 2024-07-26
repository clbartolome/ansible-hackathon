# ansible-hackathon

#TODO: Description

## Exchange Rates Application

This application consists of two parts:

1. A [backend](exchange-rates-backend/README.md) developed with Flask that provides a REST service to get and update exchange rates.

2. A [frontend](exchange-rates-frontend/README.md) developed with React that consumes the REST service and displays the exchange rates in a graphical interface.

Application images has already been generated and uploaded to Quay.io:

- **Backend**: quay.io/calopezb/exchange-rates-back:1.0.0
- **Fronend**: quay.io/calopezb/exchange-rates-front:1.0.0

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




