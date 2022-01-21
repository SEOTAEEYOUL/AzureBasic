'use strict';

module.exports   = require('./nodejs-exporter')
const redisHA    = require('./redis-ha');

const os         = require('os');
const botkit     = require('botkit');      // 봇 모듈 사용
const Slack      = require('slack-node');  // 슬랙 모듈 사용
const dateFormat = require('dateformat');
const execSync   = require('child_process').execSync;
// const regexp     = require('regexp');
// require('dotenv').config( );
// var sync         = require('synchronize');
// var fiber        = sync.fiber;
// var await        = sync.await;
// var defer        = sync.defer;
const controller = botkit.slackbot({
  debug: false,
  // debug: process.env.DEBUG || false,
  log: false
  // log: true
  // log: process.env.DEBUG || false
});

// var controller = new Botkit.slackbot({clientSigningSecret: <my secret from slack>});
const botScope = [
  'direct_message',
  'direct_mention',
  'mention'
];
/**
 * RTM connection manager.
 */
function rtmManager(controller, config) {
  var bot = controller.spawn(config);
  bot.startRTM(function(err, bot) {
    if (err) {
      debug('Failed to start RTM');
    }
    console.log("RTM started!");
  });
  controller.on('rtm_open', function(bot) {
    debug('RTM connection is opened');
    console.log('** The RTM api just connected!');
  });
  controller.on('rtm_close', function(bot) {
    debug('RTM connection is closed');
    console.log('** The RTM api just closed!');
  });
  return (bot);
}

function help(bot, message) {
  var _h = 
           '---' + '\n' +
           process.env.SYS_NAME + '\n' +
           '---' + '\n' + '```' +
           'help        : 도움말' + '\n' +
           'info        : kubernetes 정보 보기' + '\n' +
           'delete pod  : Running 상태가 아니 pods 강제 종료' + '\n' +
           'top pod     : top pod(70) 의 정보' +  '\n' +
           'top node    : top node 정보' +  '\n' +
           'node        : node 정보' +  '\n' +
           'redis info  : redis master 의 정보' +  '\n' +
           // 'redis reset : redis sentinel 의 master 정보 reset' +  '\n' +
           'hi          : 인사말```' +  '\n' +
           '---' + '\n';
  bot.reply(message, _h);
}

// controller.startTicking( );
controller.hears(['^h$', '^help$', '^Help$'], botScope, (bot, message) => {
  help(bot, message);
});

function clusterInfo(bot, message) {
  var kube_version  = execSync("kubectl version");
  var api_versions  = execSync("kubectl api-versions");
  var cluster_info  = execSync("kubectl cluster-info | col -b");
  var kube_config   = execSync("kubectl config view | col -b");
  var osInf         =
      '*bot* *pod* *정보*' + '\n' +
      '시스템의 hostname : *' + os.hostname( ) + '*\n' +
      '시스템의 메모리   : ' + os.freemem( )/1024/1024 + '/' + os.totalmem( )/1024/1024 + '\n' +
      '시스템의 CPU 정보 : ' + JSON.stringify(os.cpus( )) + '\n' +
      '시스템의 NIC 정보 : ' + JSON.stringify(os.networkInterfaces( )) + '\n';
  bot.reply(message,
   process.env.SYS_NAME + '(http://' + process.env.SYS_URL + '/)\n' +
   '---\n' + osInf                          +
   '---\n' + '*Kubernetes* *정보*\n'       +
   '```' + kube_version + '```'             +
   '---\n' + '*api versions* *정보*\n'      +
   '```'   + api_versions + '```'           +
   '---\n' + '*Cluster Info* *정보*\n'      +
   '```'   + cluster_info + '```'           +
   '---\n' + '*Kubenetes Config* *정보*\n'  +
   '```'   + kube_config  + '```'           +
   '---\n');
}

controller.hears(['^Info$', '^info$', '^Icp$', '^icp$'], botScope, (bot, message) => {
  clusterInfo(bot, message);
});

function node(bot, message) {
  var stdout   = execSync("kubectl get node -o wide");
  var _msg = process.env.SYS_NAME + ' : *Node* *정보*\n' +
             '```' + stdout.toString( ) + '```\n' +
             '---'; 
  bot.reply(message, _msg);
}

