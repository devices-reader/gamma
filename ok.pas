unit ok;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, basic;

type
  TfrmOK = class(TfrmBasic)
    panClient: TPanel;
    panBottom: TPanel;
    panRight: TPanel;
    btbOK: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOK: TfrmOK;

implementation

{$R *.DFM}

procedure TfrmOK.FormShow(Sender: TObject);
begin
  inherited;
  btbOK.SetFocus;
end;

end.
