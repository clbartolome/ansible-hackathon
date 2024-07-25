import React from 'react';
import './ExchangeRateCard.css';

const ExchangeRateCard = ({ title, currency, value, limit }) => {
  const isAboveLimit = value > limit;

  const getCurrentDateTime = () => {
    const now = new Date();
    return now.toLocaleString('en-GB', { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit', second: '2-digit' });
  };

  return (
    <div className={`card ${isAboveLimit ? 'above-limit' : ''}`}>
      <h3>{title}</h3>
      <p>{value.toFixed(4)} {currency}</p>
      <small>{getCurrentDateTime()}</small>
    </div>
  );
};

export default ExchangeRateCard;
