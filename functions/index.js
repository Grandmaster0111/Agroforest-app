const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.soilMoistureAlert = functions.firestore
    .document("sensor_data/latest")
    .onUpdate(async (change, context) => {
      const newValue = change.after.data();
      const previousValue = change.before.data();

      // Check if soil moisture is critically low
      if (newValue.soil_moisture < 20 && previousValue.soil_moisture >= 20) {
        const payload = {
          notification: {
            title: "Low Soil Moisture Alert",
            body: "Soil moisture is critically low, irrigation started automatically.",
          },
        };

        // Send a notification to a topic
        return admin.messaging().sendToTopic("all", payload);
      }
      return null;
    });

exports.waterTankAlert = functions.firestore
    .document("sensor_data/latest")
    .onUpdate(async (change, context) => {
      const newValue = change.after.data();
      const previousValue = change.before.data();

      // Check if water tank is below 20%
      if (newValue.water_tank_level < 20 && previousValue.water_tank_level >= 20) {
        const payload = {
          notification: {
            title: "Low Water Tank Alert",
            body: "Water tank below 20% – refill required.",
          },
        };

        // Send a notification to a topic
        return admin.messaging().sendToTopic("all", payload);
      }
      return null;
    });

exports.weatherBasedIrrigation = functions.pubsub
    .schedule("every 1 hours")
    .onRun(async (context) => {
      // Replace with your actual weather API call logic
      const rainPredicted = true; 

      if (rainPredicted) {
        const payload = {
          notification: {
            title: "Weather Alert",
            body: "Rain predicted, skipping irrigation.",
          },
        };

        // Send a notification to a topic
        return admin.messaging().sendToTopic("all", payload);
      }
      return null;
    });
