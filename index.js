const express = require('express')
const app = express()
const port = 3000;
const MOMENT = require('moment');

// parse requests of content-type - application/json
app.use(express.json());

var mysql = require('mysql');
var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '1234',
    database: 'sre_hack'
});

connection.connect();

connection.query('SELECT * FROM email', function (error, results, fields) {
    if (error) throw error;
    console.log('The solution is: ', results[0]);
});

// connection.end();

app.get('/', (req, res) => {
    res.status(200).send({
        message: "Hello World"
    });
})

app.post('/incoming_mails', (req, res) => {
    // console.log(req.body)
    //Insert data into the database
    let datetime = MOMENT().format('YYYY-MM-DD');
    let str = 'INSERT INTO `email`(`from_email`, `opened_date_time`, `email_subject`, `email_content`, `email_type`, `priority`, `closed_time`, `email_status`, `time_difference`)  VALUES ("' + req.body.headers.from + '","' + datetime + '", "' + req.body.headers.subject + '", "' + req.body.plain.replace(/\n/g, '') + '", "1", 1, "22-21-12", "sdcdsc", 2)';
    console.log(str)
    connection.query(str)
    res.status(200).send({
        message: "Success"
    });
})

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})