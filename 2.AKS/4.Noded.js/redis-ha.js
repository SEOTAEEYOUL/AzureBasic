// redis-ha.js
'use strict';
// const redis   = require('redis');
var   redis      = require('ioredis');
const dateFormat = require('dateformat');
const fs         = require('fs');
const JSON       = require('JSON');

console.log('[' + process.env.REDIS_CONF + ']');
var redisConf = fs.readFileSync(process.env.REDIS_CONF);
var redisJson = JSON.parse(redisConf);
console.log(redisJson.clusterInfo.name + '[' + redisJson.clusterInfo.description + ']');
console.log(
  '---\n' +
  'redisClient.enableOfflineQueue[' + redisJson.clientInfo.enableOfflineQueue + ']\n' +
  'redisClient.maxRetriesPerRequest[' + redisJson.clientInfo.maxRetriesPerRequest + ']\n' +
  '---\n');
console.log(
  '---\n' +
  'redisJson.serverInfo.db[' + redisJson.serverInfo.db + ']\n' +
  'redisJson.serverInfo.svcInfo.length[' + redisJson.serverInfo.svcInfo.length + ']');

function connectToRedis(i, namespace, svc, port) {
  console.log('*svc[' + svc + ']');
  console.log('*port[' + port + ']');
  console.log('*auth[' + redisJson.serverInfo.svcInfo[i].auth + ']');
  console.log('*db[' + redisJson.serverInfo.db + ']');
  var host = svc + '.' + namespace + '.svc.cluster.local';
  console.log('*host[' + host + ']');
  var auth;
  if (redisJson.serverInfo.svcInfo[i].auth == '*') {
    auth = '';
  }
  else {
    auth = redisJson.serverInfo.svcInfo[i].auth;
  }
  var redisConn = new redis({
    // host: svc + '.' + namespace + '.svc.cluster.local',   // Redis Host
    host: svc,                                            // Redis Host
    port: port,                                           // Redis port
    family: 4,                                            // 4 (IPv4) or 6 (IPv6)
    password: auth,
    db: redisJson.serverInfo.db,
    showFriendlyErrorStack: true,
    maxRetriesPerRequest: redisJson.clientInfo.maxRetriesPerRequest,
    retryStrategy: function(times) {
      // var delay = Math.min(times * 50, 10000);
      var delay = Math.min(100 + times * 2, 2000);
      return (delay);
    },
    enableOfflineQueue: redisJson.clientInfo.enableOfflineQueue
  });
  /*
  redisConn.monitor(function(err, monitor) {
    monitor.on('monitor', function(time, args, source, database) {
      // console.log(time + ":" + util.inspect(args));
      console.log(time + ":" + args.toString( ));
    });
  });
  */
  return (redisConn);
}
function redisUnitTest(bot, message, i, gubun, isEnd) {
  console.log('redisUnitTest::i[' + i + '] gubun[' + gubun + '], isEnd[' + isEnd + ']');
  var returnValue = '';
  var day         = dateFormat(new Date( ), "yyyy.mm.dd HH:MM:ss TT Z");
  var namespace   = redisJson.serverInfo.svcInfo[i].namespace;
  var svc;
  var port;
  
  if (gubun == 'master') {
    svc  = redisJson.serverInfo.svcInfo[i].server.master.svc;
    port = redisJson.serverInfo.svcInfo[i].server.master.port;
  }
  else if (gubun == 'slave') {
    svc  = redisJson.serverInfo.svcInfo[i].server.slave.svc;
    port = redisJson.serverInfo.svcInfo[i].server.slave.port;
  }
  var _redis = connectToRedis(i, namespace, svc, port);
  var p1 = new Promise(function(resolve, reject) {
    if (gubun == 'master') {
       console.log('gubun[' + gubun + '] --> _client.hmset');
       returnValue += '*Master* Connection : _write/read_ Test[' + day + ']\n';
       _redis.hmset(redisJson.serverInfo.svcInfo[i].namespace,
                    'redis', redisJson.serverInfo.svcInfo[i].server.name,
                    'svc', redisJson.serverInfo.svcInfo[i].server.master.svc,
                    'port', redisJson.serverInfo.svcInfo[i].server.master.port,
                    'time', day);
       // _redis.set(redisJson.serverInfo.svcInfo[i].namespace, day);
    }
    if (gubun == 'slave') {
       returnValue += '*Slave* Connection : _read_ _only_ Test[' + day + ']\n';
    } 
    console.log('gubun[' + gubun + '] == hgetall');
    _redis.hgetall(redisJson.serverInfo.svcInfo[i].namespace, (err, obj) => {
      // console.log('1. Result [' + returnValue + ']');
      var str = JSON.stringify(obj);
      console.log(str);
      returnValue += str;
      // console.log('2. Result [' + returnValue + ']');
      // returnValue += '---\n';
      // console.log('3. Result [' + returnValue + ']');
      if (isEnd == true) {
        returnValue += '\n---\n';
      }
      setTimeout(
        function( ) {
          resolve (returnValue);
        }, Math.random( ) * 2000 + 1000);
    });
  });
  p1.then(function(val) {
    // console.log(message, redisJson.serverInfo.svcInfo[i].namespace + ': ' + returnValue); 
    bot.reply(message, '`' + redisJson.serverInfo.svcInfo[i].namespace + '`: ' + returnValue);
    _redis.quit( );
    return (returnValue);
  })
  .catch(function(reason) {
    console.log('ejected promise(' + reason + ')');
    _redis.quit( );
  });
}
// Here's the built-in argument transformer convertiong
// hmset('key', {k1:, 'v1', k2:, 'v2})
// or
// hmset('key', new Map([['k1', 'v1'], ['k2', 'v2']]))
// into
// hmset('key', 'k1', 'v1', 'k2', 'v2')
redis.Command.setArgumentTransformer("hmset", function(args) {
  if (args.length === 2) {
    if (typeof Map !== "undefined" && args[1] instanceof Map) {
      // utils is a internal module of ioredis
      return [args[0]].concat(utils.convertMapToArray(args[1]));
    }
    if (typeof args[1] === "object" && args[1] !== null) {
      return ([args[0]].concat(utils.convertObjectToArray(args[1])));
    }
  }
  return (args);
});
// Here's the built-in reply transformer converting the HGETALL reply
// ['k1', 'v1', 'k2', 'v2']
// into
// { k1: 'v1', 'k2': 'v2' }
redis.Command.setReplyTransformer("hgetall", function(result) {
  if (Array.isArray(result)) {
    var obj = {};
    for (var i = 0; i < result.length; i += 2) {
      obj[result[i]] = result[i + 1];
    }
    return (obj);
  }
  return (result);
});
function getRedisAuth(namespace) {
  for (var i = 0; i < redisJson.serverInfo.svcInfo.length; i++) {
    if (redisJson.serverInfo.svcInfo[i].namespace == namespace) {
      return (redisJson.serverInfo.svcInfo[i].auth);
    }
  }
}
// gubun : 'master', 'slave', '$namespace'
function redisTest(bot, message, gubun) {
  if (gubun == 'master') {
    for (var i = 0; i < redisJson.serverInfo.svcInfo.length; i++) {
      if ((i+1) == redisJson.serverInfo.svcInfo.length) {
        redisUnitTest(bot, message, i, gubun, true);
      }
      else {
        redisUnitTest(bot, message, i, gubun, false);
      }
    }
  }
  else if (gubun == 'slave') {
    for (var i = 0; i < redisJson.serverInfo.svcInfo.length; i++) {
      if ((i+1) == redisJson.serverInfo.svcInfo.length) {
        redisUnitTest(bot, message, i, gubun, true);
      }
      else {
        redisUnitTest(bot, message, i, gubun, false);
      }
    }
    bot.reply(message, '---\n');
  }
  else {
    for (var i = 0; i < redisJson.serverInfo.svcInfo.length; i++) {
      if (redisJson.serverInfo.svcInfo[i].namespace == gubun) {
        redisUnitTest(bot, message, i, 'master', false);
        redisUnitTest(bot, message, i, 'slave', true);
        return ;
      }
    }
    bot.reply(message, 'unknow redis server type or namespace[' + gubun + ']: \'master\' or \'sentinel\'');
    bot.reply(message, '---\n');
  }
}
module.exports.test         = redisTest;
module.exports.getRedisAuth = getRedisAuth;
// redisTest( );
