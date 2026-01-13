require("dotenv").config();
const app = require("./app");
const pool = require("./config/database");

const PORT = process.env.PORT || 5000;

// Test database connection before starting server
pool.query('SELECT NOW()')
  .then((res) => {
    console.log('Connected to PostgreSQL database');
    console.log('Server time:', res.rows[0].now);
    
    // Start server only if database connection is successful
    app.listen(PORT, () => {
      console.log(`Server running on port ${PORT}`);
    });
  })
  .catch((err) => {
    console.error('Database connection failed:', err.message);
    console.error('Make sure PostgreSQL is running and credentials are correct');
    process.exit(1);
  });