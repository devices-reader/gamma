unit yesno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ok, StdCtrls, Buttons, ExtCtrls;

type
  TfrmYesNo = class(TfrmOK)
    btbNo: TBitBtn;
    procedure btbOKClick(Sender: TObject);
    procedure btbNoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmYesNo: TfrmYesNo;

implementation

{$R *.DFM}

procedure TfrmYesNo.btbOKClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrYes;
end;

procedure TfrmYesNo.btbNoClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrNo;
end;

end.
