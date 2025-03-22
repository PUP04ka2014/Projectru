const express = require('express');
const cookieParser = require("cookie-parser");
const sessions = require('express-session');
const http = require('http');
var parseUrl = require('body-parser');
const app = express();

var mysql = require('mysql2');
const { encode } = require('punycode');
const { dirname } = require('path');

let encodeUrl = parseUrl.urlencoded({ extended: false });

app.set('view engine', 'ejs');
app.use(express.static(`${__dirname}`));

app.use(sessions({
    secret: "thisismysecrctekey",
    saveUninitialized:true,
    cookie: { maxAge: 1000 * 60 * 60 * 24 }, // 24 hours
    resave: false
}));

app.use(cookieParser());

var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "root", 
    database: "test"
});






app.post('/register', encodeUrl, (req, res) => {
    var firstName = req.body.customerName;
    var lastName = req.body.customerPhone;
    var userName = req.body.customerEmail;
    var password = req.body.customerPassword;

    con.connect(function(err) {
        if (err){
            console.log(err);
        };
        // checking user already registered or no
        con.query(`SELECT * FROM customers WHERE customerName = '${userName}' AND customerPassword  = '${password}'`, function(err, result){
            if(err){
                console.log(err);
            };
            if(Object.keys(result).length > 0){
                res.sendFile(__dirname + '/failReg.html');
            }else{
            //creating user page in userPage function
            function userPage(){
                // We create a session for the dashboard (user page) page and save the user data to this session:
                req.session.user = {
                    firstname: firstName,
                    lastname: lastName,
                    username: userName,
                    password: password 
                };

                res.send(`
                <!DOCTYPE html>
                <html lang="en">
                <head>
                    <title>Login and register form with Node.js, Express.js and MySQL</title>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
                </head>
                <body>
                    <div class="container">
                        <h3>Hi, ${req.session.user.firstname} ${req.session.user.lastname}</h3>
                        <a href="/">Log out</a>
                    </div>
                </body>
                </html>
                `);
            }
                // inserting new user data
                var sql = `INSERT INTO customers (customerName, customerPhone, customerEmail, customerPassword) VALUES ('${firstName}', '${lastName}', '${userName}', '${password}')`;
                con.query(sql, function (err, result) {
                    if (err){
                        console.log(err);
                    }else{
                        // using userPage function for creating user page
                        userPage();
                    };
                });

        }

        });
    });


});

app.get("/login", (req, res)=>{
    res.sendFile(__dirname + "/login.html");
});

app.post("/dashboard", encodeUrl, (req, res)=>{
    var userName = req.body.customerName;
    var password = req.body.customerPassword;

    con.connect(function(err) {
        if(err){
            console.log(err);
        };
        con.query(`SELECT * FROM customers WHERE customerName = '${userName}' AND customerPassword = '${password}'`, function (err, result) {
          if(err){
            console.log(err);
          };

          function userPage(){
            // We create a session for the dashboard (user page) page and save the user data to this session:
            req.session.user = {
                firstname: result[0].customerName,
                lastname: result[0].customerEmail,
                username: userName,
                password: password 
            };

            res.send(`
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <title>Login and register form with Node.js, Express.js and MySQL</title>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
            </head>
            <body>
                <div class="container">
                    <h3>Hi, ${req.session.user.firstname} ${req.session.user.lastname}</h3>
                    <a href="/">Log out</a>
                </div>
            </body>
            </html>
            `);
        }

        if(Object.keys(result).length > 0){
            userPage();
        }else{
            res.sendFile(__dirname + '/failLog.html');
        }

        });
    });
});

app.listen(4000, ()=>{
    console.log("Server running on port 4000");
});