import mysql from 'mysql2/promise';
import express from 'express';
import bodyParser from 'body-parser';
import cors from 'cors';

// Create an Express application
const app = express();

// Middleware
app.use(bodyParser.json());
app.use(cors());
app.use(express.static('public'));
app.use(express.urlencoded({ extended: true }));
app.set('view engine', 'ejs');
app.set('views', './views');

// Database connection
const dbConfig = {
    host: 'localhost'}
const pool = mysql.createPool(dbConfig);

const db = await mysql.createConnection({
    host: 'localhost',
    port: 3306, // Default MySQL port
    user: 'yourusername',
    password: 'yourpassword',
    database: 'dating_app'
});

