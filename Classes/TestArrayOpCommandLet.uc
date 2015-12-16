class TestArrayOpCommandLet extends Commandlet;

`include( TestArrayOp.uci );

`TestCaseDefinitions(byte)
`TestCaseDefinitions(int)
`TestCaseDefinitions(float)
`TestCaseDefinitions(string)
`TestCaseDefinitions(name)
`TestCaseDefinitions(Object)
`TestCaseDefinitions(Actor)
`TestCaseDefinitions(class)

`TestCaseVars(byte)
`TestCaseVars(int)
`TestCaseVars(float)
`TestCaseVars(string)
`TestCaseVars(name)
`TestCaseVars(Object)
`TestCaseVars(Actor)
`TestCaseVars(class)

var array<name> TestRuns;
var int ErrorCount;

var SoundCue NoSound;

event int Main( string Params )
{
	return Test(Params);
}

function TestRun();
function int Test(string Params)
{
	local int i;
	Loginternal("================");
	Loginternal("ArrayOp test");
	Loginternal("Executing tests:"@TestRuns.Length);
	Loginternal("");

	for(i=0; i<TestRuns.Length; i++)
	{
		GotoState(name("Run_"$TestRuns[i]));
		TestRun();
		Loginternal("");
	}

	Loginternal("================");
	if (ErrorCount > 0)
	{
		Loginternal(ErrorCount@"failed.");
		return 1;
	}

	Loginternal("All tests passed.");
	return 0;
}

`TestCaseStart(byte, "ArrayOp-initializing-byte")
`TestCaseDyn(0, ! byte(0))
`TestCaseDyn(1, ! byte(255))
`TestCaseDyn(2, ! byte(0) + 255)
`TestCaseDyn(3, ! byte(0) + 0)
`TestCaseDyn(4, ! byte(255) + 255)
`TestCaseDyn(5, ! byte(0) + 1 + 2)
`TestCaseDyn(6, ! byte(255) + 256 + 257)
`TestCaseDyn(7, ! byte(1) + 0 + 1)
`TestCaseEnd()

`TestCaseStart(int, "ArrayOp-initializing-int")
`TestCaseDyn(0, ! 1 + 2 + 3)
`TestCaseDyn(1, ! 3 + 4)
`TestCaseDyn(2, ! 0)
`TestCaseDyn(3, ! -1 + 1)
`TestCaseDyn(4, ! -2147483648 + 2147483647)
`TestCaseDyn(5, ! 0 + 0)
`TestCaseDyn(6, ! -1 + -1)
`TestCaseDyn(7, ! 2 + -1)
`TestCaseEnd()

`TestCaseStart(float, "ArrayOp-initializing-float")
`TestCaseDyn(0, ! 1.f + 2 + 3)
`TestCaseDyn(1, ! 3.f + 4)
`TestCaseDyn(2, ! 0.f)
`TestCaseDyn(3, ! -1.f + 1)
`TestCaseDyn(4, ! -2147483648.f + 2147483647)
`TestCaseDyn(5, ! 0.f + 0)
`TestCaseDyn(6, ! -1.f + -1)
`TestCaseDyn(7, ! 2.f + -1)
`TestCaseDyn(8, ! 10.f + 20.f + 30.f)
`TestCaseDyn(9, ! 30.f + 40.f)
`TestCaseDyn(10, ! 0.f)
`TestCaseDyn(11, ! -10.f + 10.f)
`TestCaseDyn(12, ! 0.1234 + 1.12345 + 2.123456 + 3.1234567)
`TestCaseDyn(13, ! 3.40298765432109876543210987654321098765432 + -3.40298765432109876543210987654321098765432)
`TestCaseDyn(14, ! 0.f + 0.f)
`TestCaseDyn(15, ! -10.f + -10.f)
`TestCaseDyn(17, ! 20.f + -10.f)
`TestCaseEnd()

`TestCaseStart(string, "ArrayOp-initializing-string")
`TestCaseDyn(0, ! "" + "")
`TestCaseDyn(1, ! "First" + "Second")
`TestCaseDyn(2, ! "OnlyOne")
`TestCaseDyn(3, ! "First_Then_Empty" + "" + "Now_Last")
`TestCaseDyn(4, ! "" + "First_was_empty")
`TestCaseDyn(5, ! "Last_is_empty" + "pre_last" + "")
`TestCaseEnd()

`TestCaseStart(name, "ArrayOp-initializing-name")
`TestCaseDyn(0, ! '')
`TestCaseDyn(1, ! 'none')
`TestCaseDyn(2, ! 'none' + '')
`TestCaseDyn(3, ! '' + '')
`TestCaseDyn(4, ! 'none' + 'none')
`TestCaseDyn(5, ! 'SomeName' + 'AnotherName with Space')
`TestCaseDyn(6, ! 'Some' + '' + 'And' + '' + 'None')
`TestCaseEnd()

`TestCaseStart(Object, "ArrayOp-initializing-Object")
`TestCaseDyn(0, ! NoSound)
`TestCaseDyn(1, ! NoSound + none)
`TestCaseDyn(2, ! FindObject("Engine.Default__Actor", class'Actor') + FindObject("Engine.Default__Info", class'Actor'))
`TestCaseEnd()

