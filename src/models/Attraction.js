const pool = require('../config/database');


class Attraction {
 
  static async create(attractionData) {
    try {
      const query = `
        INSERT INTO attractions 
        (attraction_name, attraction_slug, additional_info, cancellation_policy,
         images, price, whats_included, country, city)
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
        RETURNING *
      `;
      
      const values = [
        attractionData.attraction_name,
        attractionData.attraction_slug,
        attractionData.additional_info,
        attractionData.cancellation_policy,
        JSON.stringify(attractionData.images || []),
        attractionData.price,
        attractionData.whats_included,
        attractionData.country,
        attractionData.city
      ];
      
      const result = await pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw new Error(`Error creating attraction: ${error.message}`);
    }
  }

  static async findByLocation(location) {
    try {
      const query = `
        SELECT * FROM attractions 
        WHERE country ILIKE $1 OR city ILIKE $1
        ORDER BY created_at DESC
      `;
      
      const result = await pool.query(query, [`%${location}%`]);
      return result.rows;
    } catch (error) {
      throw new Error(`Error finding attractions: ${error.message}`);
    }
  }

  static async findById(id) {
    try {
      const query = 'SELECT * FROM attractions WHERE id = $1';
      const result = await pool.query(query, [id]);
      return result.rows[0] || null;
    } catch (error) {
      throw new Error(`Error finding attraction by ID: ${error.message}`);
    }
  }

  /**
   * Get all attractions
   */
  static async findAll() {
    try {
      const query = 'SELECT * FROM attractions ORDER BY created_at DESC';
      const result = await pool.query(query);
      return result.rows;
    } catch (error) {
      throw new Error(`Error fetching all attractions: ${error.message}`);
    }
  }
}

module.exports = Attraction;