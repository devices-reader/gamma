unit realz;

interface

type
  reals = array[0..3] of byte;

  combo = record case byte of
    0: (siT:  single);
    1: (mpbT: reals);
  end;

function FromReals(reT: reals): extended;
function ToReals(exT: extended): reals;
function PopReals: extended;
//function Reals2Str(e: extended): string;
//function Reals2StrR(e: extended): string;
//function Reals2StrL(e: extended): string;

implementation

uses SysUtils, main, support, soutput;

function FromReals(reT: reals): extended;
var
  coT:  combo;
begin
  with coT do begin
    mpbT[0] := reT[3];
    mpbT[1] := reT[2];
    mpbT[2] := reT[1];
    mpbT[3] := reT[0];

    Result := siT;
  end;
end;

function ToReals(exT: extended): reals;
var
  coT:  combo;
begin
  with coT do begin
    siT := exT;

    Result[0] := mpbT[3];
    Result[1] := mpbT[2];
    Result[2] := mpbT[1];
    Result[3] := mpbT[0];
  end;
end;

function PopReals: extended;
var
  reT:  reals;
begin
  reT[0] := Pop;
  reT[1] := Pop;
  reT[2] := Pop;
  reT[3] := Pop;
  Result := FromReals(reT);
end;
{
function Reals2Str(e: extended): string;
begin
  with frmMain do
    Result := FloatToStrF(e,ffFixed,8,updDigits.Position);
end;

function Reals2StrR(e: extended): string;
begin
  Result := PackStrR(Reals2Str(e),GetColWidth);
end;

function Reals2StrL(e: extended): string;
begin
  Result := PackStrL(Reals2Str(e),GetColWidth);
end;
}
end.
