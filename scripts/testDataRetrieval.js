require('dotenv').config();
const { retrieveFlightData, retrieveAttractionData } = require('../src/services/dataRetrieval');

async function test() {
  try {
    console.log('🚀 Starting data retrieval test...\n');
    
    // Test flight retrieval
    await retrieveFlightData('Mumbai', 'Delhi', '2026-02-15');
    
    // Test attraction retrieval
    await retrieveAttractionData('Mumbai');
    
    console.log('\n✅ All data retrieval completed successfully!');
    process.exit(0);
  } catch (error) {
    console.error('\n❌ Test failed:', error.message);
    process.exit(1);
  }
}

test();