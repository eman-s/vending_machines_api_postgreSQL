const { Client } = require('pg');

const client = new Client({
  user: '36chambers',
  host: 'localhost',
  database: 'vendordb',
  password: '',
  port: 5432,
});

client.connect();

module.exports = {
  query: (text, params, callback) => {
    return client.query(text, params, callback)
  }
}
