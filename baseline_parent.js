var child_process = require('child_process');
var fs = require('fs');

const num_agents = 9;
const runs = 1000;
const steps = 1000;

var numchild = require('os').cpus().length;
numchild = (numchild<4) ? numchild : 3;

var done = 0;

var results_table = new Array(3);

var start_time = new Date().getTime();

for (var i=0; i<numchild; i++) {
	var child = child_process.fork('./baseline_child.js');

	var parameters = {
		num_agents: num_agents,
		priors_index: i,
		runs: runs,
		steps: steps
	};

	child.send(parameters);

	child.on('message', function(message) {
		console.log('child ' + message.priors_index + ' returned results');

		results_table[message.priors_index] = message.sim_results;

		done++;
		if (done === numchild) {
			console.log('All child processes have completed');

			var end_time = new Date().getTime();
			console.log("Minutes elapsed: " + (end_time - start_time)/1000/60);
			print_results(results_table);
		}
	});
}

function print_results(results_table) {
	var info = "num_agents: " + num_agents + "; runs: " + runs + "; steps: " + steps;

	var stream = fs.createWriteStream(new Date().getTime() + ".csv");
	
	stream.once('open', function(fd) {
		stream.write("# " + info + "\n");

		stream.write('p,uniform_complete_success,uniform_complete_consensus,uniform_star_success,uniform_star_consensus,jeffrey_complete_success,jeffrey_complete_consensus,jeffrey_star_success,jeffrey_star_consensus,random_complete_success,random_compete_consensus,random_star_success,random_star_consensus\n');

		for(var i=0; i<results_table[0].p_list.length; i++) {
			stream.write(results_table[0].p_list[i].toString());
			for (var j=0; j<results_table.length; j++) {
				stream.write("," + results_table[j].success_complete[i] +"," + results_table[j].consensus_complete[i] + "," + results_table[j].success_star[i] + "," + results_table[j].consensus_star[i]);
			}
			stream.write("\n");
		}

		stream.end();
	});
}