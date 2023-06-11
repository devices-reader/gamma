unit soutput;

interface

uses SysUtils, Classes, Graphics, StdCtrls, Windows, IdGlobal;

type

  system = (system_esc, system_crc);
  
  actions_crc =
  (
    crcNone,

    crcGetPublic,
    crcSetPublic,

    acSetOldPowTariff,
    acSetAllOldPowTariffs,
    crcGetOldPowTariff,

    acSetOldEngTariff,
    acSetAllOldEngTariffs,
    crcGetOldEngTariff,

    acSetOldPubTariff,
    acSetAllOldPubTariffs,
    crcGetOldPubTariff,

    acGetTransEng,
    acSetTransEng,
    //acGetTransCnt,
    acSetTransCnt,

    acGetPulseHou,
    acSetPulseHou,
    acGetPulseMnt,
    acSetPulseMnt,

    acGetLosse,
    acSetLosse,
    acGetCount,
    acSetCount,
    acGetLevel,
    acSetLevel,

    acGetDigit,
    acSetDigit,

    acGetGroups,
    acSetGroups,

    acGetPhones,
    acSetPhones,
    acGetAddresses,
    acSetAddresses,
    acGetAddresses2,
    acSetAddresses2,

    acGetRelaxs,
    acSetRelaxs,

    acGetRecords,

    crcGetSimpleEscS,
    crcGetSimpleEscU,
    crcGetSimpleEscV,

    acGetDivid,
    acSetDivid,
    acGetParam,
    acSetParam,
    acResetDivid,

    crcSetKey,
    crcGetDisplay,

    crcGetTime,
    crcSetTime1,
    crcSetTime2,

    acGetGraphInquiry,
    acGetGraphCorrect,
    acGetGraphRecalc,
    acGetGraphTransit,
    acSetGraphInquiry,
    acSetGraphCorrect,
    acSetGraphRecalc,
    acSetGraphTransit,

    acGetObjectName,
    acSetObjectName,
    acGetCanalsNames,
    acSetCanalsNames,
    acGetGroupsNames,
    acSetGroupsNames,

    acGetMemory0,
    acGetMemory1
  );

  actions =
  (
    actNone,
    actCtrlZ,

    actEscA,
    actEscR,
    actEscU,
    actEscS,
    actEscV,
    actEscS_time,
    actEscV_time,
    actEscl_lo,
    actEscv_lo,
    actEscDef768,
    actEscDef96,
    actEscDef16,
    actEscL_hi,
    actEscUSD,

    actEsc0,
    actEsc1,
    actEsc2,
    actEsc3,
    actEsc4,
    actEsc5,
    actEsc6,
    actEsc7,
    actEsc8,
    actEsc9,
    actEscMinus,
    actEscPoint,
    actEscProgram,
    actEscEnter,
    actEscDisplay,

    actEscGPS,
    actEscDigital,
    actEscProfile,

    actEscLogical,
    actEscPrivate,

    actRunFlow,
    actTestFlow,
    actExitFlow
  );

  querys = record
    actAction:  actions;
    chEsc:      char;
    cwIn:       word;
    stName:     string;
  end;

  querys_crc = record
    actAction1:   actions_crc;
    cwOut:      word;
    cwIn:       word;
    bNumber:    byte;
    stName:     string;
    fConsole:   boolean;
  end;

{}procedure Stop;
procedure SetSystem(syT: system);

{}procedure LoadCmbQuerysEsc(Strings: TStrings);
{}procedure LoadCmbQuerysExt(Strings: TStrings);

{}procedure CtrlZ;
{}procedure OutStr(stT: string; actT: actions);
{}procedure EscSearch(actT: actions);
{}procedure Esc(i: word);
{}procedure Ext(i: word);

{}procedure QueryCRC(actT: actions_crc);

{}procedure InitPushZero;
{}procedure InitPushCRC;
{}procedure Push(bT: byte);
{}procedure PushInt(wT: word);
{}procedure PushLong(dwT: longword);
{}procedure PushStr(stT: string);

