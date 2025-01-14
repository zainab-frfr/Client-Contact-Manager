/**
 * Controller for community center operations
 */

const {
    listAllInformation,
    newInformation,
    updateInformationByClientName,
} = require("../models/InformationModel");
const db = require("../config/db");

/**
 * Get all community center
 * @param req - Request object
 * @param res - Response object
 */
async function getAllInformation(req, res) {
    try {
        // get all CommunityCenters
        const CommunityCenters = await listAllInformation();

        // send response with CommunityCenters in json
        res.json({ data: CommunityCenters });
    } catch (error) {
        res.status(500).json({ message: "Error fetching information", error: err });
    }
}

/**
 * Add a new community center
 * @param req - Request object
 * @param res - Response object
 */
async function addInformation(req, res) {
    try {
      await newInformation(req.body);
      res.status(201).json({ message: "Information added successfully" });
    } catch (err) {
      res.status(500).json({ message: "Error adding information", error: err });
    }
}

/**
 * Update a community center
 * @param req - Request object
 * @param res - Response object
 */
async function updateInformation(req, res) {
    try {
      const updatedData = req.body;
      console.log(updatedData);
  
      const result = await updateInformationByClientName(updatedData);
  
      if (result.rowsAffected > 0) {
        res.json({ message: "Community center updated successfully" });
      } else {
        res.status(404).json({ message: "Community center not found" });
      }
    } catch (err) {
      res.status(500).json({ message: "Error updating community center", error: err });
    }
}
  


module.exports = {
    getAllInformation,
    addInformation,
    updateInformation,
};