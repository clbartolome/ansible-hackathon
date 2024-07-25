
# Exchange Rates Application - Frontend (React)

## Requirements

- npm

## Configuration

Application configuration is provided in the file `public/config/config.json`. Variables:
- REACT_APP_BACKEND >> backend application url (include protocol and port)

If running this application locally override this file values if needed.

In case of using Podman, Docker, Kubernetes, OpenShift... mount a directory with your `config.json` file in `app/build/config`.

## Installation

1. Clone this repository and navigate to the `frontend` directory:
    ```sh
    cd exchange-rates-frontend
    ```

2. Build application:
    ```sh
    npm run build
    ```

3. Run application:
    ```sh
    npm start
    ```
