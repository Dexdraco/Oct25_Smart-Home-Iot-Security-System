const admin = require('firebase-admin');
const express = require('express');
const app = express();
app.use(express.json());

// 1. Initialize Firebase
const serviceAccount = require("./serviceAccountKey.json");
admin.initializeApp({ credential: admin.credential.cert(serviceAccount) });
const db = admin.firestore();

// 2. Notification Endpoint
app.post('/notification', async (req, res) => {
    try {
        console.log("Notification received from Mobius...");
        
        // 1. Flexible parsing of the oneM2M notification structure
        const sgn = req.body['m2m:sgn'] || req.body;
        const nev = sgn['m2m:nev'] || sgn.nev;
        const rep = nev['m2m:rep'] || nev.rep;
        const cin = rep['m2m:cin'] || rep.cin || rep;

        // 2. Extract the content
        const rawContent = cin.con;
        const data = typeof rawContent === 'string' ? JSON.parse(rawContent) : rawContent;

        console.log("Decoded Motion Data:", data);

        // 3. Save to Firebase
        await db.collection('motion_alerts').add({
            device: data.device || "Unknown Device",
            location: data.location || "Unknown Location",
            motion: data.motion || false,
            timestamp: admin.firestore.FieldValue.serverTimestamp(),
            security_layer: "oneM2M_Verified"
        });

        console.log("Success: Synced to Firebase!");
        res.status(200).send("Notification Received");
    } catch (error) {
        console.error("Bridge Error details:", error.message);
        res.status(200).send("Acknowledge anyway"); // Prevent Mobius from retrying constantly
    }
});

app.listen(3000, () => console.log('IPE Bridge running on port 3000'));
