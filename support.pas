unit support;

interface

uses SysUtils, Forms, Windows, Classes;

function IntToStrX(wT: word; bDigits: byte): string;
function IntToStr2(wT: word): string;
function Str2Float(s: string): extended;

function PackStrR(stT: string; bDigits: byte): string;
function PackStrL(stT: string; bDigits: byte): string;
function UnpackStr(stT: string): string;

function FromBCD(bT: byte): byte;
function ToBCD(bT: byte): byte;

function GetNowStr: string;
function DaysToStr(dwT: longword): string;

procedure ErrBox(stT: string);
procedure WrnBox(stT: string);
procedure InfBox(stT: string);

procedure Delay(MSecs: longint);
function DateTime2Str: string;

function GetColWidth: word;
procedure AddInfo(stT: string);
procedure AddInfoAll(stT: TStrings);

implementation

uses main, soutput, sinput, load;

function IntToStrX(wT: word; bDigits: byte): string;
begin
  Result := IntToStr(wT);
  while Length(Result) < bDigits do Result := '0' + Result;
end;

function IntToStr2(wT: word): string;
begin
  Result := IntToStrX(wT,2);
end;

function Str2Float(s: string): extended;
begin
  if (DecimalSeparator = '.') and (Pos(',', s) > 0)
    then s := StringReplace(s, ',', '.', []);
  if (DecimalSeparator = ',') and (Pos('.', s) > 0)
    then s := StringReplace(s, '.', ',', []);
  Result := StrToFloat(s);
end;

function PackStrR(stT: string; bDigits: byte): string;
begin
  Result := stT;
  while Length(Result) < bDigits do Result := Result + ' ';
end;

function PackStrL(stT: string; bDigits: byte): string;
begin
  Result := stT;
  while Length(Result) < bDigits do Result := ' ' + Result;
end;

function UnpackStr(stT: string): string;
begin
  Result := Trim(stT);
end;

function FromBCD(bT: byte): byte;
begin
  Result := (bT div 16)*10 + (bT mod 16);
end;

function ToBCD(bT: byte): byte;
begin
  Result := (bT div 10)*16 + bT mod 10;
end;

function GetNowStr: string;
begin
  Result := FormatDateTime('hh.mm.ss dd.mm.yyyy',Now);
end;

function DaysToStr(dwT: longword): string;
begin
  if (dwT mod 100 = 0) then Result := ' дней'
  else case (dwT mod 20) of
    1:    Result := ' день';
    2..4: Result := ' дня';
    else  Result := ' дней';
  end;

  Result := IntToStr(dwT) + ' ' + Result;
end;

procedure CloseForms;
begin
  Stop;
  CloseLoad;
end;

procedure ErrBox(stT: string);
begin
  CloseForms;
  Application.MessageBox(PChar(stT + ' '), 'Ошибка', mb_Ok + mb_IconHand);
end;

procedure WrnBox(stT: string);
begin
  CloseForms;
  Application.MessageBox(PChar(stT + ' '), 'Внимание', mb_Ok + mb_IconWarning);
end;

procedure InfBox(stT: string);
begin
  CloseForms;
  Application.MessageBox(PChar(stT + ' '), 'Информация', mb_Ok + mb_IconAsterisk);
end;

procedure Delay(MSecs: longint);
var
  FirstTickCount, Now: Longint;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
    Now := GetTickCount;
  until (Now - FirstTickCount >= MSecs) or (Now < FirstTickCount);
end;

function DateTime2Str: string;
begin
  Result := FormatDateTime('hh.mm.ss dd.mm.yyyy',Now);
end;

function GetColWidth: word;
begin
  Result := 14;
end;

procedure AddInfo(stT: string);
begin
  try
    with frmMain do begin
      redRecords.Lines.Append(stT);
    end;
  except
  end
end;

procedure AddInfoAll(stT: TStrings);
begin
  try
    with frmMain do begin
      redRecords.Lines.AddStrings(stT);
      redRecords.Lines.Append(' ');
      stT.Free;
    end;
  except
  end
end;

end.
