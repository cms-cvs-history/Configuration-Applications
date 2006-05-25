#!/bin/bash

#
#$Id: runall.sh,v 1.6 2006/05/11 14:27:04 argiro Exp $
#
#Dummy script to run all integration tests
#
#

testsTracking="reco-application-tracking-simulation.cfg
reco-application-tracking-digitization.cfg
reco-application-tracking-clusterization.cfg
reco-application-tracking-rechitconversion.cfg
reco-application-tracking-seedfinding-globalpixel.cfg
reco-application-tracking-seedfinding-roadsearch.cfg
reco-application-tracking-patternrecognition-kftrackcandidatemaker.cfg
reco-application-tracking-patternrecognition-rscloudmaker.cfg
reco-application-tracking-patternrecognition-rscloudcleaner.cfg
reco-application-tracking-patternrecognition-rstrackcandidatemaker.cfg
reco-application-tracking-finaltrackfits-ctffinalfitanalytical.cfg
reco-application-tracking-finaltrackfits-ctffinalfitwithmaterial.cfg
reco-application-tracking-finaltrackfits-rsfinalfitanalytical.cfg
reco-application-tracking-finaltrackfits-rsfinalfitwithmaterial.cfg
"

testsSim="sim-application.cfg
sim-application-digitization.cfg
"

tests=`echo $testsTracking $testsSim`

report=""

echo "Tests to be run : " $tests

eval `scramv1 runtime -sh`

for file in $tests 
do
    echo Preparing to run $file
    cmsRun $file
    if [ $? -ne 0 ] ;then
      echo "cmsRun $file : FAILED"
      report="$report \n cmsRun $file : FAILED" 
    else 
      echo "cmsRun $file : PASSED"
      report="$report \n cmsRun $file : PASSED"
    fi 
done


echo -e "$report" 
echo -e "$report" >! runall-report.log
