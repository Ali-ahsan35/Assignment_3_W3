const express = require("express");
const cors = require("cors");
const apiRoutes = require("./routes");

const app = express();

// Middlewares
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Test route
app.get("/", (req, res) => {
  res.json({
    success: true,
    message: "Travel Guide API is running",
    version: "1.0.0",
    endpoints: {
      search: "/search/:locationname",
      details: "/details/:id?searchtype=flight|attraction"
    }
  });
});

// API Routes
app.use("/", apiRoutes);

module.exports = app;