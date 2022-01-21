'use strict'
const prometheus = require('prom-client')
const gcStats    = require('prometheus-gc-stats');
// const Logger       = require('./logger');  
const express      = require('express');
/**
 * Newly added requires
 */
const register     = prometheus.register;

// Constants
const PORT         = 8090;
const HOST         = '0.0.0.0';
// Enable collection of default metrics  
// require('prom-client').collectDefaultMetrics();  
const metricInterval = prometheus.collectDefaultMetrics();
// gcStats( ) would have the same effect in this case
const startGcStats = gcStats(prometheus.register);
startGcStats( );
/**
 * This function will start the collection of metrics and should be called from within in the main js file
 */
/*
module.exports.startCollection = function( ) {
  // Logger.log(Logger.LOG_INFO, `Starting the collection metrics, the metrics are available on /metrics`);
  Console.log(Logger.LOG_INFO, `Starting the collection metrics, the metrics are available on /metrics`);
  // Enable collection of default metrics  
  // require('prom-client').collectDefaultMetrics();  
  prometheus.collectDefaultMetrics();  
};
 */
// HeapDump
// var heapdump = require('heapdump');
// var memoryLeak = [];
// 
// function LeakedObject( ) {};
// 
// 
// server.use('/leak', function(req, res, next) {
//   for (var i = 0; i < 1000; i++) {
//     memoryLeak.push(new LeakedObject( ));
//   }
//   res.send('making memory leak. Current memory usage: '
//            + (process.memoryUsage( ).rss / 1024 / 1024) + 'MB');
// 
// });
// 
// server.use('/heapdump', function(req, res, next) {
//   var filename = '/Users/terry/heapdump' + Date.now( ) + 'heapsnapshot';
//   heapdump.writeSnapshot(filename);
//   res.send('Heapdump has been generation in ' + filename);
// });
// HeapDump
// const app = express()
// const port = process.env.PORT || 3001
// const metricsInterval = prometheus.collectDefaultMetrics()
const checkoutsTotal = new prometheus.Counter({
  name: 'checkouts_total',
  help: 'Total number of checkouts',
  labelNames: ['payment_method']
})
const httpRequestDurationMicroseconds = new prometheus.Histogram({
  name: 'http_request_duration_ms',
  help: 'Duration of HTTP requests in ms',
  labelNames: ['method', 'route', 'code'],
  buckets: [0.10, 5, 15, 50, 100, 200, 300, 400, 500]  // buckets for response time from 0.1ms to 500ms
})

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const nodejs_exporter       = express( );
/**
 * In order to have Prometheus get the data from this app a specific URL is registered
 */
nodejs_exporter.get('/metrics', (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(register.metrics( ));
})
// Graceful shutdown
process.on('SIGTERM', () => {
  // clearInterval(metricsInterval);
  /*
  server.close((err) => {
    if (err) {
      console.error(err);
      process.exit(0);
    }
  })
   */
  process.exit(0);
});

nodejs_exporter.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}, metrics exposed on /metrics endpoint`);
