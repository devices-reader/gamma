unit _float;

interface

type sfloat = array[0..3] of byte;

function ToFloat(sflImage: sfloat): extended;

implementation

function ToFloat(sflImage: sfloat): extended;
var
  eAdd:         extended;
  dMask,
  dArgument:    cardinal;
  i,bT:         byte;
  fSign:        boolean;
  wOrder:       integer;                        { необходи знак !!! }
begin
    Result  := 0;
    dMask   := $00200000;
    eAdd    := 0.5;

{1} wOrder := sflImage[0];                      { порядок }
    if (wOrder and $80 = $80) then
      wOrder := -(wOrder and $7F);              { отрицательный порядок }

{2} bT := sflImage[1];
    if (bT and $80 = 0 ) then fSign := True     {+}
    else fSign := False;                        {-}

    bT := bT and $7F;                           {сохраняем знак}
    dArgument := bT*$10000;

{3} bT := sflImage[2]; dArgument := dArgument + bT*$100;
{4} bT := sflImage[3]; dArgument := dArgument + bT;

    for i := 1 to 22 do begin                   { по битам }
      if  (dArgument and dMask <> 0) then Result := Result + eAdd;
      eAdd  := eAdd/2;
      dMask := dMask shr 1;
    end;

    Result := Result*Exp(Ln(2)*wOrder);
    if fSign = False then Result := -Result;
end;

end.
