// server/db.js
const mysql = require('mysql2');

const pool = mysql.createPool({
    host: 'mysql-taskmanger-d-taskmanager-discord.i.aivencloud.com',
    user: '',
    password: '',
    database: '',
    port: ,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

const db = pool.promise();
module.exports = db;
