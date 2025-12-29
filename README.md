# Oct25_Smart-Home-Iot-Security-System
Secure Smart Home IoT Security System with Motion Detection &amp; Real-Time Alerts built on ESP32, oneM2M, Firebase, and Flutter with layered security integration.

# Smart Home IoT Security System with Motion Detection and Alerts

---

**Programme**  
BACHELOR OF INFORMATION TECHNOLOGY (HONS) IN COMPUTER SYSTEM SECURITY & SOFTWARE ENGINEERING  

**Course Code & Name**  
IIB20804 — IOT APPLICATION SECURITY  

**Course Lecturer(s)**  
Prof. Dr. Shahrulniza Bin Musa  


---

- **Student Name(s) & Student ID(s):**  
  - Danish Ieman Bin A Aziz — (52215124369)  
  - Wan Ahmad Akmal Bin Wan Anuar — (52215124525)  
  - Akhmal Iqbal Bin Madzri — (52215124227)  
  - Mior Muhammad Idham Bin Mior Darul Ridzuan — (52215124313)  

---

### Student Receipt of Submission
This is your submission receipt, the only accepted evidence that you have submitted your work. After this is stamped by the appointed staff & filled in, cut along the dotted lines above & retain this for your record.

- **Date & Time of Submission (stamp):**  
- **Course Code:** IIB20804  
- **Submission Title:** Smart Home IoT Security System with Motion Detection and Alerts  
- **Student ID(s) & Signature(s):**  
  - (52215124369)  
  - (52215124525)  
  - (52215124227)  
  - (52215124313)  

---

## 📌 Project Overview

This repository contains the design and implementation of a **Secure Smart Home IoT Security System** engineered to provide real-time, reliable home security by integrating IoT hardware, secure communication protocols, and a layered cloud-based architecture.

### 🔹 Key Features
- Motion detection using **PIR sensor** connected to ESP32 microcontroller  
- Local alerts via **LED & buzzer**  
- Secure transmission of event data to **Firebase Cloud**  
- Real-time notifications through **Flutter mobile app**  
- Event logging with **authorized access only**  
- Compliance with **IoT security standards** (OWASP IoT Top 10, ISO/IEC 27001, NIST CSF)  

### 🔹 Architecture
- **Device Layer:** ESP32 + PIR Sensor  
- **Network Layer:** Wi-Fi Router with TLS/DTLS encryption  
- **Platform Layer:** oneM2M Common Service Entity (CSE)  
- **Cloud Layer:** Firebase (Realtime DB, Firestore, FCM)  
- **Application Layer:** Flutter Mobile App  

### 🔹 Security Integration
- TLS 1.3 / WPA3 for encrypted communication  
- OAuth 2.0 & Role-Based Access Control (RBAC)  
- Secure boot & signed firmware updates  
- Threat modeling using STRIDE framework  
- Risk mitigation aligned with CVE, CWE, CVSS standards  

### 🔹 Tools & Technologies
- **Hardware:** ESP32, PIR Sensor, LED, Buzzer  
- **Software:** Arduino IDE, VS Code, Flutter, Firebase, oneM2M Middleware  
- **Testing:** Wireshark, OpenSSL, simulated attack scenarios  

---

## 📖 Conclusion
This project validates the feasibility of deploying **secure, scalable, and standards-compliant IoT solutions** for smart home environments. It demonstrates successful integration of hardware and software components, secure communication protocols, and layered defense mechanisms. The system serves as a **reference model for future IoT security projects** in residential and small-scale commercial applications.

---
