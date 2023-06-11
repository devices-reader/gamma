unit console;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  basic, StdCtrls, ComCtrls, Buttons, ExtCtrls;

type
  TfrmConsole = class(TfrmBasic)
    memDisplay: TMemo;
    btbGetDisplay: TBitBtn;
    btbKey1: TBitBtn;
    btbKey2: TBitBtn;
    btbKey3: TBitBtn;
    btbKey4: TBitBtn;
    btbKey5: TBitBtn;
    btbKey6: TBitBtn;
    btbKey7: TBitBtn;
    btbkey8: TBitBtn;
    btbKey9: TBitBtn;
    btbKeyMinus: TBitBtn;
    btbKey0: TBitBtn;
    btbKeyPoint: TBitBtn;
    btbKeyProgram: TBitBtn;
    btbKeyEnter: TBitBtn;
    edtConsole: TEdit;
    updConsole: TUpDown;
    timConsole: TTimer;
    chbConsole: TCheckBox;
    cmbSystem: TComboBox;
    lblSystem: TLabel;
    stbConsole: TStatusBar;
    procedure ClearDisplay;
    procedure ShowStatus;
    procedure UpdateStatus(e: byte);
    procedure btbKey1Click(Sender: TObject);
    procedure btbKey2Click(Sender: TObject);
    procedure btbKey3Click(Sender: TObject);
    procedure btbKey4Click(Sender: TObject);
    procedure btbKey5Click(Sender: TObject);
    procedure btbKey6Click(Sender: TObject);
    procedure btbKey7Click(Sender: TObject);
    procedure btbkey8Click(Sender: TObject);
    procedure btbKey9Click(Sender: TObject);
    procedure btbKey0Click(Sender: TObject);
    procedure btbKeyMinusClick(Sender: TObject);
    procedure btbKeyPointClick(Sender: TObject);
    procedure btbKeyProgramClick(Sender: TObject);
    procedure btbKeyEnterClick(Sender: TObject);
    procedure btbGetDisplayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StartTimer(bMul: byte);
    procedure timConsoleTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsole: TfrmConsole;
  cwEvent: array[0..3] of word;

implementation

uses soutput;

{$R *.DFM}

procedure TfrmConsole.ClearDisplay;
var
  e: byte;
begin
  memDisplay.Lines.Clear;
  for e := 0 to 3 do begin
    cwEvent[e] := 0;
  end;
end;

procedure TfrmConsole.ShowStatus;
var
  e: byte;
begin
  with stbConsole do begin
    if cwEvent[0] = 0 then Panels[0].Text := '' else Panels[0].Text := '+' + IntToStr(cwEvent[0]);
    for e := 1 to 3 do begin
      if cwEvent[e] = 0 then Panels[e].Text := '' else Panels[e].Text := '-' + IntToStr(cwEvent[e]);
    end;
    Hint :=
      'Количество успешных ответов: '         + IntToStr(cwEvent[0]) + #13#10 +
      'Количество отсутствия ответов: '       + IntToStr(cwEvent[1]) + #13#10 +
      'Количество ошибок контрольной суммы: ' + IntToStr(cwEvent[2]) + #13#10 +
      'Количество ошибок длины: '             + IntToStr(cwEvent[3]);
  end;
end;

procedure TfrmConsole.UpdateStatus(e: byte);
begin
  Inc(cwEvent[e]);
  ShowStatus();
end;

procedure TfrmConsole.btbKey1Click(Sender: TObject);
begin
  inherited;
  StartTimer(3);

  if cmbSystem.ItemIndex = 0 then
    EscSearch(actEsc1)
  else begin
    InitPushCRC;
    Push(1);
    QueryCRC(crcSetKey);
  end;
end;

procedure TfrmConsole.btbKey2Click(Sender: TObject);
begin
  inherited;
  StartTimer(3);

  if cmbSystem.ItemIndex = 0 then
    EscSearch(actEsc2)
  else begin
    InitPushCRC;
    Push(2);
    QueryCRC(crcSetKey);
  end;
end;

procedure TfrmConsole.btbKey3Click(Sender: TObject);
begin
  inherited;
  StartTimer(3);

  if cmbSystem.ItemIndex = 0 then
    EscSearch(actEsc3)
  else begin
    InitPushCRC;
    Push(3);
    QueryCRC(crcSetKey);
  end;
end;

