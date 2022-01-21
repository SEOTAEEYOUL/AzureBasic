'use strict';
const os         = require('os');
const execSync   = require('child_process').execSync;
var text = 'redis twd-dev-bff';
console.log(text);
// if (text.match('/[rR]edis twd-[dev|stg]-[bff|cor]/')) {
if (text.match('[rR]edis twd-[dev|stg]')) {
  var strArray  = text.split(' ');
  var nameArray = strArray[1].split('-');  
  var namespace = strArray[1];
  var desc      = 'REDIS-' + nameArray[2].toUpperCase( );
  console.log(text + '-> ' + namespace + ', ' + desc);
}
var text2 = 'redis reset twd-stg-bff';
console.log(text2);
// if (text2.match('[rR]edis reset twd-[dev|stg]-[bff|cor]')) {
// if (text2.match('[rR]edis reset twd')) { // O.K
// if (text2.match('redis reset twd-[dev|stg]')) { // O.K
if (text2.match('[rR]edis reset twd-[dev|stg]')) {
  var strArray  = text2.split(' ');
  var nameArray = strArray[2].split('-');  
  var namespace = strArray[2];
  var desc      = 'REDIS-' + nameArray[2].toUpperCase( );
  console.log(text2 + '-> ' + namespace + ', ' + desc);
}

var text3 = 'top node';
if (text3.match('[tT]op [node|pod]')) {
  var strArray  = text3.split(' ');
  console.log(text3 + '-> ' + strArray[0] + ', ' + strArray[1]);
}
