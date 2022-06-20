function steadySection = findSteadySection(tsData1, tsData2, thldData1, thldData2, stdCheckDur, stdCheckSpan, lowerLimData1, lowerLimData2)
%% 시계열 데이터에서 맵테스트 등의 정상 상태 시험을 한 경우에 Steady 작동 구간을 찾아주는 함수임 
%  입력 변수의 설명은 다음과 같음 
%  tsData1 : 정상상태 구간을 검색할 첫번째 변수의 시계열 데이터 ex) rpm
%  tsData2 : 정상상태 구간을 검색할 두번째 변수의 시계열 데이터 ex) torque
%  thldData2 : 두번째 변수의 정상상태 기준 범위 ex) torque에 대해서 엔진은 50Nm, 모터는 10Nm 적용
%  stdCheckDur : 정상 상태를 찾는 최소 간격, 10Hz 데이터에서 50은 5초 이상의 정상상태 구간을 찾는 것을 의미
%  stdCheckSpan : 정상상태를 찾을때 데이터 비교 간격 -> 10Hz 데이터에서 10은 1초 간격으로 정상상태인지를 체크함을 의미
%  lowerLimData1 : 첫번째 변수에 대해 작동을 확인하기 위한 최소값 기준 ex) rpm에 대해서 엔진은 500rpm, 모터는 50rpm 적용
%  lowerLimData2 : 두번째 변수에 대해 작동을 확인하기 위한 최소값 기준 ex) torque에 대해서 10Nm를 적용
%  출력 
%  steadySection.steadyStPoint : 정상상태 구간 시작점 행 위치 
%  steadySection.steadyEdPoint : 정상상태 구간 종료점 행 위치 

rpm = tsData1;
torque = tsData2;

stdOffsetTorque = thldData1;
stdOffsetRPM = thldData2;


% torqueDiff = abs(diff(torque));
% rpmDiff = abs(diff(rpm));

torqueDiff = abs(torque((stdCheckSpan+2):end)-torque(1:end-(stdCheckSpan+1)));
rpmDiff = abs(rpm((stdCheckSpan+2):end)-rpm(1:end-(stdCheckSpan+1)));
rpmThld = rpm>lowerLimData1 ; 
tqThld = torque>lowerLimData2 ; 

torqueDiffNor = torqueDiff<stdOffsetTorque;
rpmDiffNor = rpmDiff<stdOffsetRPM;

diffComb = rpmThld(1:size(rpmDiff,1)).*tqThld(1:size(torqueDiff,1)).*torqueDiffNor.*rpmDiffNor;


steadyStPointTemp = find(diff(diffComb) == 1)+stdCheckSpan ;
steadyEdPointTemp = find(diff(diffComb) == -1)+1 ;

if steadyEdPointTemp(1) < steadyStPointTemp(1)
steadyStPointTemp2 = steadyStPointTemp(1:end-1);
steadyEdPointTemp2 = steadyEdPointTemp(2:size(steadyStPointTemp2,1)+1);
else
steadyStPointTemp2 = steadyStPointTemp(1:end-1);
steadyEdPointTemp2 = steadyEdPointTemp(1:size(steadyStPointTemp2,1));
end



idxSteadyPoint = find((steadyEdPointTemp2-steadyStPointTemp2) > stdCheckDur);

steadyStPoint = steadyStPointTemp2(idxSteadyPoint);
steadyEdPoint = steadyEdPointTemp2(idxSteadyPoint);




steadySection.steadyStPoint = steadyStPoint;
steadySection.steadyEdPoint = steadyEdPoint;
