const express = require('express');
const cors = require('cors');
const path = require('path');
const signupRoute = require('./routes/signup');
const loginRoute = require('./routes/login');

const app = express();

// ===== Middleware =====
app.use(cors());
app.use(express.urlencoded({ extended: true })); // Parse form submissions
app.use(express.json()); // Parse JSON bodies

// ===== Static Files =====
app.use(express.static(path.join(__dirname, '../public')));

// ===== Routes =====
app.use('/api/signup', signupRoute);
app.use('/login', loginRoute);


const requestEventRoutes = require('./routes/requestEvent'); // Adjust path if needed
app.use(express.json());
app.use('/api', requestEventRoutes);

const adminEventsRoutes = require('./routes/adminEvents');
app.use(express.json());
app.use('/api/admin', adminEventsRoutes);

// ===== Server Start =====
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});
aaaaaaa