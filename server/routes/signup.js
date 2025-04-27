const express = require('express');
const router = express.Router();
const db = require('../db');

// POST /api/signup
router.post('/', async (req, res) => {
    const { name, email, password, phone, address } = req.body;

    try {
        const [existing] = await db.query("SELECT * FROM users WHERE email = ?", [email]);
        if (existing.length > 0) {
            return res.status(400).json({ message: "Email already registered." });
        }

        // fixed
        await db.query(
            "INSERT INTO users (name, email, password, phone, address) VALUES (?, ?, ?, ?, ?)",
            [name, email, password, phone, address]
        );

        res.status(201).json({ message: "Signup successful. Please login." });
    } catch (err) {
        console.error("Signup Error:", err);
        res.status(500).json({ message: "Internal server error." });
    }
});

module.exports = router;
