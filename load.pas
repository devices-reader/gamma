unit load;
                               
interface

uses
  SysUtils, Graphics, soutput;

procedure InitLoad(stInfo: string; wMax: word; crcT: actions_crc);
procedure IncLoad;
procedure SetLoad(wT: word);
procedure SetLoadInfo(stInfo: string);
procedure CloseLoad;
procedure ShowInfo(stT: string);

implementation

uses main;

var
  Info: string;

{$R *.DFM}

procedure InitLoad(stInfo: string; wMax: word; crcT: actions_crc);
begin
  with frmMain.prbLoad do begin
    Min := 0;
    Max := wMax;
    Position := 0;
    //ShowHint := True;

    Info := stInfo;
    ShowInfo(Info);
  end;

  QueryCRC(crcT);
end;

procedure IncLoad;
begin
  with frmMain.prbLoad do begin
    Position := Position + 1;
    ShowInfo(Info + ': ' + IntToStr(100*Position div Max) + ' %');
  end;
end;

procedure SetLoad(wT: word);
begin
  with frmMain.prbLoad do begin
    Position := wT;
    ShowInfo(Info + ': ' + IntToStr(100*Position div Max) + ' %');
  end;
end;

procedure SetLoadInfo(stInfo: string);
begin
  with frmMain.prbLoad do begin
    Info := stInfo;
    ShowInfo(Info);
  end;
end;

procedure CloseLoad;
begin
end;

procedure ShowInfo(stT: string);
begin
  with frmMain do begin
    //prbLoad.Hint := stT;
    AddTerminal(stT,clGray);
  end;
end;

end.
