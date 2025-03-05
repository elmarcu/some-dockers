import React from 'react';
import HlsPlayer from './components/HlsPlayer';

function App() {
  const hlsUrl = process.env.REACT_APP_HLS_URL || 'default-url-here';
  console.log(process.env.REACT_APP_HLS_URL);

  return (
    <div className="App">
      <h1>React HLS Player</h1>
      <HlsPlayer source={hlsUrl} />
    </div>
  );
}

export default App;
