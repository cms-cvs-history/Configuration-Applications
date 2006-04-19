#!/bin/bash

#
#$Id$
#
#Dummy script to run all integration tests
#
#

tests="reco-application-sim_10mum.cfg
reco-application-digitize_strips_from_flatptgun.cfg
reco-application-DigisToClusters.cfg
reco-application-ClustersToHits.cfg
reco-application-HitsToSeeds.cfg
reco-application-SeedsToClouds.cfg
reco-application-CloudsToClean.cfg
reco-application-CleanToTrackCandidates.cfg
reco-application-TrackCandidatesToTracks.cfg
reco-application-AnalyzeTracks.cfg
sim-application.cfg
sim-application-digitization.cfg
"

eval `scramv1 runtime -sh`

for file in $tests 
do
    cmsRun $file
    if [ $? -ne 0 ] ;then
      echo "cmsRun $file : FAILED"
      exit 1 
    fi 
done
