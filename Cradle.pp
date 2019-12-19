program Cradle;

{ Constant Declarations }
const TAB = ^I;

{ Variable Declarations }
var Look: char; { Lookahead character }

{ Get new Char from the input stream }
procedure GetChar;
begin
	Read(Look);
end;

{ Report an Error }
procedure Error(s: String);
begin
	WriteLn;
	WriteLn(^G, 'Error: ', s, '.');
end;

{ Report an Error and Halt }
procedure Abort(s: String);
begin
	Error(s);
	Halt;
end;

{ Report What was Expected }
procedure Expected(s: String);
begin
	Abort(s + ' Expected');
end;

begin
	GetChar;
end.
