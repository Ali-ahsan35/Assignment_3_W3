const Flight = require('../models/Flight');
const Attraction = require('../models/Attraction');
const Location = require('../models/Location');


const searchByLocation = async (req, res) => {
  try {
    const { locationname } = req.params;

    // Validate location parameter
    if (!locationname || locationname.trim() === '') {
      return res.status(400).json({
        success: false,
        message: 'Location name is required'
      });
    }

    console.log(`\n Searching for location: ${locationname}`);

    // Get location information (GeoInfo)
    const geoInfo = await Location.findByName(locationname);

    // Search for flights by location
    // Flight search looks in: departure_airport, arrival_airport, location_country
    const flights = await Flight.findByLocation(locationname);
    console.log(flights)
    // Search for attractions by location
    // Attraction search looks in: city, country
    const attractions = await Attraction.findByLocation(locationname);

    console.log(`   ✓ Flights found: ${flights.length}`);
    console.log(`   ✓ Attractions found: ${attractions.length}`);

    // Prepare GeoInfo response
    const geoInfoResponse = geoInfo ? {
      location_name: geoInfo.location_name,
      country_code: geoInfo.country_code,
      country: geoInfo.country,
      additional_info: geoInfo.additional_info
    } : {
      location_name: locationname,
      message: 'No detailed location information available'
    };

    // Prepare Flights response
    const flightsResponse = flights.map(flight => ({
      id: flight.id,
      flight_name: flight.flight_name,
      departure_airport: flight.departure_airport,
      arrival_airport: flight.arrival_airport,
      departure_time: flight.departure_time,
      arrival_time: flight.arrival_time,
      flight_logo: flight.flight_logo,
      fare: parseFloat(flight.fare),
      location_country: flight.location_country,
      additional_info: flight.additional_info
    }));

    // Prepare Attractions response
    const attractionsResponse = attractions.map(attraction => ({
      id: attraction.id,
      attraction_name: attraction.attraction_name,
      attraction_slug: attraction.attraction_slug,
      additional_info: attraction.additional_info,
      cancellation_policy: attraction.cancellation_policy,
      images: attraction.images,
      price: parseFloat(attraction.price),
      whats_included: attraction.whats_included,
      country: attraction.country,
      city: attraction.city
    }));

    // Final response following the assignment pattern
    const response = {
      GeoInfo: geoInfoResponse,
      Flights: flightsResponse,
      Attractions: attractionsResponse
    };

    res.status(200).json(response);

  } catch (error) {
    console.error('❌ Error in searchByLocation:', error);
    res.status(500).json({
      success: false,
      message: 'Internal server error while searching',
      error: error.message
    });
  }
};

module.exports = {
  searchByLocation
};