var Hapi = require('hapi');
var server = Hapi.createServer('0.0.0.0', parseInt(process.env.PORT, 10) || 4000);



//Go to  192.168.0.231:4000/ and you will see "i am a beautiful butterfly"
server.route({
  method: 'GET'
, path: '/'
, handler: function(req, reply) {
    reply('i am a beautiful butterfly');
  }
});

server.start();

//Go to  192.168.0.231:4000/aa and you will see "AAAAAAAAAAAAA"
server.route({
  method: 'GET'
, path: '/aa'
, handler: function(req, reply) {
    reply('AAAAAAAAAAA');
  }
});


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

