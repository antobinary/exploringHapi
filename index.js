var Hapi = require('hapi');
var Joi = require('joi');

var server = Hapi.createServer('0.0.0.0', parseInt(process.env.PORT, 10) || 4000);
server.start();

var schema = {
	attendeePW: Joi.string().max(20).required(),
	meetingID: Joi.string().min(3).max(30).required(),
	moderatorPW: Joi.string().required(),
	name: Joi.string().regex(/[a-zA-Z0-9]{3,30}/),
	record: Joi.boolean(),
	voiceBridge: Joi.string(),
	welcome: Joi.string(),
	checksum: Joi.string()
};

server.route({
  method: 'GET'
, path: '/bigbluebutton/api/create'
, handler: function(req, reply) {
     var err = Joi.validate({attendeePW: req.query.attendeePW,
			meetingID: req.query.meetingID,
			moderatorPW: req.query.moderatorPW,
			name: req.query.name, 
			record: req.query.record,
			voiceBridge: req.query.voiceBridge,
			welcome: req.query.welcome,
			checksum: req.query.checksum, 
	}, schema);
	
	if(err == null)
	   reply("everything is fine");
	else
	   reply(err);
  }
});
