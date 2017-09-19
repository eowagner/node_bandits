#!/bin/bash

TIMESTAMP="$(date +%Y%m%d%H%M%S)"
DNAME="out/$TIMESTAMP"
RUNS=2

mkdir -p $DNAME
nodejs bernoulli_simulations/baseline_p_parent.js -p uniform -r $RUNS -s 1000 -n 9 | tee "$DNAME/baseline-p.csv"
nodejs bernoulli_simulations/baseline_agents_parent.js -p uniform -r $RUNS -s 1000 -q .55 | tee "$DNAME/baseline-agents-55.csv"
# nodejs bernoulli_simulations/baseline_agents_parent.js -p uniform -r $RUNS -s 1000 -q .6 | tee "$DNAME/baseline-agents-6.csv"
nodejs bernoulli_simulations/diss_p_parent.js -p uniform -r $RUNS -s 1000 -n 9 -c randomize| tee "$DNAME/diss-p-randomized.csv"
nodejs bernoulli_simulations/diss_p_parent.js -p uniform -r $RUNS -s 1000 -n 9 -c low| tee "$DNAME/diss-p-low.csv"
nodejs bernoulli_simulations/diss_p_parent.js -p uniform -r $RUNS -s 1000 -n 9 -c high| tee "$DNAME/diss-p-high.csv"
nodejs bernoulli_simulations/diss_agents_parent.js -p uniform -r $RUNS -s 1000 -q .55 | tee "$DNAME/diss-agents-55.csv"
# nodejs bernoulli_simulations/dissemination_agents_parent.js -p uniform -r $RUNS -s 1000 -q .6 | tee "$DNAME/diss-agents-6.csv"
nodejs bernoulli_simulations/conduct_p_parent.js -p uniform -r $RUNS -s 1000 -n 9| tee "$DNAME/conduct.csv"
nodejs bernoulli_simulations/hybrid_p_parent.js -p uniform -r $RUNS -s 1000 -n 9| tee "$DNAME/hybrid.csv"