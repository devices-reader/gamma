program gamma;

{%ToDo 'gamma.todo'}

{DelphiDir\Bin\dclsockets700.bpl Install Packages -> Add}

uses
  Forms,
  Windows,
  basic in 'basic.pas' {frmBasic},
  ok in 'ok.pas' {frmOK},
  yesno in 'yesno.pas' {frmYesNo},
  main in 'main.pas' {frmMain},
  support in 'support.pas',
  soutput in 'soutput.pas',
  sinput in 'sinput.pas',
  kernel in 'kernel.pas',
  terminal in 'terminal.pas',
  _float in '_float.pas',
  console in 'console.pas' {frmConsole},
  crc in 'crc.pas',
  _sreal in '_sreal.pas',
  crc_tariffs in 'crc_tariffs.pas',
  _relax in '_relax.pas',
  timez in 'timez.pas',
  _graphs in '_graphs.pas',
  get_records in 'get_records.pas',
  realz in 'realz.pas',
  get_memory0 in 'get_memory0.pas',
  get_memory1 in 'get_memory1.pas',
  load in 'load.pas';

{$R *.RES}

var
  hMutex:       THandle;

begin
  hMutex := CreateMutex(nil, True, 'GammaWriter');
  if GetLastError <> 0 then
  begin
    WrnBox('Программа ''Gamma'' уже запущена !');
    ReleaseMutex(hMutex);
    Exit;
  end;

  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

  ReleaseMutex(hMutex);
  if GetLastError <> 0 then ;
end.
