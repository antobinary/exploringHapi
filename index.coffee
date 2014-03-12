Hapi = require("hapi")
Joi = require("joi")
sha1 = require('js-sha1')

server = Hapi.createServer("0.0.0.0", parseInt(process.env.PORT, 10) or 4000)
server.start()

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

    third = "attendeePW=" + req.query.attendeePW if req.query.attendeePW isnt null
    third += "&meetingID=" + req.query.meetingID if req.query.meetingID isnt null
    third += "&moderatorPW=" + req.query.moderatorPW if req.query.moderatorPW isnt null
    third += "&name=" + req.query.name if req.query.name isnt null
    third += "&record=" + req.query.record if req.query.record isnt null
    third += "&voiceBridge=" + req.query.voiceBridge if req.query.voiceBridge isnt null  
    tmpWelcome = encodeURIComponent(req.query.welcome).replace(/%20/g, '+').replace(/[!'()]/g, escape).replace(/\*/g, "%2A")
    third += "&welcome=" + tmpWelcome if req.query.welcome isnt null

    incomingChecksum = req.query.checksum
    method = "create"
    query = third
    salt = "8cd8ef52e8e101574e400365b55e11a6"

    str = method + query + salt;

    urlChecksum = sha1(str)
    console.log "the checksum from url is \n" + incomingChecksum + " and mine is\n" + urlChecksum

    unless incomingChecksum isnt urlChecksum
      console.log "YAY! They match!"
    
    #back to validation
    if err is null
      reply "everything is fine"
    else
      reply err
