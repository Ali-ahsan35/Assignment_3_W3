const express = require('express');
const bookingApi = require('../services/bookingApiService');
const Flight = require('../models/Flight');
const { searchByLocation } = require('../controllers/searchController');

const router = express.Router();

router.get('/search/:locationname', searchByLocation);


router.get('/details/:id', (req, res) => {
  res.json({
    message: 'Details route - Coming soon',
    id: req.params.id,
    searchtype: req.query.searchtype
  });
});


router.get('/search-airport', async (req, res) => {
  try {
    const query = req.query.query || 'Mumbai';

    console.log(`\n=== STEP 1: Search flight location & retrieve airport ID ===`);
    console.log(`Query: ${query}\n`);

    const airports = await bookingApi.searchAirport(query);

    if (!airports || airports.length === 0) {
      return res.status(404).json({
        success: false,
        message: `No airports found for query: ${query}`,
        step: 'Step 1: Search flight location & retrieve airport ID',
        query: query
      });
    }

    const airportList = airports.map(airport => ({
      id: airport.id,
      name: airport.name,
      code: airport.code,
      city: airport.cityName,
      country: airport.countryName
    }));

    console.log(`✓ Found ${airports.length} airports`);

    res.json({
      success: true,
      step: 'Step 1: Search flight location & retrieve airport ID',
      query: query,
      total_airports: airports.length,
      airports: airportList,
      raw_response: airports
    });

  } catch (error) {
    console.error('Error:', error.message);
    res.status(500).json({
      success: false,
      error: error.message
    });
  }
});


 //Step 2: Fetch flights using airport ID & retrieve flight token
 
router.get('/search-flights', async (req, res) => {
  try {
    const fromId = req.query.fromId || 'BOM.AIRPORT';
    const toId = req.query.toId || 'DEL.AIRPORT';
    const departDate = req.query.date || '2026-01-20';

    console.log(`\n=== STEP 2: Fetch flights using airport ID & retrieve flight token ===`);
    console.log(`From ID: ${fromId} → To ID: ${toId}`);
    console.log(`Date: ${departDate}\n`);

    const flightResults = await bookingApi.searchFlights({
      fromId,
      toId,
      departDate,
      adults: 1
    });

    const flights = flightResults.data?.flights || [];

    if (flights.length === 0) {
      return res.json({
        success: false,
        step: 'Step 2: Fetch flights using airport ID & retrieve flight token',
        message: 'No flights found for this route',
        query: { fromId, toId, departDate },
        total_flights: 0,
        flight_tokens: []
      });
    }

    const flightTokens = flights.map((flight, index) => {
      const segment = flight.segments?.[0];
      const leg = segment?.legs?.[0];
      const carrier = leg?.carriersData?.[0];

      return {
        index: index + 1,
        token: flight.token,
        airline: carrier?.name,
        departure_time: segment?.departureTime,
        arrival_time: segment?.arrivalTime
      };
    });

    console.log(`✓ Found ${flights.length} flights with tokens`);

    res.json({
      success: true,
      step: 'Step 2: Fetch flights using airport ID & retrieve flight token',
      query: { fromId, toId, departDate },
      total_flights: flights.length,
      flight_tokens: flightTokens,
      raw_first_flight: flights[0]
    });

  } catch (error) {
    console.error('Error:', error.message);
    res.status(500).json({
      success: false,
      error: error.message
    });
  }
});

/**
 * Fetch flight details using token & save to database
 */
router.post('/save-flights', async (req, res) => {
  try {
    const { fromId, toId, departDate } = req.body;

    if (!fromId || !toId || !departDate) {
      return res.status(400).json({
        success: false,
        message: 'fromId, toId, and departDate are required',
        example: {
          fromId: 'BOM.AIRPORT',
          toId: 'DEL.AIRPORT',
          departDate: '2026-01-20'
        }
      });
    }

    const flightResults = await bookingApi.searchFlights({
      fromId,
      toId,
      departDate,
      adults: 1
    });

    const flights = flightResults.data?.flights || [];

    if (flights.length === 0) {
      return res.json({
        success: false,
        step: 'Step 3: Fetch flight details using token & save to database',
        message: 'No flights found to save',
        saved_count: 0
      });
    }

    console.log(`Found ${flights.length} flights. Processing...`);

    let savedCount = 0;
    const savedFlights = [];

    for (let i = 0; i < Math.min(flights.length, 10); i++) {
      const flight = flights[i];

      try {
        const flightToken = flight.token;
        console.log(`\n[${i + 1}] Processing token: ${flightToken.substring(0, 30)}...`);

        await bookingApi.getFlightDetails(flightToken);
        console.log('  → Flight details retrieved');

        const segment = flight.segments?.[0];
        const leg = segment?.legs?.[0];
        const carrier = leg?.carriersData?.[0];

        const priceBreakdown = flight.priceBreakdown?.total;
        const totalPrice = priceBreakdown
          ? priceBreakdown.units + (priceBreakdown.nanos / 1000000000)
          : 0;

        const flightData = {
          flight_name: carrier?.name || 'Unknown',
          departure_airport: segment?.departureAirport?.name || 'N/A',
          arrival_airport: segment?.arrivalAirport?.name || 'N/A',
          departure_time: segment?.departureTime,
          arrival_time: segment?.arrivalTime,
          flight_logo: carrier?.logo || null,
          fare: totalPrice,
          location_country: segment?.arrivalAirport?.countryName || 'N/A',
          additional_info: {
            token: flightToken,
            flight_number: leg?.flightInfo?.flightNumber,
            cabin_class: leg?.cabinClass,
            total_time: segment?.totalTime,
            currency: priceBreakdown?.currencyCode || 'USD'
          }
        };

        const savedFlight = await Flight.create(flightData);
        savedCount++;
        savedFlights.push({
          id: savedFlight.id,
          flight_name: savedFlight.flight_name,
          fare: savedFlight.fare
        });

        console.log(`  ✓ Saved to database: ${flightData.flight_name} - $${totalPrice.toFixed(2)}`);

      } catch (error) {
        console.error(`  ✗ Error saving flight ${i + 1}:`, error.message);
      }
    }

    console.log(`\n=== COMPLETED: ${savedCount} flights saved to database ===\n`);

    res.json({
      success: true,
      step: 'Step 3: Fetch flight details using token & save to database',
      message: `Successfully saved ${savedCount} flights to database`,
      query: { fromId, toId, departDate },
      total_flights_found: flights.length,
      saved_count: savedCount,
      saved_flights: savedFlights
    });

  } catch (error) {
    console.error('Error:', error.message);
    res.status(500).json({
      success: false,
      error: error.message
    });
  }
});

/**
 * Get all saved flights from database
 */
router.get('/flights', async (req, res) => {
  try {
    const flights = await Flight.findAll();

    res.json({
      success: true,
      message: 'Flights retrieved from database',
      total: flights.length,
      flights: flights
    });

  } catch (error) {
    console.error('❌ Error:', error.message);
    res.status(500).json({
      success: false,
      error: error.message
    });
  }
});

module.exports = router;