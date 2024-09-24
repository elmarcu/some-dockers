import express from 'express';
import { Pool } from 'pg';

// Create a new Express app
const app = express();
const PORT = 3000;

// PostgreSQL connection setup
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: 5432
});

// Define a route to get data from the database
app.get('/users', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM users'); // Assuming 'users' table exists
    res.json(result.rows);
  } catch (err) {
    console.error('Error querying the database:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Start the Express server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
