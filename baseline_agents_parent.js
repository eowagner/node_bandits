var child_process = require('child_process');
var fs = require('fs');
var slot_machines = require('./bandit_utils/slot_machines.js');
var beta_agents = require('./bandit_utils/beta_agents.js');
var social_networks = require('./bandit_utils/social_networks.js');

const numCPUs = require('os').cpus().length;
// const numCPUs = 1;

const runs = 10;
const steps = 1000;
const priors = "uniform";

var num_agent_list = [];
for (var i=3; i<25; i++) {
	num_agent_list.push(i);
}

var results_as_strings = [];

//Global required for traversing the independent variable over multiple child processes
//And then determining that every independent variable has completed 
var proc_index = 0; 
var completed_processes = 0;

var machine_ps = [.5, .55];
var machine_list = [];
for (var i=0; i<machine_ps.length; i++) {
	machine_list.push(new slot_machines.BernoulliMachine(machine_ps[i]));
}


var start_time = new Date().getTime();

for (var i=0; i<numCPUs; i++) {
	launch_next_child();
}

function launch_next_child() {
	if (proc_index >= num_agent_list.length)
		return;	

	var complete_graph = social_networks.makeCompleteGraph(num_agent_list[proc_index]);
	var star_graph = social_networks.makeStarGraph(num_agent_list[proc_index]);

	var parameters = {
		priors: priors,
		p: [.5, .55],
		target: 1,
		runs: runs,
		steps: steps,
		graphs: [complete_graph, star_graph]
	};

	proc_index++;

	var child = child_process.fork('./generic_child.js');

	child.send(parameters);

	child.on('message', function(message) {
		console.log(message.parameters.graphs[0].length + " complete");

		results_as_strings.push(convert_results_to_string(message));

		launch_next_child();

		completed_processes++;
		if (completed_processes >= num_agent_list.length) {
			print_results(results_as_strings);

			var end_time = new Date().getTime();
			console.log((end_time-start_time)/1000/60 + " minutes elapsed");
		}
		
	});
}


function convert_results_to_string(res) {
	var s = res.parameters.graphs[0].length + "," + res.parameters.p[0] + "," + res.parameters.p[1] + ",";

	s += res.success_counts.join(",") + ",";
	s += res.consensus_counts.join(",");

	return s;
}

function print_results(results_as_strings) {
	var info =  "priors: " + priors + "; runs: " + runs + "; steps: " + steps;

	var stream = fs.createWriteStream(new Date().getTime() + ".csv");

	stream.once('open', function(fd) {
		stream.write("# " + info + "\n");
		stream.write("num_agents,p0,p1,success_complete,success_star,consensus_complete,consensus_star\n");
		stream.write(results_as_strings.join("\n"));

		stream.end();
	});
}