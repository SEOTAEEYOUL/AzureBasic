"use strict"
var winston      = require('winston'); // 로그 처리 모듈
var winstonDaily = require('winston-daily-rotate-file'); // 로그 일별 처리 모듈
var moment       = require('moment');  // 시간 처리 모듈

// log level
//
// debug: 0 > info: 1 > notice: 2 > warning: 3 > error: 4 > crit: 5 > alert: 6 > emerg: 7
function timeStampFormat( ) {
  return (moment( ).format('YYYY-MM-DD HH:mm:ss.SSS ZZ'));
  // ex) '2016-05-01 20:14:28.500 +0900'
};
var logger = new (winston.createLogger)({
  transports: [
    new (winstonDaily)({
      name: 'info-file',
      filename: './log/server',
      dateFattern: '_yyyy-MM-dd.log',
      colorize: false,
      maxsize: 50000000,
      maxFiles: 1000,
      level: 'info',
      showLevel: true,
      json: false,
      timestamp: timeStampFormat
    }),
    new (winston.transports.Console)({
      name: 'debug-console',
      colorize: true,
      level: 'debug',
      showLevel: true,
      json: false,
      timestamp: timeStampFormat
    })
  ],
  exceptionHandlers: [
    new (winstonDaily)({
      name: 'exception-file',
      filename: './log/exception',
      datePattern: '_yyyy-MM-dd.log',
      colorize: false,
      maxsize: 50000000,
      maxFiles: 1000,
      level: 'error',
      showLevel: true,
      json: false,
      timestamp: timeStampFormat
    }),
    new (winston.transports.Console)({
      name: 'exception-console',
      colorize: true,
      level: 'debug',
      showLevel: true,
      json: false,
      timestamp: timeStampFormat
    })
  ]
});
module.exports = {
  logger: logger
}
// logger.info("Info");
// logger.debug("Debug");
// logger.debug("Error");
