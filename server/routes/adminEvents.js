const express = require('express');
const router = express.Router();
const db = require('../db');

// GET /api/admin/events - Get events by status
router.get('/events', async (req, res) => {
    try {
        const statuses = ['pending', 'scheduled', 'completed', 'cancelled', 'rejected'];
        const results = {};

        for (const status of statuses) {
            const [rows] = await db.query(`
                SELECT events.*, venues.name AS venue_name, services.name AS service_name
                FROM events
                         JOIN venues ON events.venue_id = venues.id
                         JOIN services ON events.service_id = services.id
                WHERE events.status = ?
            `, [status]);

            results[status] = rows;
        }

        res.json(results);
    } catch (err) {
        console.error('Error fetching events:', err);
        res.status(500).json({ message: 'Server error while fetching events.' });
    }
});

// PUT /api/admin/events/:id - Update event status
router.put('/events/:id', async (req, res) => {
    const { id } = req.params;
    const { status } = req.body;

    const validStatuses = ['pending', 'scheduled', 'completed', 'cancelled', 'rejected'];
    if (!validStatuses.includes(status)) {
        return res.status(400).json({ message: 'Invalid status value.' });
    }

    try {
        const [result] = await db.query('UPDATE events SET status = ? WHERE id = ?', [status, id]);

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Event not found.' });
        }

        res.json({ message: `Event status updated to '${status}' successfully.` });
    } catch (err) {
        console.error('Error updating event status:', err);
        res.status(500).json({ message: 'Failed to update event status.' });
    }
});

// GET get user name
router.get('/user/:email', async (req, res) => {
    const { email } = req.params;

    try {
        const [rows] = await db.execute('SELECT name, email, phone FROM users WHERE email = ?', [email]);
        if (rows.length === 0) {
            return res.status(404).json({ message: 'User not found' });
        }
        res.json(rows[0]);
    } catch (err) {
        console.error('Error fetching user:', err);
        res.status(500).json({ message: 'Server error' });
    }
});


module.exports = router;