controller.hears(['^node$', '^Node$', '^NODE$'], botScope, (bot, message) => {
  node(bot, message);
});

function topPod(bot, message) {
  // var day  = dateFormat(new Date( ), "yyyy.mm.dd h:MM:ss TT");
  // var stdout   = execSync("kubectl top pod --all-namespaces | head -1;kubectl top pod --all-namespaces | grep -v NAME | egrep -v \"kube-system|istio-system\" | sort -k 3 -r -h | head -70");
  var _pod = execSync("get_top_pod.sh");
  // var _msg = '[' + process.env.SYS_NAME + ' : *Top* *Pod* *정보*(' + day  + ')]\n' +
  var _msg = process.env.SYS_NAME + ' : *Top* *Pod* *정보*\n' +
             _pod.toString( ) + '\n' +
             '---'; 
  bot.reply(message, _msg);
}
controller.hears(['^top pod$', '^Top pod$', '^top$', '^Top$', '^TOP$'], botScope, (bot, message) => {
  topPod(bot, message);
});
function topNode(bot, message) {
  console.log('top node\n');
  // var day  = dateFormat(new Date( ), "yyyy.mm.dd h:MM:ss TT");
  var node = execSync("kubectl top node");
  // var _msg = '[' + process.env.SYS_NAME + ' : *Top* *Node* *정보*(' + day  + ')]\n' +
  var _msg = process.env.SYS_NAME + ' : *Top* *Node* *정보*\n' +
             '```' + node.toString( ) + '```\n' +
             '---'; 
  // console.log('top node [' + node.toString( ) + ']\n');
  bot.reply(message, _msg);
}
controller.hears(['^top node$', '^Top node$'], botScope, (bot, message) => {
  topNode(bot, message);
});

function redisInfo(bot, message) {
  // var day   = dateFormat(new Date( ), "yyyy.mm.dd");
  // shspawn("kubectl get pod -o wide --all-namespaces -lredis-role=master | awk '{ print $1\"|\"$2\"|\"$8 }'");
  // var stdout   = execSync("kubectl get pod -o wide --all-namespaces -lredis-role=master | grep -v NAME | awk '{ print $1\"|\"$2\"|\"$8 }'");
  // var stdout   = execSync("kubectl get pod -o wide -lredis-role=master --all-namespaces -o custom-columns=\"namespace:metadata.namespace,name:metadata.name,IP:spec.nodeName\"");
  var stdout   = execSync("get-redis-master.sh");

  // var _msg = '[' + process.env.SYS_NAME + ' : `Redis` *Master* 정보(' + day  + ')]\n' +
  var _msg = process.env.SYS_NAME + ' : `Redis` *Master* 정보\n' +
             '```' + stdout.toString( ) + '```\n' +
             '---'; 
  bot.reply(message, _msg);
}
controller.hears(['^redis info$', '^Redis info$', '레디스', '^Redis info$'], botScope, (bot, message) => {
  // redisInfo(bot, message);
  redisMaster(bot, message);
});

function redisMaster(bot, message) {
  var _msg = process.env.SYS_NAME + ' : `Redis` *Master* _Test_\n';
  bot.reply(message, _msg);
  redisHA.test(bot, message, 'master');
}

function redisSlave(bot, message) {
  var _msg = process.env.SYS_NAME + ' : `Redis` *Slave* _Test_\n';
  bot.reply(message, _msg);
  redisHA.test(bot, message, 'slave');
}

function redisResetMasterInfo(bot, message, namespace, title) {
  // var day        = dateFormat(new Date( ), "yyyy.mm.dd");
  var _redisAuth = redisHA.getRedisAuth(namespace);
  var _info      = '';
  if (_redisAuth == '') {
    _info      = execSync('get-redis-info.sh -n ' + namespace  + ' -r');
  }
  else {
    _info      = execSync('get-redis-info.sh -n ' + namespace + ' -a ' + _redisAuth + ' -r');
  }
  var _msg       = 
         // '[' + process.env.SYS_NAME + ' : `Redis` *' + title +'* RESET REDIS MASTER INFO(' + day  + ')]\n' +
         process.env.SYS_NAME + ' : `Redis` *' + title +'* RESET REDIS MASTER INFO\n' +
         _info;
  bot.reply(message, _msg);
}

