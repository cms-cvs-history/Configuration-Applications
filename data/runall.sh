#!/bin/bash

#
#$Id: runall.sh,v 1.2 2006/04/25 10:28:19 argiro Exp $
#
#Dummy script to run all integration tests
#
#

testsRS="reco-application-sim_10mum.cfg
reco-application-digitize_strips_from_flatptgun.cfg
reco-application-DigisToClusters.cfg
reco-application-ClustersToHits.cfg
reco-application-HitsToSeeds.cfg
reco-application-SeedsToClouds.cfg
reco-application-CloudsToClean.cfg
reco-application-CleanToTrackCandidates.cfg
reco-application-TrackCandidatesToTracks.cfg
reco-application-AnalyzeTracks.cfg
"


testsKF="reco-application-KF-generation.cfg
reco-application-KF-digitization.cfg
reco-application-KF-rechits.cfg
reco-application-KF-seeds.cfg
reco-application-KF-trajectorybuilding.cfg
reco-application-KF-finalfit.cfg
reco-application-KF-readtracks.cfg
"


testsSim="sim-application.cfg
sim-application-digitization.cfg
"

tests=`echo $testsKF $othertests testsSim`

echo "Tests to be run : " $tests

eval `scramv1 runtime -sh`

for file in $tests 
do
    echo Preparing to run $file
    cmsRun $file
    if [ $? -ne 0 ] ;then
      echo "cmsRun $file : FAILED"
    else 
      echo "cmsRun $file : PASSED"
    fi 
done
