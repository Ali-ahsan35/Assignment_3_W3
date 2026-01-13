# 🌍 Travel Guide API

A Node.js + Express REST API that retrieves **flight** and **attraction** data using the Booking.com RapidAPI, stores it in a **PostgreSQL** database, and exposes a unified search endpoint for clients.

This project was built as part of an internship/assignment to demonstrate:
- API integration
- Data processing
- Database design
- RESTful API development
- Docker-based setup

---

## 🛠 Tech Stack

- **Backend:** Node.js, Express.js
- **Database:** PostgreSQL
- **API Integration:** Booking.com API (via RapidAPI)
- **Containerization:** Docker & Docker Compose
- **Environment Management:** dotenv

---

## 📁 Project Structure

```sh
TRAVEL-GUIDE-API
│
├── node_modules/
│
├── scripts/
│ ├── fetchAndSaveAttractions.js # Fetch attractions from API & store in DB
│ ├── fetchAndSaveFlights.js # Fetch flights from API & store in DB
│ └── testDataRetrieval.js # Test API data retrieval
│
├── src/
│ ├── config/
│ │ └── database.js # PostgreSQL connection
│ │
│ ├── controllers/
│ │ └── searchController.js # /search/:location controller
│ │
│ ├── middleware/
│ │ └── errorHandler.js # Centralized error handling
│ │
│ ├── models/
│ │ ├── Attraction.js # Attraction DB model
│ │ ├── Flight.js # Flight DB model
│ │ └── Location.js # Location DB model
│ │
│ ├── routes/
│ │ └── index.js # API routes
│ │
│ ├── services/
│ │ ├── bookingApiService.js # RapidAPI interaction logic
│ │ └── dataRetrieval.js # High-level data retrieval workflow
│ │
│ ├── utils/
│ │ └── database.sql # Database schema
│ │
│ ├── app.js # Express app configuration
│ └── server.js # Server entry point
│
├── .env # Environment variables
├── docker-compose.yml # Docker services configuration
├── package.json
├── package-lock.json
└── README.md
```

---

## Environment Variables

Create a `.env` file in the project root:

```env
PORT=5000

DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASSWORD=your_password
DB_NAME=travel_guide

RAPIDAPI_KEY=your_rapidapi_key
RAPIDAPI_HOST=booking-com15.p.rapidapi.com
```
## Docker Setup (Recommended)

### Start PostgreSQL using Docker

```
docker-compose up -d
```


This will:

- Start PostgreSQL
- Expose it on port 5432

### Install Dependencies (Without Docker)
```
npm install
```
### Run the Server

```
npm start
```

Server will run at:
```
http://localhost:5000
```
### Data Population Scripts

#### Fetch & store flight data
```
node scripts/fetchAndSaveFlights.js
```

#### Fetch & store attraction data
```
node scripts/fetchAndSaveAttractions.js
```

#### Test API data retrieval
```
node scripts/testDataRetrieval.js
```
---

### API Endpoints

#### Search API
```
GET /search/:locationname
```
#### Example:
```
GET /search/Dubai
```
#### Response Format:
```

{
  "GeoInfo": {
    "location_name": "Dubai",
    "country": "United Arab Emirates"
  },
  "Flights": [
    {
      "flight_name": "Emirates",
      "departure_airport": "DXB",
      "arrival_airport": "DEL",
      "fare": 450
    }
  ],
  "Attractions": [
    {
      "attraction_name": "Dubai Desert Safari",
      "price": 120,
      "city": "Dubai"
    }
  ]
}
```
### Database Schema

#### Database schema is defined in:

```
src/utils/database.sql
```

#### Tables:

- locations
- flights
- attractions

### Key Features

- RESTful API design
- External API integration
- PostgreSQL data persistence
- Dockerized database
- Modular and scalable architecture
- Centralized error handling

### Notes

- External APIs are used only for data ingestion
- Client-facing APIs read data only from the database
- Rate limiting handled via request delays

### Author
#### Syed Ali Ahsan
