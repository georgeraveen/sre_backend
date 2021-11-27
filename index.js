const express = require('express')
const app = express()
const port = 3000;
const MOMENT = require('moment');
const axios = require('axios')

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
    let str = 'INSERT INTO `email`(`from_email`, `opened_date_time`, `email_subject`, `email_content`, `email_type`, `priority`, `closed_time`, `email_status`, `time_difference`, `ticketID`)  VALUES ("' + req.body.headers.from + '","' + datetime + '", "' + req.body.headers.subject + '", "' + req.body.plain.replace(/\n/g, '') + '", "1", 1, "22-21-12", "sdcdsc", 2, 2)';
    console.log(str)
    connection.query(str)


    let data = JSON.stringify({
        "fields": {
            "summary": req.body.headers.subject,
            "description": {
                "type": "doc",
                "version": 1,
                "content": [
                    {
                        "type": "paragraph",
                        "content": [
                            {
                                "text": req.body.plain.replace(/\n/g, ''),
                                "type": "text"
                            }
                        ]
                    }
                ]
            },
            "issuetype": {
                "id": "10008"
            },
            "project": {
                "id": "10002"
            },
            "labels": [
                "HIGH"
            ]
        }
    });

    var config = {
        method: 'post',
        url: 'https://mprints.atlassian.net/rest/api/3/issue',
        headers: {
            'Authorization': 'Basic MjAxOGlzMDM5QHN0dS51Y3NjLmNtYi5hYy5sazo1bHN3SlpGZThkbWxRUjZSZTRXbjlDRjY=',
            'Content-Type': 'application/json',
            'Cookie': 'atlassian.xsrf.token=0be0748b-d2bb-43e8-b2f6-d09119b8a854_f1215d4d911a77448fe7e43d525b5c71036efae5_lin'
        },
        data: data
    };

    axios(config)
        .then(function (response) {
            console.log(JSON.stringify(response.data));
        })
        .catch(function (error) {
            console.log(error);
        });



    res.status(200).send({
        message: "Success"
    });
})

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})