unit _graphs;

interface

procedure ShowGetGraphInquiry;
procedure ShowSetGraphInquiry;
procedure ShowGetGraphCorrect;
procedure ShowGetGraphRecalc;
procedure ShowGetGraphTransit;

implementation

uses SysUtils, main, soutput, load, support, kernel;

procedure ShowGetGraphInquiry;
var
  x,y:  word;
begin
  InitPopCRC;

  with frmMain,stgGraphInquiry do begin
    for x := 1 to 48 do begin
      y := Pop;
      if y = 0 then
        Cells[iwAlfa+1,x] := GRAPH_MINUS
      else if y = 255 then
        Cells[iwAlfa+1,x] := GRAPH_PLUS
      else
        Cells[iwAlfa+1,x] := '';
    end;
  end;

  IncLoad;
  if iwAlfa < 4-1 then begin
    Inc(iwAlfa);

    InitPushCRC;
    Push(15);
    Push(iwAlfa);
    QueryCRC(acGetGraphInquiry);
  end
  else InfBox('График опроса счетчиков прочитан успешно');
end;

procedure ShowSetGraphInquiry;
var
  x,y:  word;
  s:    string;
begin

  IncLoad;
  if iwAlfa < 4-1 then begin
    Inc(iwAlfa);
    
    InitPushCRC;
    Push(73);
    Push(iwAlfa);

    for y := 1 to 48 do begin
      s := frmMain.stgGraphInquiry.Cells[iwAlfa+1,y];
      if s = GRAPH_PLUS then Push(255)
      else Push(0)
    end;

    QueryCRC(acSetGraphInquiry);    
  end
  else InfBox('График опроса счетчиков записан успешно');
end;

procedure ShowGetGraphCorrect;
var
  x,y:  word;
begin
  InitPopCRC;

  with frmMain,stgGraphCorrect do begin
    for x := 1 to 48 do begin
      y := Pop;
      if y = 0 then
        Cells[1,x] := GRAPH_MINUS
      else if y = 3-1 then
        Cells[1,x] := GRAPH_PORT3
      else if y = 4-1 then
        Cells[1,x] := GRAPH_PORT4
      else
        Cells[1,x] := '';
    end;
  end;

  InfBox('График коррекции времени прочитан успешно');
end;

procedure ShowGetGraphRecalc;
var
  x,y:  word;
begin
  InitPopCRC;

  with frmMain,rgrGraphRecalc do begin
    y := Pop;
//    if y = 0 then ItemIndex := 0;
//    if y = 255 then ItemIndex := 1;
  end;

  with frmMain,stgGraphRecalc do begin
    for x := 1 to 48 do begin
      y := Pop;
      if y = 0 then
        Cells[1,x] := GRAPH_MINUS
      else if y = 255 then
        Cells[1,x] := GRAPH_PLUS
      else
        Cells[1,x] := '';
    end;
  end;

  InfBox('График перерасчета данных прочитан успешно');
end;

procedure ShowGetGraphTransit;
var
  x,y:  word;
begin
  InitPopCRC;

  with frmMain,stgGraphTransit do begin
    for x := 1 to 48 do begin
      y := Pop;
      if y = 3-1 then
        Cells[1,x] := GRAPH_PORT3
      else if y = 4-1 then
        Cells[1,x] := GRAPH_PORT4
      else if y = 0 then
        Cells[1,x] := GRAPH_MINUS
      else
        Cells[1,x] := '';
    end;
  end;

  InfBox('График транзита прочитан успешно');
end;

end.
