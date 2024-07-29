
# Exchange Rates Application - Backend (Flask)

Exchange rates are described in `app_rates.json`.

## Requirements

- Python 3.x

## Installation

1. Clone this repository and navigate to the `backend` directory:
    ```sh
    cd exchange-rates-backend
    ```

2. Install the dependencies:
    ```sh
    pip install -r requirements.txt

    # if a virtualenv is needed (virtualenv exchange && source exchange/bin/activate) before pip install command
    ```

3. Run the Flask server:
    ```sh
    python app.py
    ```

## Endpoints

### Get App Rates

- **URL**: `/app_rates`
- **HTTP Method**: `GET`
- **Description**: Retrieves the stored app rates (title, currency, value and limit).

### Update an App Rate

- **URL**: `/app_rates`
- **HTTP Method**: `PUT`
- **Description**: Updates the value and/or limit of a specific currency.
- **Request Body**:
    ```json
    {
      "currency": "string",
      "value": float,
      "limit": float
    }
    ```

### Get BCE Rate

- **URL**: `/bce_rates/<currency>`
- **HTTP Method**: `GET`
- **Description**: Retrieves the selected BCE rate (currency and value) or 404 Error if does not exists.


### Examples using `curl`

- Get Exchange Rates:
  ```sh
  curl -X GET http://127.0.0.1:5000/app_rates
  ```
- Update the value of a Currency
  ```sh
  curl -X PUT http://127.0.0.1:5000/app_rates \
    -H "Content-Type: application/json" \
    -d '{
      "currency": "GBP",
      "value": 0.9
    }'
  ```