`TestCaseStart(Actor, "ArrayOp-initializing-Actor")
`TestCaseDyn(0, ! Actor(FindObject("Engine.Default__Actor", class'Actor')))
`TestCaseDyn(1, ! Actor(FindObject("Engine.Default__Info", class'Actor')) + none)
`TestCaseDyn(2, ! Actor(FindObject("Engine.Default__Note", class'Actor')) + Actor(FindObject("Engine.Default__Info", class'Actor')) + Actor(FindObject("UTGame.Default__UTPawn", class'Actor')))
`TestCaseEnd()

`TestCaseStart(class, "ArrayOp-initializing-class")
`TestCaseDyn(0, ! class'class')
`TestCaseDyn(1, ! class'Actor' + class'Info' + class'Material' + class'class')
`TestCaseEnd()

`include( ArrayOp.uci );

defaultproperties
{
	Begin object Class=SoundCue Name=MyNoSound
	end object
	NoSound=MyNoSound

	`TestRunRegister(byte)
	`TestCaseStatic(byte, 0, (0))
	`TestCaseStatic(byte, 1, (255))
	`TestCaseStatic(byte, 2, (0, 255))
	`TestCaseStatic(byte, 3, (0, 0))
	`TestCaseStatic(byte, 4, (255, 255))
	`TestCaseStatic(byte, 5, (0, 1, 2))
	`TestCaseStatic(byte, 6, (255, 256, 257))
	`TestCaseStatic(byte, 7, (1, 0, 1))

	`TestRunRegister(int)
	`TestCaseStatic(int, 0, (1,2,3))
	`TestCaseStatic(int, 1, (3,4))
	`TestCaseStatic(int, 2, (0))
	`TestCaseStatic(int, 3, (-1,1))
	`TestCaseStatic(int, 4, (-2147483648,2147483647))
	`TestCaseStatic(int, 5, (0,0))
	`TestCaseStatic(int, 6, (-1,-1))
	`TestCaseStatic(int, 7, (2,-1))

	`TestRunRegister(float)
	`TestCaseStatic(float, 0, (1.f,2,3))
	`TestCaseStatic(float, 1, (3.f,4))
	`TestCaseStatic(float, 2, (0.f))
	`TestCaseStatic(float, 3, (-1.f,1))
	`TestCaseStatic(float, 4, (-2147483648.f,2147483647))
	`TestCaseStatic(float, 5, (0.f,0))
	`TestCaseStatic(float, 6, (-1.f,-1))
	`TestCaseStatic(float, 7, (2.f,-1))
	`TestCaseStatic(float, 8, (10.f,20.f,30.f))
	`TestCaseStatic(float, 9, (30.f,40.f))
	`TestCaseStatic(float, 10, (0.f))
	`TestCaseStatic(float, 11, (-10.f,10.f))
	`TestCaseStatic(float, 12, (0.1234,1.12345,2.123456,3.1234567))
	`TestCaseStatic(float, 13, (3.40298765432109876543210987654321098765432,-3.40298765432109876543210987654321098765432))
	`TestCaseStatic(float, 14, (0.f,0.f))
	`TestCaseStatic(float, 15, (-10.f,-10.f))
	`TestCaseStatic(float, 17, (20.f,-10.f))

	`TestRunRegister(string)
	`TestCaseStatic_MultiText(string, 0, ("",""),1)
	`TestCaseStatic_MultiText(string, 1, ("First","Second"),1)
	`TestCaseStatic_MultiText(string, 2, ("OnlyOne"),1)
	`TestCaseStatic_MultiText(string, 3, ("First_Then_Empty","","Now_Last"),1)
	`TestCaseStatic_MultiText(string, 4, ("","First_was_empty"),1)
	`TestCaseStatic_MultiText(string, 5, ("Last_is_empty","pre_last",""),1)

	`TestRunRegister(name)
	`TestCaseStatic_MultiText(name, 0, (""),1)
	`TestCaseStatic_MultiText(name, 1, ("none"),1)
	`TestCaseStatic_MultiText(name, 2, ("none",""),1)
	`TestCaseStatic_MultiText(name, 3, ("",""),1)
	`TestCaseStatic_MultiText(name, 4, ("none","none"),1)
	`TestCaseStatic_MultiText(name, 5, ("SomeName","AnotherName with Space"),1)
	`TestCaseStatic_MultiText(name, 6, ("Some","","And","","None"),1)

	`TestRunRegister(Object)
	`TestCaseStatic(Object, 0, (MyNoSound))
	`TestCaseStatic(Object, 1, (MyNoSound,none))
	`TestCaseStatic(Object, 2, (Object'Engine.Default__Actor',Object'Engine.Default__Info'))

	`TestRunRegister(Actor)
	`TestCaseStatic(Actor, 0, (Actor'Engine.Default__Actor'))
	`TestCaseStatic(Actor, 1, (Actor'Engine.Default__Info', none))
	`TestCaseStatic(Actor, 2, (Actor'Engine.Default__Note', Actor'Engine.Default__Info',Actor'UTGame.Default__UTPawn'))

	`TestRunRegister(class)
	`TestCaseStatic(class, 0, (class))
	`TestCaseStatic(class, 1, (class'Actor',class'Info',class'Material',class'class'))

	LogToConsole=true
}