procedure TfrmConsole.btbKey4Click(Sender: TObject);
begin
  inherited;
  StartTimer(3);

  if cmbSystem.ItemIndex = 0 then
    EscSearch(actEsc4)
  else begin
    InitPushCRC;
    Push(4);
    QueryCRC(crcSetKey);
  end;
end;

procedure TfrmConsole.btbKey5Click(Sender: TObject);
begin
  inherited;
  StartTimer(3);

  if cmbSystem.ItemIndex = 0 then
    EscSearch(actEsc5)
  else begin
    InitPushCRC;
    Push(5);
    QueryCRC(crcSetKey);
  end;
end;

procedure TfrmConsole.btbKey6Click(Sender: TObject);
begin
  inherited;
  StartTimer(3);

  if cmbSystem.ItemIndex = 0 then
    EscSearch(actEsc6)
  else begin
    InitPushCRC;
    Push(6);
    QueryCRC(crcSetKey);
  end;
end;

procedure TfrmConsole.btbKey7Click(Sender: TObject);
begin
  inherited;
  StartTimer(3);

  if cmbSystem.ItemIndex = 0 then
    EscSearch(actEsc7)
  else begin
    InitPushCRC;
    Push(7);
    QueryCRC(crcSetKey);
  end;
end;

procedure TfrmConsole.btbkey8Click(Sender: TObject);
begin
  inherited;
  StartTimer(3);

  if cmbSystem.ItemIndex = 0 then
    EscSearch(actEsc8)
  else begin
    InitPushCRC;
    Push(8);
    QueryCRC(crcSetKey);
  end;
end;

procedure TfrmConsole.btbKey9Click(Sender: TObject);
begin
  inherited;
  StartTimer(3);

  if cmbSystem.ItemIndex = 0 then
    EscSearch(actEsc9)
  else begin
    InitPushCRC;
    Push(9);
    QueryCRC(crcSetKey);
  end;
end;

procedure TfrmConsole.btbKey0Click(Sender: TObject);
begin
  inherited;
  StartTimer(3);

  if cmbSystem.ItemIndex = 0 then
    EscSearch(actEsc0)
  else begin
    InitPushCRC;
    Push(0);
    QueryCRC(crcSetKey);
  end;
end;

procedure TfrmConsole.btbKeyMinusClick(Sender: TObject);
begin
  inherited;
  StartTimer(3);

  if cmbSystem.ItemIndex = 0 then
    EscSearch(actEscMinus)
  else begin
    InitPushCRC;
    Push(10);
    QueryCRC(crcSetKey);
  end;
end;

procedure TfrmConsole.btbKeyPointClick(Sender: TObject);
begin
  inherited;
  StartTimer(3);

  if cmbSystem.ItemIndex = 0 then
    EscSearch(actEscPoint)
  else begin
    InitPushCRC;
    Push(11);
    QueryCRC(crcSetKey);
  end;
end;

procedure TfrmConsole.btbKeyProgramClick(Sender: TObject);
begin
  inherited;
  StartTimer(3);

  if cmbSystem.ItemIndex = 0 then
    EscSearch(actEscProgram)
  else begin
    InitPushCRC;
    Push(12);
    QueryCRC(crcSetKey);
  end;
end;

procedure TfrmConsole.btbKeyEnterClick(Sender: TObject);
begin
  inherited;
  StartTimer(3);

  if cmbSystem.ItemIndex = 0 then
    EscSearch(actEscEnter)
  else begin
    InitPushCRC;
    Push(13);
    QueryCRC(crcSetKey);
  end;
end;

procedure TfrmConsole.btbGetDisplayClick(Sender: TObject);
begin
  inherited;
  StartTimer(3);

  if cmbSystem.ItemIndex = 0 then
    EscSearch(actEscDisplay)
  else
    QueryCRC(crcGetDisplay);
end;

procedure TfrmConsole.FormShow(Sender: TObject);
begin
  inherited;
  ClearDisplay;
end;

procedure TfrmConsole.StartTimer(bMul: byte);
begin
  if chbConsole.Checked then with timConsole do begin
    Interval := updConsole.Position * bMul;
    Enabled  := True;
  end;
end;

procedure TfrmConsole.timConsoleTimer(Sender: TObject);
begin
  inherited;
  timConsole.Enabled := False;
  if chbConsole.Checked then btbGetDisplayClick(nil);
end;

procedure TfrmConsole.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  timConsole.Enabled := False;
end;

end.
