#!/bin/bash

#
#$Id: runall.sh,v 1.3 2006/05/01 14:04:59 tboccali Exp $
#
#Dummy script to run all integration tests
#
#

testsRS="reco-application-RS-sim_10mum.cfg
reco-application-RS-digitize_strips_from_flatptgun.cfg
reco-application-RS-DigisToClusters.cfg
reco-application-RS-ClustersToHits.cfg
reco-application-RS-HitsToSeeds.cfg
reco-application-RS-SeedsToClouds.cfg
reco-application-RS-CloudsToClean.cfg
reco-application-RS-CleanToTrackCandidates.cfg
reco-application-RS-TrackCandidatesToTracks.cfg
reco-application-RS-AnalyzeTracks.cfg
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
