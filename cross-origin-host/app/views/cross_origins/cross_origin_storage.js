const env = '<%= Rails.env %>';

window.addEventListener('DOMContentLoaded', () => {
  // There is not specific target for this one. It is ok because it just say loaded
  window.parent.postMessage('loaded', '*');

  const domains = env === 'development'
    ? [
      'http://localhost:3000',
      'http://localhost:4567',
    ]
    : [
      'https://secure.holistics.io',
      'https://eu.holistics.io',
      'https://us.holistics.io',
      'https://www.holistics.io',
    ];

  const setDomains = env === 'development'
    ? [
      'http://localhost:3000',
    ]
    : [
      'https://secure.holistics.io',
      'https://eu.holistics.io',
      'https://us.holistics.io',
    ];

  const returnDataDomain = env === 'development' ? 'http://localhost:4567' : 'https://www.holistics.io';
  const allowedKeys = ['last_visited_holistics_host'];

  window.onmessage = (event) => {
    // Validation code
    if (!domains.includes(event.origin)) {
      return;
    }
    const { action, key, value } = event.data;
    if (!allowedKeys.includes(key)) {
      return;
    }

    if (action === 'set') {
      if (!setDomains.includes(event.origin)) {
        return;
      }
      window.localStorage.setItem(key, JSON.stringify(value));
    } else if (action === 'get') {
      event.source.postMessage({
        action: 'returnData',
        key,
        value: JSON.parse(window.localStorage.getItem(key)),
      }, returnDataDomain);
    }
  };
}, false);