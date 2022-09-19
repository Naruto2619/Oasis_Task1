require('dotenv').config();
var express = require('express');
const {MongoClient} = require('mongodb');
const uri = process.env.KEY;
const bodyParser = require("body-parser");
var app = express();
app.use(bodyParser.urlencoded({ extended: false }))

app.use(bodyParser.json())
var jsonParser = bodyParser.json()



app.post('/postform',jsonParser, function(req, res){
    MongoClient.connect(uri, function(err, db) {
        if (err) throw err;
        var dbo = db.db("mydb");
        var myobj = req.body;
        console.log(myobj);
        dbo.collection("oasis").insertMany(myobj, function(err, res) {
            if (err) throw err;
            console.log("all documents inserted");
            db.close();
        });
    });
      
    res.send("Posted successfully on mongoDB");
});


app.listen(3000);