function redisInfo(bot, message, namespace, title) {
  var day        = dateFormat(new Date( ), "yyyy.mm.dd");
  var _redisAuth = redisHA.getRedisAuth(namespace);
  // console.log('get-redis-info.sh -n ' + namespace + ' -a ' + _redisAuth);
  var _info      = '';
  if (_redisAuth == '') {
    _info = execSync('get-redis-info.sh -n ' + namespace);
  }
  else {
    _info = execSync('get-redis-info.sh -n ' + namespace + ' -a ' + _redisAuth);
  }
  var _msg  = 
         '[' + process.env.SYS_NAME + ' : `Redis` *' + title +'* 정보(' + day  + ')]\n' +
         '---\n' + _info;
  bot.reply(message, _msg);
  redisHA.test(bot, message, namespace);
}

function deletePod(bot, message) {
  var stdout   = execSync("delete-pods.sh");
  var _msg = '---' + '\n' +
             stdout.toString( ) + '\n' +
             '---' + '\n';
  bot.reply(message, _msg);
}

controller.hears(['^delete pod$', '^Delete pod'], botScope, (bot, message) => {
  deletePod(bot, message);
});

controller.hears(['^hi$', '^Hi$', '^HI$', '^안녕$', '^hello$', '^Hello$'], botScope, (bot, message) => {
  bot.reply(message, process.env.SYS_NAME + ': _안녕_');
});

function podStatus_(bot, message) {
  // var cnt   = execSync("kubectl get pod --all-namespaces -o wide | grep -v NAME | egrep -v \"Running|Comple\" | wc -l");
  var cnt   = execSync("kubectl get pods --field-selector=status.phase!=Running -n $n | grep -v NAME | wc -l");
  if (cnt.toString( ).replace(/\n/, '') == '0') {
    bot.reply(message, process.env.SYS_NAME + ' : _좋아_');
    return ;
  }
  var stdout   = execSync("kubectl get pod --all-namespaces -o wide | egrep -v \"Running|Comple\"");
  // var stdout   = execSync("kubectl get pods --field-selector=status.phase!=Running -n $n | grep -v NAME");
  var _msg = process.env.SYS_NAME + '\n' +
             '-----------------------------------+' + '\n' +
             ' 확인 필요한 Pod 정보'                + '\n' +
             '-----------------------------------+' + '\n' +
             stdout.toString( ) + '\n' +
             '-----------------------------------';
  bot.reply(message, _msg);
}

function podStatus(bot, message) {
  var stdout   = execSync("get-pods-status.sh");
  var _msg = '---' + '\n' +
             stdout.toString( ) + '\n' +
             '---' + '\n';
  bot.reply(message, _msg);
}

controller.hears(['^status$', '^stat$', '^상태$', '^상태는$'], botScope, (bot, message) => {
  podStatus(bot, message);
});

controller.hears(['console', 'zcp', '관리화면'], botScope, (bot, message) => {
  bot.reply(message, 'http://' + process.env.SYS_IP + ':8443/');
});

// controller.hears(['api', '명세서'], botScope, (bot, message) => {
//   bot.reply(message, 'api명세서 링크주소');
// });
// controller.hears(['일정', '일정관리'], botScope, (bot, message) => {
//   bot.reply(message, '일정관리 링크주소');
// });
/*
controller.hears(['string', 'pattern .*', new RegExp('.*', 'i')], 'message,other_event', async(bot, message) => {
  // do something!
  await bot.reply(message, 'I heard a message.');
});
 */

