require('dotenv').config();
const bookingApi = require('../src/services/bookingApiService');
const Flight = require('../src/models/Flight');

const locations = ['Amsterdam', 'Dubai'];

const DEPART_DATE = '2026-01-13';

const FLIGHTS_PER_ROUTE = 8;

async function fetchAndSaveFlights() {
  try {
    
    const airportMap = {};
    
    for (const location of locations) {
      console.log(`\n🔍 Searching airport for: ${location}`);
      const airports = await bookingApi.searchAirport(location);
      
      if (!airports || airports.length === 0) {
        throw new Error(`No airports found for ${location}`);
      }
      
      const airport = airports[0];
      airportMap[location] = {
        id: airport.id,
        name: airport.name,
        code: airport.code
      };
      
      console.log(`-> Airport ID: ${airport.id}`);
      console.log(`-> Airport Name: ${airport.name}`);
    }

    
    const allTokens = [];
    let routeCount = 0;
    
    for (let i = 0; i < locations.length; i++) {
      for (let j = 0; j < locations.length; j++) {
        if (i === j) continue;
        
        const fromLocation = locations[i];
        const toLocation = locations[j];
        const fromAirportId = airportMap[fromLocation].id;
        const toAirportId = airportMap[toLocation].id;
        
        routeCount++;
        console.log(`\n[Route ${routeCount}] ${fromLocation} → ${toLocation}`);
        console.log(`Airport IDs: ${fromAirportId} → ${toAirportId}`);
        
        // Search flights with parameters
        const flightResults = await bookingApi.searchFlights({
          fromId: fromAirportId,
          toId: toAirportId,
          departDate: DEPART_DATE
        });
        
        const flights = flightResults.data?.flights || [];
        
        if (flights.length === 0) {
          console.log(`No flights found for this route`);
          continue;
        }
        
        console.log(`Found ${flights.length} flights`);
        
        const flightsToSave = flights.slice(0, FLIGHTS_PER_ROUTE);
        
        for (const flight of flightsToSave) {
          allTokens.push({
            token: flight.token,
            flight: flight,
            route: `${fromLocation} → ${toLocation}`,
            fromAirport: airportMap[fromLocation].name,
            toAirport: airportMap[toLocation].name
          });
        }
        
        console.log(`   ✓ Collected ${flightsToSave.length} flight tokens`);
        
        // delay to avoid rate limiting
        await new Promise(resolve => setTimeout(resolve, 1000));
      }
    }


    //Save to database
    
    let savedCount = 0;
    let errorCount = 0;
    
    for (let i = 0; i < allTokens.length; i++) {
      const { token, flight, route, fromAirport, toAirport } = allTokens[i];
      
      try {
        console.log(`\n[${i + 1}/${allTokens.length}] Processing flight: ${route}`);
        
        const segment = flight.segments?.[0];
        const leg = segment?.legs?.[0];
        const carrier = leg?.carriersData?.[0];
        
        const priceBreakdown = flight.priceBreakdown?.total;
        const totalPrice = priceBreakdown
          ? priceBreakdown.units + (priceBreakdown.nanos / 1000000000)
          : 0;
        
        const flightData = {
          flight_name: carrier?.name || 'Unknown',
          departure_airport: fromAirport,
          arrival_airport: toAirport,
          departure_time: segment?.departureTime,
          arrival_time: segment?.arrivalTime,
          flight_logo: carrier?.logo || null,
          fare: totalPrice,
          location_country: segment?.arrivalAirport?.countryName || toAirport.split(' ')[0],
          additional_info: {
            token: token.substring(0, 50),
            flight_number: leg?.flightInfo?.flightNumber,
            cabin_class: leg?.cabinClass,
            total_time: segment?.totalTime,
            currency: priceBreakdown?.currencyCode || 'USD',
            route: route
          }
        };
        
        await Flight.create(flightData);
        savedCount++;
        
        console.log(`SAVED: ${flightData.flight_name} - $${totalPrice.toFixed(2)}`);
        
      } catch (error) {
        errorCount++;
        console.log(`ERROR: ${error.message}`);
      }
    }
        
    process.exit(0);
    
  } catch (error) {
    console.error('\n FATAL ERROR:', error.message);
    console.error(error);
    process.exit(1);
  }
}

fetchAndSaveFlights();