/ 2025-03-10 //
/ Wolfram's Rule 110 //

/ Replacement rules //
/$111/0$11/
/$110/1$10/
/$101/1$01/
/$100/0$00/
/$011/1$11/
/$010/1$10/
/$001/1$01/
/$000/0$00/

/ Return execution pointer to begining of string //
/$00:/@0:/
/0@/@0/
/1@/@1/
/:@/:$0/

/ Initial state //
:$0000000000000000000000000000000000000000000100:

/ Terminate when the following pattern is expanded //
\:$01\
