const express = require('express');
const db = require('./db');
const bodyParser = require('body-parser');

const app = express();

app.use(bodyParser.json());



app.get('/', (req, res) => {
  res.redirect('/api/vendors')
})

app.get('/api/vendors', (req, res) =>{
  db.query('SELECT * FROM machine', (err, dbresponse)=>{
    if (err){
      return next(err)
    }
    res.json({vendors:dbresponse.rows})
  })
})

app.get('/api/vendors/:machine_id', (req,res)=>{
  db.query('SELECT * FROM machine where machine_id =$1', [req.params.machine_id],(err,dbresponse)=>{
    if(err){
      return next(err)
    }
    res.json({thisMachine: dbresponse.rows })
  })
})

app.get('/api/vendors/:machine_id/transactions',(req,res) =>{
  console.log(req.params.machine_id);
  db.query('SELECT * FROM purchase WHERE machine_id =$1', [req.params.machine_id], (err,dbresponse)=>{
    if(err){
      return next(err)
    }
    res.json({transactionHistory:dbresponse.rows})
  })
})

app.post('/api/vendors/:machine_id/purchase', (req,res)=>{
    var date = new Date();
    var payment = req.body.amount_taken
    var machine_id = req.params.machine_id
    var item_id = req.body.item_id

  db.query('SELECT cost FROM item WHERE item_id =$1',[req.body.item_id], (err, dbresponse)=>{
    console.log("error is:", err);
    var price = dbresponse.rows[0].cost;
    var change = payment - price;
    if(payment < price){
      res.json({status:'Failed', money_given:payment, cost:price})
    }else{
      db.query('INSERT INTO purchase(purchase_time, amount_taken,change_given, machine_id, item_id) VALUES($1, $2, $3, $4, $5)',[date, payment, change, machine_id, item_id ], (err, dbresponse)=>{
        console.log(err);
        res.json({status:'thank you, enjoy'})
      })
    }
  })
})

app.listen(3000, ()=>{
  console.log('listening');
})
