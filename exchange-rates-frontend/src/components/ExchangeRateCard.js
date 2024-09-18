import React from 'react';
import './ExchangeRateCard.css';

const ExchangeRateCard = ({ title, currency, value, limit, lastModified }) => {
  const isAboveLimit = value >= limit;
  return (
    <div className={`card ${isAboveLimit ? 'above-limit' : ''}`}>
      <h3>{title}</h3>
      <p>{value.toFixed(4)} {currency}</p>
      <small>{lastModified}</small>
    </div>
  );
};

export default ExchangeRateCard;
