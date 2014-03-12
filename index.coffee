Hapi = require("hapi")
Joi = require("joi")
sha1 = require('js-sha1')

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
    , schema)


    incomingChecksum = req.query.checksum

    salt = "8cd8ef52e8e101574e400365b55e11a6"
    method = "GET"

    second = "action=create"
    second += "&attendeePW=" + req.query.attendeePW if req.query.attendeePW isnt null
    second += "&meetingID=" + req.query.meetingID if req.query.meetingID isnt null
    second += "&moderatorPW=" + req.query.moderatorPW if req.query.moderatorPW isnt null
    second += "&name=" + req.query.name if req.query.name isnt null
    second += "&record=" + req.query.record if req.query.record isnt null
    second += "&voiceBridge=" + req.query.voiceBridge if req.query.voiceBridge isnt null
  
    tmpWelcome = encodeURIComponent(req.query.welcome).replace(/%20/g, '+').replace(/[!'()]/g, escape).replace(/\*/g, "%2A")
    second += "&welcome=" + tmpWelcome if req.query.welcome isnt null
    second += "03b07"

    myChecksum = sha1(second)
    console.log "My API: Encrypting \n" + second + "\ninto "+ myChecksum
    console.log "Comparing myChecksum:\n" + myChecksum + " and the incomingChecksum:\n" + incomingChecksum

    return
