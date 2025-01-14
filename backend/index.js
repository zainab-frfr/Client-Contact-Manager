// Main app -> Route -> Controller -> Model
require('dotenv').config();

const express = require("express");

// Define Routes
const communityCenterRoutes = require("./src/routes/InformationRoutes");


const db = require("./src/config/db");
const bodyParser = require("body-parser");

const cors = require("cors");

const corsOptions = {
  origin: true, // Replace with the origin of your Flutter web app
  methods: "GET,HEAD,PUT,PATCH,POST,DELETE",
  credentials: true, // Allow credentials if needed
};

const app = express();


// Middleware to enable CORS
app.use(cors(corsOptions));

// Middleware to parse JSON bodies
app.use(express.json());

// Middleware to parse URL-encoded bodies
app.use(bodyParser.urlencoded({ extended: true }));

// Routes
app.use("/api", communityCenterRoutes);

// Catch-all route to verify that the app is running
app.use("/", (req, res) => {
    res.json({ message: "App is running!" });
});

// Start Server and DB
const PORT = process.env.PORT || 4449;
db.initialize().then(() => {
  app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
  });
});