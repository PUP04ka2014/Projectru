const express = require('express');
const app = express();
const port = 3000;
var mysql = require('mysql2');
const sessions = require('express-session');

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

app.use('/',function(request,response){
	const sql = "Select * From products"


	con.query(sql, (err,result) => {
		if(err){
			console.log(err)
		}
		else{
			con.query(`Select productPrice From productprices`, (err, res1=result) => {
				response.render('main_page', {					
					sqlres: result,
					prices: res1,
				});
				
			})
		};	
	});
})

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});