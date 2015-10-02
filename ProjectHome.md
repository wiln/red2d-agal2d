# GPU accelerated 2D framework 'Molehill' #

Red2DPlus V1.1.0이 공개되었습니다. (need Air 3.2 sdk, flash 4.6 sdk)

About flash player 11.3 변경사항에 대하여<p>
11.3 터치이벤트 API가 변경되었습니다.<p>
InteractionManager_Mobile.as 파일관련해서 11.3버전을 설치 하실경우 <p>
에러들이 쭉뜨는데용..<p>
InteractionManager_Mobile.as 파일부분에서<p>
$event.commandKey,<p>
$event.controlKey, <p>
$event.timestamp, <p>
$event.touchIntent,<p>
null,<p>
$event.isTouchPointCanceled<p>
부분을 삭제해 주시면 잘 돌아갑니다<p>


Red2D의 공식홈페이지 - <a href='http://red2d.org'>http://red2d.org</a>
<p />
Tutorial...<br>
<p />
<p><a href='http://red2d.cafe24.com/wordpress/?page_id=496' title='Red2D 시작하기'>01.Red2D 시작하기</a><p />
<a href='http://red2d.cafe24.com/wordpress/?page_id=535'>02.Red_Sprite 알아보기</a><p />
03.Material 알아보기 (준비중)<p />
04.마우스이벤트 알아보기 (준비중)<p />
05.Red_Textfiled , Red_InputTextField (준비중)<p />
06.Camera 알아보기 (준비중)<p />
07.filter 알아보기 (준비중)<p />
08.Particle 알아보기 (준비중)</p>

///////////////////////////////////////////////<p />
preview next update<p />
1. mobile example<p />
2. tutorial update<p />
3. mask <p />
4. context Filter(후처리 필터)<p />
5. 파티클생성기 및 파티클 클래스 정식버전 <p />
6. 필터 하이라키 개선<p />
7. red2dPlus Java version for android(use openGL es2.0)