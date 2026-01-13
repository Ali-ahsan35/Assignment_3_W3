require('dotenv').config();
const bookingApi = require('../src/services/bookingApiService');
const Attraction = require('../src/models/Attraction');
const Location = require('../src/models/Location');


const locations = ['Amsterdam', 'Dubai'];

const ATTRACTIONS_PER_LOCATION = 5;

async function fetchAndSaveAttractions() {
  try {

    let totalSaved = 0;
    let totalErrors = 0;

    // Loop through each location
    for (const locationName of locations) {


      try {
       
        
        const products = await bookingApi.searchAttractionLocation(locationName);

        if (products.length === 0) {
        console.log(`No attractions found for ${locationName}`);
        continue;
        }

        const slugs = products
        .slice(0, ATTRACTIONS_PER_LOCATION)
        .map(p => ({
            slug: p.productSlug,
            name: p.title,
            city: p.cityName,
            country: p.countryCode
        }));

        console.log(`-> Collected ${slugs.length} attraction slugs`);



        for (let i = 0; i < slugs.length; i++) {
        const { slug, name, city, country } = slugs[i];

        try {
            console.log(`\n[${i + 1}/${slugs.length}] Processing: ${name}`);
            console.log(`   Slug: ${slug}`);

            console.log(`   → Fetching detailed information...`);
            const attractionDetails = await bookingApi.getAttractionDetails(slug);

            const images = attractionDetails.images || [];
            const price =
            attractionDetails.priceBreakdown?.grossPrice?.value || 0;

            const whatsIncluded =
            attractionDetails.included?.join(', ') ||
            attractionDetails.highlights?.join(', ') ||
            'Not specified';

            const attractionData = {
            attraction_name: attractionDetails.title || name,
            attraction_slug: slug,
            additional_info:
                attractionDetails.description || 'No description available',
            cancellation_policy:
                attractionDetails.cancellationPolicy?.description || 'Not specified',
            images: images,
            price: price,
            whats_included: whatsIncluded,
            country: country,
            city: city
            };

            console.log(`→ Saving to database...`);
            await Attraction.create(attractionData);

            await new Promise(resolve => setTimeout(resolve, 500));

        } catch (error) {
            errorCount++;
            totalErrors++;
            console.log(`ERROR: ${error.message}`);
        }
        }

      } catch (error) {
        console.error(`\n Error processing ${locationName}:`, error.message);
      }
    }

    process.exit(0);

  } catch (error) {
    console.error('\n FATAL ERROR:', error.message);
    console.error(error);
    process.exit(1);
  }
}

// Run the function
fetchAndSaveAttractions();