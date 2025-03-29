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

app.use('/',encodeUrl,function(request,response){
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

app.get('/reg_btn', encodeUrl, function(request,response) {
	console.log('1')
    response.render('reg', {				
    })
})

// app.post('/register', encodeUrl, (req, res) => {
//     var firstName = req.body.customerName;
//     var lastName = req.body.customerPhone;
//     var userName = req.body.customerEmail;
//     var password = req.body.customerPassword;

//     con.connect(function(err) {
//         if (err){
//             console.log(err);
//         };
//         // checking user already registered or no
//         con.query(`SELECT * FROM customers WHERE customerName = '${userName}' AND customerPassword  = '${password}'`, function(err, result){
//             if(err){
//                 console.log(err);
//             };
//             if(Object.keys(result).length > 0){
//                 res.sendFile(__dirname + '/failReg.html');
//             }else{
//             //creating user page in userPage function
//             function userPage(){
//                 // We create a session for the dashboard (user page) page and save the user data to this session:
//                 req.session.user = {
//                     firstname: firstName,
//                     lastname: lastName,
//                     username: userName,
//                     password: password 
//                 };

//                 res.send(`
//                 <!DOCTYPE html>
//                 <html lang="en">
//                 <head>
//                     <title>Login and register form with Node.js, Express.js and MySQL</title>
//                     <meta charset="UTF-8">
//                     <meta name="viewport" content="width=device-width, initial-scale=1">
//                     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
//                 </head>
//                 <body>
//                     <div class="container">
//                         <h3>Hi, ${req.session.user.firstname} ${req.session.user.lastname}</h3>
//                         <a href="/">Log out</a>
//                     </div>
//                 </body>
//                 </html>
//                 `);
//             }
//                 // inserting new user data
//                 var sql = `INSERT INTO customers (customerName, customerPhone, customerEmail, customerPassword) VALUES ('${firstName}', '${lastName}', '${userName}', '${password}')`;
//                 con.query(sql, function (err, result) {
//                     if (err){
//                         console.log(err);
//                     }else{
//                         // using userPage function for creating user page
//                         userPage();
//                     };
//                 });

//         }

//         });
//     });


// });

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});