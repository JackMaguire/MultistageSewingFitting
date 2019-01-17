#!/bin/bash

NTRAJ=1000

for C in 1 5 10 15; do

    for D in 0.05 0.1 0.15 0.25; do

	for E in 1 5 10 15; do

	    for F in 0.05 0.1 0.15 0.25; do

		for G in 1 5 10; do
		
		    for H in 0.1 0.15 0.25; do

			# create temp script
			cat template.xml \
			    | sed "s/[[C]]/$C/g" \
			    | sed "s/[[D]]/$D/g" \
			    | sed "s/[[E]]/$E/g" \
			    | sed "s/[[F]]/$F/g" \
			    | sed "s/[[G]]/$G/g" \
			    | sed "s/[[H]]/$H/g" >> temp.xml

		    done

		done

	    done #F

	done #E
	
    done #D

done #C
