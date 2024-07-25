
# Exchange Rates Application - Backend (Flask)

## Requirements

- Python 3.x
- Flask

## Installation

1. Clone this repository and navigate to the `backend` directory:
    ```sh
    cd exchange-rates-backend
    ```

2. Install the dependencies:
    ```sh
    pip install flask

    # if a virtualenv is needed (virtualenv flask && source flask/bin/activate) before pip install command
    ```

3. Run the Flask server:
    ```sh
    python app.py
    ```

## Endpoints

### Get Exchange Rates

- **URL**: `/exchange_rates`
- **HTTP Method**: `GET`
- **Description**: Retrieves the stored exchange rates (currency, value and limit).

### Update an Exchange Rate

- **URL**: `/exchange_rates`
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

### Examples using `curl`

- Get Exchange Rates:
  ```sh
  curl -X GET http://127.0.0.1:5000/exchange_rates
  ```
- Update the Value of a Currency
  ```sh
  curl -X PUT http://127.0.0.1:5000/exchange_rates \
    -H "Content-Type: application/json" \
    -d '{
      "currency": "GBP",
      "value": 0.95
    }'
  ```
