import React, { useEffect, useState } from 'react';
import { fetchConfig } from './config';
import { setConfig } from './globalConfig';
import './App.css';
import ExchangeRateList from './components/ExchangeRateList';

function App() {

  const [isConfigLoaded, setIsConfigLoaded] = useState(false);

  useEffect(() => {
    const initializeConfig = async () => {
      const configData = await fetchConfig();
      setConfig(configData);
      setIsConfigLoaded(true);
    };

    initializeConfig();
  }, []);

  if (!isConfigLoaded) {
    return <div>Loading...</div>;
  }

  return (
    <div className="App">
      <header className="App-header">
        <h1>Exchange Rates App</h1>
      </header>
      <ExchangeRateList />
    </div>
  );
}

export default App;
