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

{ Match a Specific Input Character }
procedure Match(x: char);
begin
	if Look = x then GetChar
	else Expected('''' + x + '''');
end;

{ Recognize an Alpha Character }
function IsAlpha(c: char): boolean;
begin
	IsAlpha := upcase(c) in ['A'..'Z'];
end;

{ Recognize a Decimal Digit }
function IsDigit(c: char): boolean;
begin
	IsDigit := c in ['0'..'9'];
end;

{ Get an Identifier }
function GetName: char;
begin
	if not IsAlpha(Look) then Expected('Name');
	GetName := UpCase(Look);
	GetChar;
end;

{ Get a Number }
function GetNum: char;
begin
	if not IsDigit(Look) then Expected('Integer');
	GetNum := Look;
	GetChar;
end;

{ Output a String With Tab }
procedure Emit(s: string);
begin
	Write(TAB, s);
end;

{ Output a String with Tab and CTRLF }
procedure EmitLn(s: string);
begin
	Emit(s);
	WriteLn;
end;

{ ------------------- }

{ Parse and Translate a Math Factor }
procedure Factor;
begin
	EmitLn('MOVE #' + GetNum + ',D0')
end;

{ Recognize and Translate a Multiply }
procedure Multiply;
begin
	Match('*');
	Factor;
	EmitLn('MULS (SP)+,D0');
end;

{ Recognize and Translate a Divide }
procedure Divide;
begin
	Match('/');
	Factor;
	EmitLn('MOVE (SP)+,D1');
	EmitLn('DIVS D1,D0');
end;

{ Parse and Translate a Math Term }
procedure Term;
begin
	Factor;
	while Look in ['*', '/'] do begin
		EmitLn('Move D0,-(SP)');
		case Look of
			'*': Multiply;
			'/': Divide;
		else Expected('Mulop');
		end;
	end;
end;

{ Recognize and Translate an Add }
procedure Add;
begin
	Match('+');
	Term;
	EmitLn('ADD (SP)+,D0'); { (SP)+ is pop off the stack in the 68000 processor }
end;

{ Recognize and Translate a Subtract }
procedure Subtract;
begin
	Match('-');
	Term;
	EmitLn('SUB (SP)+,D0'); { (SP)+ is pop off the stack in the 68000 processor }
	EmitLn('NEG D0');
end;

{ Parse and Translate a Math Expression }
procedure Expression;
begin
	Term;
	while Look in ['+', '-'] do begin
		EmitLn('MOVE D0,-(SP)'); { -(SP) is push onto the stack in the 68000 processor}
		case Look of
			'+': Add;
			'-': Subtract;
		else Expected('Addop');
		end;
	end;
end;

{ ------------------- }

{ Initialize }
procedure Init;
begin
	GetChar;
end;

{ Main Program }
begin
	Init;
	Expression;
end.
