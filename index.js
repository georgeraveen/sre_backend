const express = require('express')
const app = express()
const port = 3000

var mysql = require('mysql');
var connection = mysql.createConnection({
    host: '35.184.135.254',
    user: 'root',
    password: 'Proktara@123',
    database: 'sre_mail'
});

connection.connect();

connection.query('SELECT 1 + 1 AS solution', function (error, results, fields) {
    if (error) throw error;
    console.log('The solution is: ', results[0].solution);
});

// connection.end();




app.get('/', (req, res) => {
    res.send('Hello World!')
})

app.post('/incoming_mails', (req, res) => {

    res.send('incoming_mails')
})

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})