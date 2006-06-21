#!/bin/bash

#
#$Id: runall.sh,v 1.14 2006/06/14 21:07:43 argiro Exp $
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

testsMuon="recolocal-application-dtrechits.cfg
recolocal-application-cscchain.cfg
reco-application-rpcrechits.cfg
"

testVertex="reco-application-primaryvertexfinding.cfg sim_rec_10muons_1-10GeV.cfg"

testEcal="reco-application-ecal-simulation.cfg
reco-application-ecal-digitization.cfg
reco-application-ecal-localreco.cfg
reco-application-ecal-egammaclusters.cfg
"

testHcal="Zprime_Dijets_700_JetMETintegration.cfg"

tests=`echo $testsTracking $testsSim $testsMuon $testVertex $testEcal $testHcal`

report=""

let nfail=0
let npass=0

echo "Tests to be run : " $tests

eval `scramv1 runtime -sh`

for file in $tests 
do
    echo Preparing to run $file
    cmsRun $file
    if [ $? -ne 0 ] ;then
      echo "cmsRun $file : FAILED"
      report="$report \n cmsRun $file : FAILED"
      let nfail+=1
    else 
      echo "cmsRun $file : PASSED"
      report="$report \n cmsRun $file : PASSED"
      let npass+=1
    fi 
done


report="$report \n \n $npass tests passed, $nfail failed \n"

echo -e "$report" 
rm -f runall-report.log
echo -e "$report" >& runall-report.log
