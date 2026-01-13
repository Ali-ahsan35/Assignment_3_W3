const pool = require('../config/database');


class Location {

  static async create(locationData) {
    try {
      const query = `
        INSERT INTO locations 
        (location_name, country_code, country, additional_info)
        VALUES ($1, $2, $3, $4)
        RETURNING *
      `;
      
      const values = [
        locationData.location_name,
        locationData.country_code,
        locationData.country,
        JSON.stringify(locationData.additional_info || {})
      ];
      
      const result = await pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw new Error(`Error creating location: ${error.message}`);
    }
  }

  static async findByName(name) {
    try {
      const query = `
        SELECT * FROM locations 
        WHERE location_name ILIKE $1
        LIMIT 1
      `;
      
      const result = await pool.query(query, [`%${name}%`]);
      return result.rows[0] || null;
    } catch (error) {
      throw new Error(`Error finding location: ${error.message}`);
    }
  }
}

module.exports = Location;