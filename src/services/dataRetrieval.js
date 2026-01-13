const bookingApi = require('./bookingApiService');
const Flight = require('../models/Flight');
const Attraction = require('../models/Attraction');
const Location = require('../models/Location');

async function retrieveFlightData(fromLocation, toLocation, departDate) {
  try {
    console.log(`\n=== Starting flight data retrieval for ${fromLocation} to ${toLocation} ===\n`);

    // Step 1: Search for departure airport
    console.log('Step 1: Searching departure airport...');
    const fromAirportData = await bookingApi.searchAirport(fromLocation);
    const fromAirportId = fromAirportData[0]?.id;
    const fromAirportName = fromAirportData[0]?.name;

    // Step 2: Search for arrival airport
    console.log('Step 2: Searching arrival airport...');
    const toAirportData = await bookingApi.searchAirport(toLocation);
    const toAirportId = toAirportData[0]?.id;
    const toAirportName = toAirportData[0]?.name;

    if (!fromAirportId || !toAirportId) {
      throw new Error('Could not find airport IDs for the given locations');
    }

    console.log(`   ✓ From: ${fromAirportName} (${fromAirportId})`);
    console.log(`   ✓ To: ${toAirportName} (${toAirportId})`);

console.log('\nStep 3: Searching flights...');
const flightSearchResults = await bookingApi.searchFlights({
  fromId: fromAirportId,
  toId: toAirportId,
  departDate: departDate,
  adults: 1
});

const token = flightSearchResults.token;

if (!token) {
  throw new Error('No flight token found');
}

console.log(`   ✓ Flight token retrieved: ${token}`);

return token;


    console.log('\nStep 4: Processing and storing flights...');
    let savedCount = 0;
    
  } catch (error) {
    console.error('\n❌ Error in retrieveFlightData:', error.message);
    throw error;
  }
}

/**
 * Retrieve and store attraction data for a location
 */
async function retrieveAttractionData(locationName) {
  try {
    console.log(`\n=== Starting attraction data retrieval for ${locationName} ===\n`);

    // Search location
    console.log('Step 1: Searching location...');
    const locationData = await bookingApi.searchLocation(locationName);
    const destinations = locationData.destinations || [];

    if (destinations.length === 0) {
      throw new Error('No destinations found');
    }

    const destination = destinations[0];
    const destId = destination.dest_id || destination.id;
    
    console.log(`   ✓ Found: ${destination.name}`);

    // Save location information
    await Location.create({
      location_name: destination.name,
      country_code: destination.country_code || destination.cc1,
      country: destination.country,
      additional_info: {
        dest_id: destId,
        dest_type: destination.dest_type
      }
    });

    // Get attractions
    console.log('\nStep 2: Fetching attractions...');
    const attractionsData = await bookingApi.getAttractions(destId);
    const attractions = attractionsData.products || [];

    if (attractions.length === 0) {
      console.log('   ⚠ No attractions found');
      return 0;
    }

    console.log(`   ✓ Found ${attractions.length} attractions`);

    // Process and store attractions
    console.log('\nStep 3: Processing and storing attractions...');
    let savedCount = 0;
    
    for (const attraction of attractions.slice(0, 10)) {
      try {
        const slug = attraction.slug;
        const attractionDetails = await bookingApi.getAttractionDetails(slug);

        const attractionData = {
          attraction_name: attraction.name || attractionDetails.name,
          attraction_slug: slug,
          additional_info: attractionDetails.description || attraction.shortDescription || '',
          cancellation_policy: attractionDetails.cancellationPolicy?.description || 'Check with provider',
          images: attraction.images || [],
          price: attraction.price?.amount || 0,
          whats_included: attractionDetails.included?.join(', ') || '',
          country: destination.country,
          city: destination.name
        };

        await Attraction.create(attractionData);
        savedCount++;
        console.log(`   ✓ [${savedCount}] ${attractionData.attraction_name}`);
        
      } catch (error) {
        console.error(`   ✗ Error saving attraction:`, error.message);
      }
    }

    console.log(`\n=== Successfully stored ${savedCount} attractions ===\n`);
    return savedCount;

  } catch (error) {
    console.error('\n❌ Error in retrieveAttractionData:', error.message);
    throw error;
  }
}

module.exports = {
  retrieveFlightData,
  retrieveAttractionData
};