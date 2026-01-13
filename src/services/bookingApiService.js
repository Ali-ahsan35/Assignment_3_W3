const axios = require('axios');

class BookingApiService {
  constructor() {
    this.apiKey = process.env.RAPIDAPI_KEY;
    this.apiHost = process.env.RAPIDAPI_HOST;
    this.baseURL = `https://${this.apiHost}`;
  }

  getHeaders() {
    return {
      'X-RapidAPI-Key': this.apiKey,
      'X-RapidAPI-Host': this.apiHost
    };
  }

   // ============ FLIGHT METHODS ============

  async searchAirport(location) {
    try {
      console.log(`Searching airport for: ${location}`);
      const response = await axios.get(`${this.baseURL}/api/v1/flights/searchDestination`, {
        headers: this.getHeaders(),
        params: {
          query: location
        }
      });
      
      console.log(`✓ Airport search response:`, response.data);
      return response.data.data || [];
    } catch (error) {
      console.error('Error searching airport:', error.response?.data || error.message);
      throw new Error(`Error searching airport: ${error.message}`);
    }
  }

  async searchFlights(params) {
    try { 
      // EXACT parameters for RapidAPI
      const requestParams = {
        fromId: params.fromId,
        toId: params.toId,
        departDate: params.departDate
      };
 
      
      const response = await axios.get(`${this.baseURL}/api/v1/flights/searchFlights`, {
        headers: this.getHeaders(),
        params: requestParams
      });

      if (response.data) {
        console.log(`   Response keys:`, Object.keys(response.data));
        if (response.data.data) {
          console.log(`   Data keys:`, Object.keys(response.data.data));
        }
      }

      
      const flightOffers = response.data.data?.flightOffers || [];
      console.log(`✓ Found ${flightOffers.length} flight offers\n`);
      
      return {
        data: {
          flights: flightOffers
        }
      };
    } catch (error) {
      console.error('\n❌ Error searching flights:');
      console.error('   Status:', error.response?.status);
      console.error('   Status Text:', error.response?.statusText);
      if (error.response?.data) {
        console.error('   Response Data:', JSON.stringify(error.response.data, null, 2));
      }
      console.error('   Error Message:', error.message);
      throw new Error(`Error searching flights: ${error.message}`);
    }
  }

  async getFlightDetails(token) {
    try {
      return {};
    } catch (error) {
      throw new Error(`Error getting flight details: ${error.message}`);
    }
  }

   // ============ ATTRACTION METHODS ============

  async searchAttractionLocation(query) {
  try {
    console.log(`🔍 Searching attractions for: ${query}`);

    const response = await axios.get(
      `${this.baseURL}/api/v1/attraction/searchLocation`,
      {
        headers: this.getHeaders(),
        params: { query }
      }
    );

    const products = response.data.data?.products || [];
    console.log(`✓ Found ${products.length} attractions`);

    return products;
  } catch (error) {
    console.error('❌ Error searching attractions:', error.response?.data || error.message);
    throw error;
  }
}

  async getAttractionDetails(slug) {
  try {
    console.log(`🔍 Getting attraction details for slug: ${slug}`);

    const response = await axios.get(
      `${this.baseURL}/api/v1/attraction/getAttractionDetails`,
      {
        headers: this.getHeaders(),
        params: { slug }
      }
    );

    return response.data.data || {};
  } catch (error) {
    console.error(`❌ Error getting details for ${slug}:`, error.response?.data || error.message);
    throw error;
  }
}

}

module.exports = new BookingApiService();