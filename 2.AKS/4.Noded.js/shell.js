const HOSTNAME={
"hostname":
  [
    {"hostIP":"172.30.0.21","hostName":"skt-mtwpmst01"},
    {"hostIP":"172.30.0.22","hostName":"skt-mtwpmst02"},
    {"hostIP":"172.30.0.23","hostName":"skt-mtwpmst03"},
    {"hostIP":"172.30.0.24","hostName":"skt-mtwpprx01"},
    {"hostIP":"172.30.0.25","hostName":"skt-mtwpprx02"},
    {"hostIP":"172.30.0.26","hostName":"skt-mtwpprx03"},
    {"hostIP":"172.30.0.27","hostName":"skt-mtwpwk01"},
    {"hostIP":"172.30.0.28","hostName":"skt-mtwpwk02"},
    {"hostIP":"172.30.0.29","hostName":"skt-mtwpwk03"},
    {"hostIP":"172.30.0.30","hostName":"skt-mtwpmgt01"},
    {"hostIP":"172.30.0.31","hostName":"skt-mtwpmgt02"},
    {"hostIP":"172.30.0.32","hostName":"skt-mtwpva01"},
    {"hostIP":"172.30.0.65","hostName":"skt-mtwpwk04"},
    {"hostIP":"172.30.0.66","hostName":"skt-mtwpwk05"},
    {"hostIP":"172.30.0.67","hostName":"skt-mtwpwk06"},
    {"hostIP":"172.30.0.68","hostName":"skt-mtwpwk07"},
    {"hostIP":"172.30.0.69","hostName":"skt-mtwpwk08"},
    {"hostIP":"172.30.0.70","hostName":"skt-mtwpwk09"},
    {"hostIP":"172.30.0.71","hostName":"skt-mtwpmgt03"},
    {"hostIP":"172.30.0.72","hostName":"skt-mtwpadm01"}
  ]
}

var spawn = require('child_process').spawn;
function shspawn(command) {
   spawn('sh', ['-c', command], { stdio: 'inherit' });
} 
// shspawn('ls -l | grep test | wc -c');
// shspawn("kubectl get pod -o wide --all-namespaces -lredis-role=master | awk '{ print $1\"|\"$2\"|\"$8 }'");
const execSync = require('child_process').execSync;
// const stdout   = execSync('ls -l | grep test | wc -c');
const stdout   = execSync("kubectl get pod -o wide --all-namespaces -lredis-role=master | grep -v NAME | awk '{ print $1\"|\"$2\"|\"$8 }'");
console.log(stdout.toString( ));
