// server/db.js
const mysql = require('mysql2');

const pool = mysql.createPool({
    host: 'mysql-taskmanger-d-taskmanager-discord.i.aivencloud.com',
    user: 'avnadmin',
    password: 'AVNS_Yv7-InPPJR6qBVfgU0W',
    database: 'events_management',
    port: 18996,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

const db = pool.promise();
module.exports = db;
