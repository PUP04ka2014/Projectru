const express = require('express');
const app = express();
const port = 3000;
var mysql = require('mysql2');
const sessions = require('express-session');
var parseUrl = require('body-parser');

app.use(sessions({
	secret: "thisismysecrctekey",
	saveUninitialized:true,
	cookie: { maxAge: 1000 * 60 * 60 * 24 }, // 24 hours
	resave: false
}));

var con = mysql.createConnection({
	host: "localhost",
	user: "root",
	password: "root", 
	database: "test"
});

app.set('view engine', 'ejs');
app.use(express.static(__dirname));
let encodeUrl = parseUrl.urlencoded({ extended: false });

app.use('/', (require, response) => {
    response.render('test')
})

app.get('/s',function(request, response){
    response.render('reg')
})

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});