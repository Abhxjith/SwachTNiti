# SwachTniti

A Smart Waste Management Flutter Project

## Overview

SwachTniti is a Flutter-based mobile application developed for the **Smart India Hackathon**. The app provides a **smart waste management solution**, addressing critical inefficiencies in urban waste collection. By leveraging IoT, GPS tracking, and community participation, it ensures effective waste collection while encouraging responsible waste segregation.

## Key Features

1. **Live Truck Tracking**: 
   - Track garbage trucks in real-time within the designated area.
   - Monitors the movement of trucks using **GPS** and angle deflection sensors.

2. **Waste Segregation Rewards and Penalties**:
   - **Drivers award points** to societies that segregate waste responsibly.
   - **Penalties** are imposed on societies for non-segregated waste collection.

3. **IoT-Driven Data Collection**:
   - Sensors measure angle deflection in the **leaf spring suspension** of trucks, tracking load variations.
   - Helps determine the amount of waste collected from specific areas.

4. **Government Resource Allocation**:
   - Data-driven insights help allocate resources effectively to manage waste in high-generation zones.
   - Tracks driver behavior, ensuring they adhere to routes and collect waste efficiently.

## The Problem It Solves

Many garbage truck drivers waste time driving around the city without collecting waste. This leads to inefficiencies and a lack of accountability in waste management. SwachTniti provides a **modern, automated solution** for:

- Tracking driver activity.
- Ensuring timely and accountable waste collection.
- Encouraging better waste management practices through community incentives.
- Offering government officials actionable data on waste generation and collection.

## Technology Stack

- **Frontend**: Flutter (Dart)
- **IoT Integration**: Leaf spring sensors, GPS, GSM modules
- **Backend**: Node.js (API server)
- **Database**: MongoDB
- **Communication Protocol**: MQTT for real-time data transfer from IoT devices


### Installation Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/Abhxjith/SwachTniti.git
   cd swachtniti
   ```

2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```

4. Set up the IoT module and backend server as per the project documentation.

---

SwachTniti is the **future of waste management**, ensuring cleaner cities and accountable governance through technology. Let’s work together to make a sustainable difference!
