import React, { useEffect, useState, useCallback } from 'react';
import axios from 'axios';
import ExchangeRateCard from './ExchangeRateCard';
import './ExchangeRateList.css';
import { getConfig } from '../globalConfig';



const ExchangeRateList = () => {
  const [exchangeRates, setExchangeRates] = useState([]);
  const apiUrl =  getConfig().REACT_APP_BACKEND || 'http://127.0.0.1:5000';
  const ratesPath = '/app_rates';

  const fetchExchangeRates = useCallback(() => {
    axios.get(`${apiUrl}${ratesPath}`)
      .then(response => {
        setExchangeRates(response.data);
      })
      .catch(error => {
        console.error('There was an error fetching the exchange rates!', error);
      });
  }, []);

  useEffect(() => {
    fetchExchangeRates();
  }, [fetchExchangeRates]);

  return (
    <div>
      <h2>Estadísticas de tipos de cambio</h2>
      <p>
        Esta sección recoge la información sobre los tipos de cambio oficiales del euro, facilitados por el Banco Central Europeo,
        así como la de otros tipos de cambio del euro. Además, también ofrece información sobre índices de competitividad
        respecto a otras áreas económicas.
      </p>
      <h3>Últimos datos:</h3>
      <div className="exchange-rate-list">
        {exchangeRates.map((rate, index) => (
          <ExchangeRateCard
            key={index}
            title={rate.title}
            currency={rate.currency}
            value={rate.value}
            limit={rate.limit}
            lastModified={rate.last_modified}
          />
        ))}
      </div>
    </div>
  );
};

export default ExchangeRateList;
