const pool = require('../config/database');

class Flight {

  static async create(flightData) {
    try {
      const query = `
        INSERT INTO flights 
        (flight_name, arrival_airport, departure_airport, arrival_time, 
         departure_time, flight_logo, fare, location_country, additional_info)
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
        RETURNING *
      `;
      
      const values = [
        flightData.flight_name,
        flightData.arrival_airport,
        flightData.departure_airport,
        flightData.arrival_time,
        flightData.departure_time,
        flightData.flight_logo,
        flightData.fare,
        flightData.location_country,
        JSON.stringify(flightData.additional_info || {})
      ];
      
      const result = await pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw new Error(`Error creating flight: ${error.message}`);
    }
  }


  static async findByLocation(location) {
    try {
      const query = `
        SELECT * FROM flights 
        WHERE location_country ILIKE $1
        ORDER BY departure_time DESC
      `;
      
      const result = await pool.query(query, [`%${location}%`]);
      return result.rows;
    } catch (error) {
      throw new Error(`Error finding flights: ${error.message}`);
    }
  }


  static async findById(id) {
    try {
      const query = 'SELECT * FROM flights WHERE id = $1';
      const result = await pool.query(query, [id]);
      return result.rows[0] || null;
    } catch (error) {
      throw new Error(`Error finding flight by ID: ${error.message}`);
    }
  }


  static async findAll() {
    try {
      const query = 'SELECT * FROM flights ORDER BY created_at DESC';
      const result = await pool.query(query);
      return result.rows;
    } catch (error) {
      throw new Error(`Error fetching all flights: ${error.message}`);
    }
  }

  /**
   * Delete a flight by ID
   * @param {number} id - Flight ID
   * @returns {Promise<boolean>} True if deleted
   */
  static async delete(id) {
    try {
      const query = 'DELETE FROM flights WHERE id = $1';
      const result = await pool.query(query, [id]);
      return result.rowCount > 0;
    } catch (error) {
      throw new Error(`Error deleting flight: ${error.message}`);
    }
  }
}

module.exports = Flight;