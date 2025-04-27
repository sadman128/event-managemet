const express = require('express');
const router = express.Router();
const db = require('../db');

// POST /login
router.post('/', async (req, res) => {
    const { email, password, role } = req.body;

    try {
        let table = role === 'admin' ? 'admins' : 'users';

        const [rows] = await db.query(`SELECT * FROM ${table} WHERE email = ? AND password = ?`, [email, password]);

        if (rows.length === 0) {
            return res.status(401).json({ message: "Invalid email or password." });
        }

        // Auth success
        res.status(200).json({ message: "Login successful", role });
    } catch (err) {
        console.error("Login Error:", err);
        res.status(500).json({ message: "Internal server error." });
    }
});

module.exports = router;
