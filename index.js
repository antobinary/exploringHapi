var Hapi = require('hapi');
var server = Hapi.createServer('0.0.0.0', parseInt(process.env.PORT, 10) || 4000);
console.log ("check");
server.start();

//Go to  192.168.0.231:4000/bigbluebutton/api and you will see "BBBBBBB"
server.route({
  method: 'GET'
, path: '/bigbluebutton/api'
, handler: function(req, reply) {
    reply('BBBBBBBBBBB' + err);
  }
});


var Joi = require('joi');


var schema = {
    a: Joi.string()
};


var err = Joi.validate({ a: true }, schema);


server.route({
  method: 'GET'
, path: '/bigbluebutton/api/create'
, handler: function(req, reply) {
    console.log (req.query.attendeePW);
    reply(req.query.attendeePW
+ "\n" + req.query.meetingID
+ "\n" + req.query.moderatorPW);
  }
});