controller.hears(
  ['.*'],
  ['user_typing','direct_message', 'direct_mention', 'mention'],
  async (bot, message) => {
    await bot.reply(message, 'I heard a message.');
  },
);
/**
RECEIVED:  { type: 'user_typing',
  channel: 'CGA2RRGFK',
  user: 'U78TVDUJD',
  raw_message: { type: 'user_typing', channel: 'CGA2RRGFK', user: 'U78TVDUJD' },
  _pipeline: { stage: 'receive' } }
RECEIVED:  { type: 'user_typing',
  channel: 'CGA2RRGFK',
  user: 'U78TVDUJD',
  raw_message: { type: 'user_typing', channel: 'CGA2RRGFK', user: 'U78TVDUJD' },
  _pipeline: { stage: 'receive' } }
RECEIVED:  { client_msg_id: '246e898d-1b7b-4383-a3f8-95a936bbaf4e',
  suppress_notification: false,
  type: 'ambient',
  text: 'h',
  user: 'U78TVDUJD',
  team: 'T7A9JREBY',
  user_team: 'T7A9JREBY',
  source_team: 'T7A9JREBY',
  channel: 'CGA2RRGFK',
  event_ts: '1571288032.005300',
  ts: '1571288032.005300',
  raw_message: 
   { client_msg_id: '246e898d-1b7b-4383-a3f8-95a936bbaf4e',
     suppress_notification: false,
     type: 'message',
     text: 'h',
     user: 'U78TVDUJD',
     team: 'T7A9JREBY',
     user_team: 'T7A9JREBY',
     source_team: 'T7A9JREBY',
     channel: 'CGA2RRGFK',
     event_ts: '1571288032.005300',
     ts: '1571288032.005300' },
  _pipeline: { stage: 'receive' } }
 */
controller.middleware.receive.use(function(bot, message, next) {
  console.log('RECEIVED: ', message);
  if (message.type == 'ambient') {
    if (message.text.match('^[hH]elp$')) {
      help(bot, message);
    }
    else if (message.text.match('^[hH]i$')) {
      bot.reply(message, process.env.SYS_NAME + ': _안녕_');
    }
    else if (message.text.match('^[iI]nfo$')) {
      clusterInfo(bot, message);
    }
    else if (message.text.match('^[rR]edis info$')) {
      redisMaster(bot, message);
    }
    else if (message.text == '상태' ||
      message.text.match('[sS]tatus')) {
      podStatus(bot, message);
    }
    else if (message.text.match('^[nN]ode$')) {
      node(bot, message);
    }
    else if (message.text.match('^[tT]op node$')) {
      topNode(bot, message);
    }
    else if (message.text.match('^[tT]op pod$')) {
      topPod(bot, message);
    }
    else if (message.text.match('^[dD]elete pod$')) {
      deletePod(bot, message);
    }
    else if (message.text.match('^[rR]edis info$')) {
      redisMaster(bot, message);
    }
    /*
    // else if (message.text.match('[rR]edis reset mta-[dev|stg]-[bff|cor]')) {
    else if (message.text.match('[rR]edis reset')) {
      var desc      = 'REDIS-WALKHILL';
      redisResetMasterInfo(bot, message, desc);
    }
     */
    else {
      console.log('- message.text[' + message.text + ']');
      // bot.reply(message, 'bot reploy :: ' + message.text);
      bot.reply(message, 'I heard a message.');
    }
  }
  // message.logged = true;
  next( );
});

controller.middleware.send.use(function(bot, message, next) {
  console.log('SEND: ', message);
  // message.logged = true;
  next( );
});

controller.hears(['question'], botScope, (bot, message) => {
  bot.createConversation(message, (error, conv) => {
    convo.addMessage({ text: 'How wonderful.'}, 'yes_thread');
    convo.addMessage({ text: 'Cheese! It is not for everyone.', action: 'stop' }, 'no_thread');
    convo.addMessage({ text: 'Sorry I did not understand. Say `yes` or `no`', action: 'default' }, 'bad_response');
    convo.ask('Do you like cheese?', [{
      pattern: bot.utterances.yes,
      callback: (response) => {
        convo.gotoThread('yes_thread');
      },
    }, {
      pattern: bot.utterances.no,
      callback: (response) => { 
        convo.gotoThread('no_thread');
      },
    }, {
      default: true,
      callback: (response) => {
        convo.gotoThread('bad_response');
      },
    }]);
    convo.activate( );
    convo.on('end', () => {
      if (convo.successful( )) {
        bot.reply(message, 'Let us eat som!');
      }
    });
  });
});

controller.spawn({
  token: process.env.SLACK_TOKEN,
  retry: 10
}).startRTM( );
// rtmManager(controller, {token: process.env.SLACK_TOKEN});
/////////////////////////////////////
// 
function shspawn(command) {
  spawn('sh', ['-c', command], { stdio: 'inherit' });
}
