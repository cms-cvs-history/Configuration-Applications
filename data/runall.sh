#!/bin/bash

#
#$Id: runall.sh,v 1.22 2006/08/22 08:49:08 argiro Exp $
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
TrackValidator.cfg
"

testsSim="sim-application.cfg
sim-application-digitization.cfg
"

testsMuon="recolocal-application-dtrechits.cfg
recolocal-application-cscchain.cfg
reco-application-rpcrechits.cfg
"

testVertex="reco-application-primaryvertexfinding.cfg 
sim_rec_10muons_1-10GeV.cfg 
VertexRead.cfg"

testEcal="reco-application-ecal-simulation.cfg
reco-application-ecal-digitization.cfg
reco-application-ecal-localreco.cfg
reco-application-ecal-egammaclusters.cfg
"

testHcal="reco-application-calorimetry-allinone.cfg Zprime_Dijets_JetMETintegration.cfg"

tests=`echo  $testsTracking $testsSim $testsMuon $testVertex $testEcal $testHcal`

report=""

let nfail=0
let npass=0

echo "Tests to be run : " $tests

eval `scramv1 runtime -sh`

for file in $tests 
do
    echo Preparing to run $file
    let starttime=`date "+%s"`
    cmsRun $file
    let exitcode=$?

    let endtime=`date "+%s"`
    let tottime=$endtime-$starttime;   

    if [ $exitcode -ne 0 ] ;then
      echo "cmsRun $file : FAILED - time: $tottime s - exit: $exitcode"
      report="$report \n cmsRun $file : FAILED  - time: $tottime s - exit: $exitcode"
      let nfail+=1
    else 
      echo "cmsRun $file : PASSED - time: $tottime s"
      report="$report \n cmsRun $file : PASSED  - time: $tottime s"
      let npass+=1
    fi 
done


report="$report \n \n $npass tests passed, $nfail failed \n"

echo -e "$report" 
rm -f runall-report.log
echo -e "$report" >& runall-report.log
