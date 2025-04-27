const express = require('express');
const router = express.Router();
const pool = require('../db'); // assuming you have MySQL pool in db.js

//  - fix 3. eibar na hoile bad
router.get('/venues', async (req, res) => {
    try {
        const [rows] = await pool.query("SELECT id, name, location, capacity, price_per_hour FROM venues");
        res.json(rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Failed to fetch venues' });
    }
});

// Get services with details
router.get('/services', async (req, res) => {
    try {
        const [rows] = await pool.query("SELECT id, name, description, price FROM services");
        res.json(rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Failed to fetch services' });
    }
});


// Post event request
router.post('/request-event', async (req, res) => {
    const { title, description, venue_id, service_id, date, email } = req.body;
    try {
        await pool.query(
            "INSERT INTO events (title, description, venue_id, service_id, date, status, email) VALUES (?, ?, ?, ?, ?, 'pending', ?)",
            [title, description, venue_id, service_id, date ,email]
        );
        res.json({ message: 'Event request submitted successfully' });
    } catch (err) {
        res.status(500).json({ error: 'Failed to submit event request' });
    }
});

// fetch user's event requests
router.get('/my-requests', async (req, res) => {
    const { email } = req.query;
    if (!email) return res.status(400).json({ error: 'Missing email' });

    try {
        const [rows] = await pool.query('SELECT * FROM events WHERE email = ?', [email]);
        res.json(rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Failed to fetch requests' });
    }
});

// check if review exists for an event
router.get('/check-review', async (req, res) => {
    const { eventId } = req.query;
    if (!eventId) return res.status(400).json({ error: 'Missing eventId' });

    try {
        const [rows] = await pool.query('SELECT * FROM reviews WHERE event_id = ?', [eventId]);
        res.json({ hasReview: rows.length > 0 });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Failed to check review' });
    }
});

// get all reviews for an event
router.get('/reviews', async (req, res) => {
    const { event_id } = req.query;
    if (!event_id) return res.status(400).json({ error: 'Missing event_id' });

    try {
        const [rows] = await pool.query('SELECT * FROM reviews');
        res.json(rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Failed to fetch reviews' });
    }
});

// submit a new review
router.post('/give-reviews', async (req, res) => {
    const { name, point, detail, event_id } = req.body;
    if (!name || !point || !detail || !event_id) {
        return res.status(400).json({ error: 'Missing fields' });
    }

    try {
        await pool.query(
            'INSERT INTO reviews (name, point, detail, event_id) VALUES (?, ?, ?, ?)',
            [name, point, detail, event_id]
        );
        res.json({ message: 'Review submitted!' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Failed to submit review' });
    }
});





module.exports = router;
