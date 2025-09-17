const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

// --- Alerts & Notifications ---

exports.soilMoistureAlert = functions.firestore
    .document("sensor_data/latest")
    .onUpdate(async (change, context) => {
      const newValue = change.after.data();
      const previousValue = change.before.data();

      if (newValue.soil_moisture < 20 && previousValue.soil_moisture >= 20) {
        const payload = {
          notification: {
            title: "Low Soil Moisture Alert",
            body: "Soil moisture is critically low, irrigation started automatically.",
          },
        };
        return admin.messaging().sendToTopic("all", payload);
      }
      return null;
    });

exports.waterTankAlert = functions.firestore
    .document("sensor_data/latest")
    .onUpdate(async (change, context) => {
      const newValue = change.after.data();
      const previousValue = change.before.data();

      if (newValue.water_tank_level < 20 && previousValue.water_tank_level >= 20) {
        const payload = {
          notification: {
            title: "Low Water Tank Alert",
            body: "Water tank below 20% – refill required.",
          },
        };
        return admin.messaging().sendToTopic("all", payload);
      }
      return null;
    });

exports.weatherBasedIrrigation = functions.pubsub
    .schedule("every 1 hours")
    .onRun(async (context) => {
      const rainPredicted = true; // Replace with actual weather API call
      if (rainPredicted) {
        const payload = {
          notification: {
            title: "Weather Alert",
            body: "Rain predicted, skipping irrigation.",
          },
        };
        return admin.messaging().sendToTopic("all", payload);
      }
      return null;
    });

// --- Analytics & History ---

exports.logSensorData = functions.firestore
    .document("sensor_data/latest")
    .onUpdate(async (change, context) => {
        const newData = change.after.data();
        return admin.firestore().collection("sensor_history").add({
            ...newData,
            timestamp: admin.firestore.FieldValue.serverTimestamp(),
        });
    });

exports.logIrrigationEvent = functions.firestore
    .document("irrigation_control/latest")
    .onUpdate(async (change, context) => {
        const newValue = change.after.data();
        const previousValue = change.before.data();

        if (newValue.valve_on !== previousValue.valve_on) {
            return admin.firestore().collection("irrigation_history").add({
                valve_on: newValue.valve_on,
                timestamp: admin.firestore.FieldValue.serverTimestamp(),
            });
        }
        return null;
    });