{}procedure InitPopZero;
{}procedure InitPopCRC;
{}procedure InitPop(wT: word);
{}function  Pop: byte;
{}function  PopInt: word;
{}function  PopIntBCD: word;
{}function  PopLong: longword;
{}function  PopLongBCD: longword;

{}procedure InitQuerysCRC;

var
  queQueryEsc:          querys;
  queQueryCRC:          querys_crc;

  system1:              system;

implementation

uses main, support, sinput, terminal, crc, kernel, console;

const

  stHEADER:               AnsiString = 'Калюмны ';
  bPACKET_HEADER:         byte = 8;
  bPACKET_BODY:           byte = 32;
  bPACKET_EMPTY:          byte = 0;

  bZONE                   = 19;

  bQUERYS_CRC             = 63;
  bQUERYS_EXT             = 3;

  bQUERYS_ESC             = 37;
  mpQuerysEsc:  array[0..bQUERYS_ESC-1] of querys =
  (
    (actAction: actEscA;      chEsc: 'A';  cwIn: 0;         stName: 'Esc A: звуковой сигнал'),
    (actAction: actEscR;      chEsc: 'R';  cwIn: 21+1;      stName: 'Esc R: версия сумматора'),
    (actAction: actEscU;      chEsc: 'U';  cwIn: 16*6*2+1;  stName: 'Esc U: Т счётчика и Т сумматора соответственно'),
    (actAction: actEscS;      chEsc: 'S';  cwIn: 16*4+1;    stName: 'Esc S: текущие показания счётчиков'),
    (actAction: actEscV;      chEsc: 'V';  cwIn: 16*4+1;    stName: 'Esc V: показания счётчиков по месяцам'),
    (actAction: actEscS_time; chEsc: '{';  cwIn: 16*6+1;    stName: 'Esc {: время обновления Esc S'),
    (actAction: actEscV_time; chEsc: '}';  cwIn: 16*6+1;    stName: 'Esc }: время обновления Esc V'),
    (actAction: actEscl_lo;   chEsc: 'l';  cwIn: 2+1;       stName: 'Esc l: переход на следующие сутки'),
    (actAction: actEscv_lo;   chEsc: 'v';  cwIn: 2+1;       stName: 'Esc v: переход на следующий месяц'),

    (actAction: actEscDef768; chEsc: '^';  cwIn: 768+1;     stName: 'Esc ^: брак связи по каналам/получасам побайтно'),
    (actAction: actEscDef96;  chEsc: '[';  cwIn: 96+1;      stName: 'Esc [: брак связи по каналам/получасам побитно'),
    (actAction: actEscDef16;  chEsc: ']';  cwIn: 16+1;      stName: 'Esc ]: брак связи по суткам/получасам побайтно'),

    (actAction: actEscL_hi;   chEsc: 'L';  cwIn: 48*16*2+1; stName: 'Esc L: импульсы по каналам'),
    (actAction: actEscUSD;    chEsc: '$';  cwIn: 48*6*4+1;  stName: 'Esc $: энергия по группам'),

    (actAction: actEsc0;      chEsc: 'а';  cwIn: 32+6+1;    stName: 'Esc а: кнопка 0'),
    (actAction: actEsc1;      chEsc: 'б';  cwIn: 32+6+1;    stName: 'Esc б: кнопка 1'),
    (actAction: actEsc2;      chEsc: 'в';  cwIn: 32+6+1;    stName: 'Esc в: кнопка 2'),
    (actAction: actEsc3;      chEsc: 'г';  cwIn: 32+6+1;    stName: 'Esc г: кнопка 3'),
    (actAction: actEsc4;      chEsc: 'д';  cwIn: 32+6+1;    stName: 'Esc д: кнопка 4'),
    (actAction: actEsc5;      chEsc: 'е';  cwIn: 32+6+1;    stName: 'Esc е: кнопка 5'),
    (actAction: actEsc6;      chEsc: 'ж';  cwIn: 32+6+1;    stName: 'Esc ж: кнопка 6'),
    (actAction: actEsc7;      chEsc: 'з';  cwIn: 32+6+1;    stName: 'Esc з: кнопка 7'),
    (actAction: actEsc8;      chEsc: 'и';  cwIn: 32+6+1;    stName: 'Esc и: кнопка 8'),
    (actAction: actEsc9;      chEsc: 'й';  cwIn: 32+6+1;    stName: 'Esc й: кнопка 9'),
    (actAction: actEscMinus;  chEsc: 'к';  cwIn: 32+6+1;    stName: 'Esc к: кнопка -'),
    (actAction: actEscPoint;  chEsc: 'л';  cwIn: 32+6+1;    stName: 'Esc л: кнопка .'),
    (actAction: actEscProgram;chEsc: 'м';  cwIn: 32+6+1;    stName: 'Esc м: кнопка P'),
    (actAction: actEscEnter;  chEsc: 'н';  cwIn: 32+6+1;    stName: 'Esc н: кнопка Ввод'),
    (actAction: actEscDisplay;chEsc: 'о';  cwIn: 32+6+1;    stName: 'Esc о: дисплей'),

    (actAction: actEscGPS;    chEsc: 'Щ';  cwIn: 347+1;     stName: 'Esc Щ: статистика коррекции времени'),

    (actAction: actEscDigital;chEsc: 'Ъ'; cwIn: 64*15+1;    stName: 'Esc Ъ: статистика счётчиков'),
    (actAction: actEscProfile;chEsc: 'Ь';  cwIn: 64*8+1;    stName: 'Esc Ь: статистика профилей'),

    (actAction: actEscLogical;chEsc: 'Ю';  cwIn: 5+1;       stName: 'Esc Ю: CRC программы, заводской и логический номер'),
    (actAction: actEscPrivate;chEsc: 'Я';  cwIn: 2+1;       stName: 'Esc Я: заводской номер'),

    (actAction: actRunFlow;   chEsc: #$1F; cwIn: 15+1;      stName: 'Esc #$1F: включение транзита'),
    (actAction: actTestFlow;  chEsc: ' ';  cwIn: 19;        stName: 'проверка транзита: Is transit ?'),
    (actAction: actExitFlow;  chEsc: ' ';  cwIn: 23;        stName: 'выход из транзита: Close transit')
  );

var
  mpQuerysCRC:  array[0..bQUERYS_CRC-1] of querys_crc;
  mpQuerysExt:  array[0..bQUERYS_EXT-1] of querys_crc;

{}procedure Stop;
begin
  frmMain.timTimeout.Enabled := False;
  if Assigned(frmConsole) then frmConsole.timConsole.Enabled := False;

  queQueryEsc.actAction := actNone;
  queQueryEsc.cwIn := 0;

  queQueryCRC.actAction1 := crcNone;
  queQueryCRC.cwIn := 0;
end;

procedure SetSystem(syT: system);
begin
  system1 := syT;

  with frmMain,stbMain.Panels[panSYSTEM] do begin
    if system1 = system_esc then Text := ' Esc-система' else Text := ' CRC-система';
  end;
end;

{}procedure LoadCmbQuerysEsc(Strings: TStrings);
var
  i:    word;
begin
  with Strings do begin
    Clear;
    for i := 0 to bQUERYS_ESC-1 do Append(' ' + mpQuerysEsc[i].stName);
  end;
end;

{}procedure LoadCmbQuerysExt(Strings: TStrings);
var
  i:    word;
begin
  with Strings do begin
    Clear;
    for i := 0 to bQUERYS_EXT-1 do Append(' ' + mpQuerysExt[i].stName);
  end;
end;

{}procedure OutData(cwSize: word; stName: string);
begin
  try with frmMain do begin
      with timTimeout do begin
        Enabled := False;
        Interval := GetTimeout;
        Enabled := True;
      end;

      if (pgcMode.ActivePage = tbsPort) or (pgcMode.ActivePage = tbsModem) then begin
        //ComPort.FlushInBuffer;
        //ComPort.FlushOutBuffer;
        ComPort.PutBlock(mpbOut, cwSize);
      end
      else begin
//        IdTCPClient.WriteBuffer(mpbOut, cwSize);
        IdTCPClient.IOHandler.Write(IdGlobal.RawToBytes(mpbOut, cwSize));
      end;

      AddTerminal('',clGray);
      ShowOutData(cwSize);
//      AddTerminal('// '+GetNowStr,clGray);
    end;
  except
    ErrBox('Ошибка при передаче запроса !');
  end;
end;

{}procedure CtrlZ;
begin
  InitPushZero;
  Push($1A);

  queQueryEsc.actAction := actCtrlZ;
  queQueryEsc.cwIn := 0;

  SetSystem(system_esc);

  OutData(1,'Ctrl Z');
end;

{}procedure OutStr(stT: string; actT: actions);
var
  i:    word;
begin
  i := 0;
  while i < bQUERYS_ESC do begin
    if mpQuerysEsc[i].actAction = actT then break;
    Inc(i);
  end;

  if i = bQUERYS_ESC then
    ErrBox('Фатальная ошибка: неизвестный запрос !')
  else begin
    InitPushZero;
    PushStr(stT);

    queQueryEsc.actAction := actT;
    queQueryEsc.cwIn := mpQuerysEsc[i].cwIn;

    SetSystem(system_esc);

    OutData(Length(stT),mpQuerysEsc[i].stName);
  end;
end;

{}procedure EscSearch(actT: actions);
var
  i:    word;
begin
  i := 0;
  while i < bQUERYS_ESC do begin
    if mpQuerysEsc[i].actAction = actT then break;
    Inc(i);
  end;

  if i = bQUERYS_ESC then
    ErrBox('Фатальная ошибка: неизвестный запрос !')
  else
    Esc(i);
end;

{}procedure Esc(i: word);
begin
  queQueryEsc := mpQuerysEsc[i];

  InitPushZero;
  Push($1B);
  Push(Ord(queQueryEsc.chEsc));

  SetSystem(system_esc);

  OutData(2,queQueryEsc.stName);
end;

{}procedure OutCharPause(chT: AnsiChar; Pause: boolean);
begin
  with frmMain do begin

    if (pgcMode.ActivePage = tbsPort) or (pgcMode.ActivePage = tbsModem) then begin
      ComPort.PutChar(AnsiChar(chT));
    end
    else begin
//      IdTCPClient.Write(chT);
      IdTCPClient.IOHandler.Write(Ord(chT));
    end;

    InsByte(Ord(chT),clRed);

    if Pause then Delay(100);
  end;
end;

{}procedure CRC_1(i: word);
var
  j:  word;
  cwSize:       word;
begin
  try
    with frmMain do begin
      queQueryCRC := mpQuerysCRC[i];
      cwSize := mpQuerysCRC[i].cwOut;

      InitPushZero;
      Push(updAddress.Position);
      Push(0);

      Push(cwSize mod $100);
      Push(cwSize div $100);

      Push(mpQuerysCRC[i].bNumber);

      j := CRC16(mpbOut, cwSize-2);
      mpbOut[cwSize-2] := j div $100;
      mpbOut[cwSize-1] := j mod $100;

      with timTimeout do begin
        Enabled := False;
        Interval := GetTimeout;
        Enabled := True;
      end;

      SetSystem(system_crc);

      if rgrPacket.ItemIndex = 1 then begin
        AddTerminal('', clGray);
        for j := 1 to bPACKET_HEADER do OutCharPause(stHEADER[j],false);
      end;

      if rgrPacket.ItemIndex = 2 then begin
        ShowOutData(queQueryCRC.cwOut);
        for j := 1 to queQueryCRC.cwOut do
          mpbOut[6+queQueryCRC.cwOut-j] := mpbOut[queQueryCRC.cwOut-j];

        mpbOut[0] := $55;
        mpbOut[1] := updAddress.Position;

        mpbOut[2] := (queQueryCRC.cwOut+10) div $100;
        mpbOut[3] := (queQueryCRC.cwOut+10) mod $100;

        mpbOut[4] := $FFF0 div $100;
        mpbOut[5] := $FFF0 mod $100;

        mpbOut[queQueryCRC.cwOut+6] := $21;
        mpbOut[queQueryCRC.cwOut+7] := $B3;

        i := CRC16(mpbOut, queQueryCRC.cwOut+8);
        mpbOut[queQueryCRC.cwOut+8] := i div $100;
        mpbOut[queQueryCRC.cwOut+9] := i mod $100;

        queQueryCRC.cwOut := queQueryCRC.cwOut+10;
        cwSize := queQueryCRC.cwOut;
      end;

      if (pgcMode.ActivePage = tbsPort) or (pgcMode.ActivePage = tbsModem) then begin
        //ComPort.FlushInBuffer;
        //ComPort.FlushOutBuffer;
        ComPort.PutBlock(mpbOut, cwSize);
      end
      else begin
//        IdTCPClient.WriteBuffer(mpbOut, cwSize);
        IdTCPClient.IOHandler.Write(IdGlobal.RawToBytes(mpbOut, cwSize));
      end;

      ShowOutData(cwSize);
    end;
  except
    ErrBox('Ошибка при передаче запроса !');
  end;
end;

{}procedure Ext(i: word);
begin
end;

{}procedure QueryCRC(actT: actions_crc);
var
  i:  word;
begin
  i := 0;
  while i < bQUERYS_CRC do begin
    if mpQuerysCRC[i].actAction1 = actT then break;
    Inc(i);
  end;

  if i = bQUERYS_CRC then
    ErrBox('Фатальная ошибка: неизвестный запрос !')
  else
    CRC_1(i);
end;

{}procedure InitPushZero;
begin
  iwOut := 0;
end;

{}procedure InitPushCRC;
begin
  iwOut := 5;
end;

{}procedure Push(bT: byte);
begin
  mpbOut[iwOut] := bT;
  Inc(iwOut);
end;

{}procedure PushInt(wT: word);
begin
  Push( wT div $100 );
  Push( wT mod $100 );
end;

{}procedure PushLong(dwT: longword);
begin
  PushInt( dwT div $10000 );
  PushInt( dwT mod $10000 );
end;

{}procedure PushStr(stT: string);
var
  i:    word;
begin
  for i := 1 to Length(stT) do Push(Ord(stT[i]));
end;

{}procedure InitPopZero;
begin
  iwIn := 0;
end;

{}procedure InitPopCRC;
begin
  iwIn := 5;
end;

{}procedure InitPop(wT: word);
begin
  iwIn := wT;
end;

{}function Pop: byte;
begin
  Result := mpbIn[iwIn];
  Inc(iwIn);
end;

{}function PopInt: word;
begin
  Result := Pop*$100 + Pop;
end;

{}function PopIntBCD: word;
begin
  Result := FromBCD(Pop)*$100 + FromBCD(Pop);
end;

{}function PopLong: longword;
begin
  Result := Pop*$1000000 +
            Pop*$10000 +
            Pop*$100 +
            Pop;
end;

{}function PopLongBCD: longword;
begin
  Result := FromBCD(Pop)*1000000 +
            FromBCD(Pop)*10000 +
            FromBCD(Pop)*100 +
            FromBCD(Pop);
end;

{}procedure InitQuerysCRC;
var
  i:  word;
begin
  for i := 0 to bQUERYS_CRC-1 do
    mpQuerysCRC[i].actAction1 := crcNone;

  i := 0;

  with mpQuerysCRC[i] do begin actAction1 := crcGetPublic;           cwOut := 1+6;       cwIn := 5+2+2;     bNumber := 14;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := crcSetPublic;           cwOut := 1+1+6;     cwIn := 5+1+2;     bNumber := 15;    stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := crcGetOldPowTariff;     cwOut := 3+6;       cwIn := 5+bZONE+2; bNumber := 18;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetOldPowTariff;     cwOut := 3+bZONE+6; cwIn := 5+2+2;      bNumber := 19;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetAllOldPowTariffs; cwOut := 3+bZONE+6; cwIn := 5+2+2;      bNumber := 19;    stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := crcGetOldEngTariff;     cwOut := 3+6;       cwIn := 5+bZONE+2; bNumber := 20;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetOldEngTariff;     cwOut := 3+bZONE+6; cwIn := 5+2+2;      bNumber := 21;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetAllOldEngTariffs; cwOut := 3+bZONE+6; cwIn := 5+2+2;      bNumber := 21;    stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := crcGetOldPubTariff;     cwOut := 3+6;       cwIn := 5+bZONE+2; bNumber := 22;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetOldPubTariff;     cwOut := 3+bZONE+6; cwIn := 5+2+2;      bNumber := 23;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetAllOldPubTariffs; cwOut := 3+bZONE+6; cwIn := 5+2+2;      bNumber := 23;    stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := acGetTransEng;         cwOut := 1+6;               cwIn := 5+bREAL*bCANALS+2;  bNumber := 30;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetTransEng;         cwOut := 1+bREAL*bCANALS+6; cwIn := 5+2+2;              bNumber := 31;    stName := ''; Inc(i); end;
  //with mpQuerysCRC[i] do begin actAction1 := acGetTransCnt;         cwOut := 1+6;               cwIn := 5+bREAL*bCANALS+2;  bNumber := 32;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetTransCnt;         cwOut := 1+bREAL*bCANALS+6; cwIn := 5+2+2;              bNumber := 33;    stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := acGetPulseHou;          cwOut := 1+6;              cwIn := 5+bREAL*bCANALS+2;  bNumber := 34;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetPulseHou;         cwOut := 1+bREAL*bCANALS+6; cwIn := 5+2+2;              bNumber := 35;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acGetPulseMnt;         cwOut := 1+6;               cwIn := 5+bREAL*bCANALS+2;  bNumber := 234;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetPulseMnt;         cwOut := 1+bREAL*bCANALS+6; cwIn := 5+2+2;              bNumber := 235;    stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := acGetCount;            cwOut := 1+6;               cwIn := 5+bREAL*bCANALS+2;  bNumber := 38;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetCount;            cwOut := 1+bREAL*bCANALS+6; cwIn := 5+2+2;              bNumber := 39;    stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := acGetLosse;            cwOut := 1+6;               cwIn := 5+bREAL*bCANALS+2;  bNumber := 40;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetLosse;            cwOut := 1+bREAL*bCANALS+6; cwIn := 5+2+2;              bNumber := 41;    stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := acGetLevel;            cwOut := 1+6;               cwIn := 5+bREAL*bCANALS+2;  bNumber := 180;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetLevel;            cwOut := 1+bREAL*bCANALS+6; cwIn := 5+2+2;              bNumber := 181;   stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := acGetDigit;            cwOut := 1+1+6;             cwIn := 5+5+2;              bNumber := 42;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetDigit;            cwOut := 1+6+6;             cwIn := 5+2+2;              bNumber := 43;    stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := acGetGroups;           cwOut := 1+1+6;             cwIn := 5+1+bCANALS+2;      bNumber := 9;     stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetGroups;           cwOut := 1+2+bCANALS+6;     cwIn := 5+2+2;              bNumber := 10;    stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := acGetPhones;           cwOut := 1+1+1+6;           cwIn := 5+NUMBERS+2;        bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetPhones;           cwOut := 1+1+1+NUMBERS+6;   cwIn := 5+2+2;              bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acGetAddresses;        cwOut := 1+1+1+6;           cwIn := 5+8+2;              bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetAddresses;        cwOut := 1+1+1+8+6;         cwIn := 5+2+2;              bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acGetAddresses2;       cwOut := 1+1+1+6;           cwIn := 5+4+NUMBERS+2;        bNumber := 253;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetAddresses2;       cwOut := 1+1+1+4+NUMBERS+6; cwIn := 5+2+2;              bNumber := 253;   stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := acGetRelaxs;           cwOut := 2+6;               cwIn := 5+2+241+2;          bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetRelaxs;           cwOut := 2+241+6;           cwIn := 5+2+2;              bNumber := 255;   stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := acGetRecords;          cwOut := 1+1+2+6;         cwIn := 5+6+wFREEPAGE_SIZE+2; bNumber := 255;   stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := acGetDivid;            cwOut := 1+2+6;             cwIn := 5+bREAL+2;          bNumber := 46;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetDivid;            cwOut := 1+2+bREAL+6;       cwIn := 5+2+2;              bNumber := 47;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acGetParam;            cwOut := 1+2+6;             cwIn := 5+5+2;              bNumber := 44;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetParam;            cwOut := 1+7+6;             cwIn := 5+2+2;              bNumber := 45;    stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acResetDivid;          cwOut := 1+6;               cwIn := 5+1+2;              bNumber := 51;    stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := crcSetKey;             cwOut := 1+1+6;             cwIn := 5+2+2;              bNumber := 246;   stName := ''; fConsole := true; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := crcGetDisplay;         cwOut := 1+6;               cwIn := 5+32+2;             bNumber := 247;   stName := ''; fConsole := true; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := crcGetTime;            cwOut := 7;                 cwIn := 5+6+2;              bNumber := 1;     stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := crcSetTime1;           cwOut := 7+1+6;             cwIn := 5+1+2;              bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := crcSetTime2;           cwOut := 7+1+6+10;          cwIn := 5+1+2;              bNumber := 255;   stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := acGetGraphInquiry;     cwOut := 1+2+6;             cwIn := 5+48+2;             bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acGetGraphCorrect;     cwOut := 1+1+6;             cwIn := 5+48+2;             bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acGetGraphRecalc;      cwOut := 1+1+6;             cwIn := 5+1+48+2;           bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acGetGraphTransit;     cwOut := 1+1+6;             cwIn := 5+48+2;             bNumber := 255;   stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := acSetGraphInquiry;     cwOut := 1+2+48+6;          cwIn := 5+2+2;              bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetGraphCorrect;     cwOut := 1+1+48+6;          cwIn := 5+1+2;              bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetGraphRecalc;      cwOut := 1+2+48+6;          cwIn := 5+1+2;              bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetGraphTransit;     cwOut := 1+1+48+6;          cwIn := 5+1+2;              bNumber := 255;   stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := acGetObjectName;       cwOut := 1+1+6;             cwIn := 5+NAMES+2;          bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetObjectName;       cwOut := 1+1+NAMES+6;       cwIn := 5+2+2;              bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acGetCanalsNames;      cwOut := 1+1+1+6;           cwIn := 5+NAMES+2;          bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetCanalsNames;      cwOut := 1+1+1+NAMES+6;     cwIn := 5+2+2;              bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acGetGroupsNames;      cwOut := 1+1+1+6;           cwIn := 5+NAMES+2;          bNumber := 255;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acSetGroupsNames;      cwOut := 1+1+1+NAMES+6;     cwIn := 5+2+2;              bNumber := 255;   stName := ''; Inc(i); end;

  with mpQuerysCRC[i] do begin actAction1 := acGetMemory0;          cwOut := 7;                 cwIn := 15+16+2;            bNumber := 248;   stName := ''; Inc(i); end;
  with mpQuerysCRC[i] do begin actAction1 := acGetMemory1;          cwOut := 7+2;               cwIn := 15+1056+2;          bNumber := 249;   stName := ''; Inc(i); end;

  for i := 0 to bQUERYS_EXT-1 do
    mpQuerysExt[i].actAction1 := crcNone;

  i := 0;

  with mpQuerysExt[i] do begin actAction1 := crcGetSimpleEscS;      cwOut := 1+6+1+bCANALS div 8; cwIn := 0;                bNumber := 255;   stName := 'аналог Esc S: текущие показания счётчиков';              Inc(i); end;
  with mpQuerysExt[i] do begin actAction1 := crcGetSimpleEscU;      cwOut := 1+6+1+bCANALS div 8; cwIn := 0;                bNumber := 255;   stName := 'аналог Esc U: Т счётчика и Т сумматора соответственно';  Inc(i); end;
  with mpQuerysExt[i] do begin actAction1 := crcGetSimpleEscV;      cwOut := 1+6+1+bCANALS div 8; cwIn := 0;                bNumber := 255;   stName := 'аналог Esc V: показания счётчиков по месяцам ';          Inc(i); end;

end;

end.


