const express = require('express');
const app = express();
const port = 3000;
const mysql = require('mysql2');
const sessions = require('express-session');

app.use(sessions({
    secret: "thisismysecretkey",
    saveUninitialized: true,
    cookie: { maxAge: 1000 * 60 * 60 * 24 },
    resave: false
}));

const con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "root",
    database: "test"
});

con.connect(function(err) {
    if (err) {
        console.error('Error connecting to the database:', err);
        return;
    }
    console.log('Connected to the database.');
});

app.set('view engine', 'ejs');
app.use(express.static(__dirname));
app.use(express.urlencoded({ extended: false }));

// Основная страница
app.use('/', function (request, response) {
    const sql = `SELECT p.productID, p.productName, p.productDescription, p.productThumbnail, pp.productPrice AS lastPrice, pp.priceDate AS lastPriceDate
                 FROM products p
                 JOIN (SELECT productID, MAX(priceDate) AS latestDate FROM ProductPrices GROUP BY productID) latest 
                 ON p.productID = latest.productID
                 JOIN productprices pp 
                 ON pp.productID = latest.productID AND pp.priceDate = latest.latestDate
                 ORDER BY p.productID;`;

    con.query(sql, (err, result) => {
        if (err) {
            console.log(err);
            response.status(500).send('Database error');
        } else {
            response.render('main_page', { sqlres: result });
        }
    });
});

// Страница регистрации
app.get('/reg_btn', function (request, response) {
    response.render('reg', {});
});

app.post('/register', (req, res) => {
    const firstName = req.body.customerName;
    const lastName = req.body.customerPhone;
    const userName = req.body.customerEmail;
    const password = req.body.customerPassword;

    con.query(`SELECT * FROM customers WHERE customerEmail = ?`, [userName], (err, result) => {
        if (err) {
            console.log(err);
            return res.status(500).send('Database error');
        }

        if (result.length > 0) {
            res.render('failReg', { message: 'User already exists' });
        } else {
            const sql = `INSERT INTO customers (customerName, customerPhone, customerEmail, customerPassword) VALUES (?, ?, ?, ?)`;
            con.query(sql, [firstName, lastName, userName, password], (err, result) => {
                if (err) {
                    console.log(err);
                    return res.status(500).send('Database error');
                }
                req.session.user = { firstname: firstName, lastname: lastName, username: userName };
                res.send(`User registered successfully. Welcome, ${firstName}!`);
            });
        }
    });
});

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});