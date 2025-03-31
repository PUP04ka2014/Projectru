const express = require('express');
const app = express();
app.use(express.urlencoded({extended: true}));

app.set('view engine', 'ejs');
app.use(express.static(__dirname));

app.use('', (req, res) => {
    res.render('test')
})

app.get('/s',function(req, res){
	console.log('1')
})

app.listen(3000, () => {
    console.log(`Server is running at http://localhost:${3000}`);
});