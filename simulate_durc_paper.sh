#!/bin/bash

TIMESTAMP="$(date +%Y%m%d%H%M%S)"
DNAME="out/$TIMESTAMP"
RUNS=100000
# RUNS=1
PROG="nodejs"

mkdir -p $DNAME

# $PROG bernoulli_simulations/time.js -r $RUNS -s 1000 -q .6 | tee "$DNAME/time.csv"
# $PROG bernoulli_simulations/baseline_p_parent.js -p uniform -r $RUNS -s 1000 -n 9 | tee "$DNAME/baseline-p.csv"
# $PROG bernoulli_simulations/baseline_agents_parent.js -p uniform -r $RUNS -s 1000 -q .6 | tee "$DNAME/baseline-agents-6.csv"
# $PROG bernoulli_simulations/diss_p_parent.js -p uniform -r $RUNS -s 1000 -n 9 -c randomize| tee "$DNAME/diss-p-randomized.csv"
# $PROG bernoulli_simulations/diss_p_parent.js -p uniform -r $RUNS -s 1000 -n 9 -c low| tee "$DNAME/diss-p-low.csv"
# $PROG bernoulli_simulations/diss_p_parent.js -p uniform -r $RUNS -s 1000 -n 9 -c high| tee "$DNAME/diss-p-high.csv"
# $PROG bernoulli_simulations/diss_agents_parent.js -p uniform -r $RUNS -s 1000 -q .6 -c randomize | tee "$DNAME/diss-agents-6-randomized.csv"
# $PROG bernoulli_simulations/diss_agents_parent.js -p uniform -r $RUNS -s 1000 -q .6 -c low | tee "$DNAME/diss-agents-6-low.csv"
# $PROG bernoulli_simulations/diss_agents_parent.js -p uniform -r $RUNS -s 1000 -q .6 -c high | tee "$DNAME/diss-agents-6-high.csv"
# $PROG bernoulli_simulations/conduct_p_parent.js -p uniform -r $RUNS -s 1000 -n 9 -c randomize | tee "$DNAME/conduct-randomized.csv"
# $PROG bernoulli_simulations/conduct_p_parent.js -p uniform -r $RUNS -s 1000 -n 9 -c low | tee "$DNAME/conduct-low.csv"
# $PROG bernoulli_simulations/conduct_p_parent.js -p uniform -r $RUNS -s 1000 -n 9 -c high | tee "$DNAME/conduct-high.csv"
$PROG bernoulli_simulations/conduct_agents_parent.js -p uniform -r $RUNS -s 1000 -n 2 -c randomize | tee "$DNAME/conduct-agents.csv"
# $PROG bernoulli_simulations/hybrid_p_parent.js -p uniform -r $RUNS -s 1000 -n 9 -c randomize | tee "$DNAME/hybrid-randomized.csv"
# $PROG bernoulli_simulations/hybrid_p_parent.js -p uniform -r $RUNS -s 1000 -n 9 -c low | tee "$DNAME/hybrid-low.csv"
# $PROG bernoulli_simulations/hybrid_p_parent.js -p uniform -r $RUNS -s 1000 -n 9 -c high | tee "$DNAME/hybrid-high.csv"