from flask import Flask, jsonify, request
import json
import os
from flask_cors import CORS

app = Flask(__name__)

# Enable CORS for all routes
CORS(app)

# Load exchange rates from file
def load_exchange_rates():
    with open('exchange_rates.json', 'r') as file:
        return json.load(file)

# Save exchange rates to file
def save_exchange_rates(exchange_rates):
    with open('exchange_rates.json', 'w') as file:
        json.dump(exchange_rates, file, indent=4)

exchange_rates = load_exchange_rates()

@app.route('/exchange_rates', methods=['GET'])
def get_exchange_rates():
    return jsonify(exchange_rates)

@app.route('/exchange_rates', methods=['PUT'])
def update_exchange_rate():
    data = request.json
    currency = data.get('currency')
    new_value = data.get('value')
    new_limit = data.get('limit')
    new_title = data.get('title')

    for rate in exchange_rates:
        if rate['currency'] == currency:
            if new_value is not None:
                rate['value'] = new_value
            if new_limit is not None:
                rate['limit'] = new_limit
            if new_title is not None:
                rate['title'] = new_title
            save_exchange_rates(exchange_rates)
            return jsonify({"message": "Exchange rate updated successfully"}), 200

    return jsonify({"error": "Currency not found"}), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)