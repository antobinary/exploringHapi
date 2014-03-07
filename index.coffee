Hapi = require("hapi")
Joi = require("joi")
server = Hapi.createServer("0.0.0.0", parseInt(process.env.PORT, 10) or 4000)
server.start()
console.log "Listening on http://192.168.0.231:4000"

schema =
  attendeePW: Joi.string().max(20).required()
  meetingID: Joi.string().min(3).max(30).required()
  moderatorPW: Joi.string().required()
  name: Joi.string().regex(/[a-zA-Z0-9]{3,30}/)
  record: Joi.boolean()
  voiceBridge: Joi.string()
  welcome: Joi.string()
  checksum: Joi.string()

server.route
  method: "GET"
  path: "/bigbluebutton/api/create"
  handler: (req, reply) ->
    err = Joi.validate(
      attendeePW: req.query.attendeePW
      meetingID: req.query.meetingID
      moderatorPW: req.query.moderatorPW
      name: req.query.name
      record: req.query.record
      voiceBridge: req.query.voiceBridge
      welcome: req.query.welcome
      checksum: req.query.checksum
    , schema)
    if err is null
      reply "everything is fine"
    else
      reply err
    return
