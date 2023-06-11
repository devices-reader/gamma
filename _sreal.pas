unit _sreal;

interface

uses main, support;

type
  sreal         = array[0..3] of byte;

  scombo        = record case byte of
    0: (siT:    single);
    1: (mpbT:   array[0..3] of byte);
  end;


function FromSReal(srT: sreal): extended;
function ToSReal(exT: extended): sreal;

implementation

function FromSReal(srT: sreal): extended;
var
  scT:  scombo;
begin
  with scT do begin
    mpbT[0] := srT[3];
    mpbT[1] := srT[2];
    mpbT[2] := srT[1];
    mpbT[3] := srT[0];

    Result := siT;
  end;
end;

function ToSReal(exT: extended): sreal;
var
  scT:  scombo;
begin
  with scT do begin
    siT := exT;

    Result[0] := mpbT[3];
    Result[1] := mpbT[2];
    Result[2] := mpbT[1];
    Result[3] := mpbT[0];
  end;
end;

end.
