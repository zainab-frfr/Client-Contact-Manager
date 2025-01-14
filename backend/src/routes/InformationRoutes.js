const express = require("express");
const router = express.Router();
const InformationController = require('../controllers/InformationController');

router.get("/information", InformationController.getAllInformation);
router.post("/information", InformationController.addInformation);
router.put("/information", InformationController.updateInformation);

module.exports = router;