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
	const sql = `SELECT 
    p.productID,
    p.productName,
    p.productDescription,
    p.productThumbnail,
    pp.productPrice AS lastPrice,
    pp.priceDate AS lastPriceDate
FROM 
    products p
JOIN 
    (SELECT 
         productID, 
         MAX(priceDate) AS latestDate
     FROM 
         ProductPrices
     GROUP BY 
         productID) latest 
    ON p.productID = latest.productID
JOIN 
    productprices pp 
    ON pp.productID = latest.productID AND pp.priceDate = latest.latestDate
ORDER BY 
    p.productID;`


	con.query(sql, (err,result) => {
		if(err){
			console.log(err)
		}
		else{
			response.render('main_page', {					
				sqlres: result,
			});
		};	
	});
})

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});