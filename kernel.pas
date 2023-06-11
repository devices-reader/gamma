unit kernel;

interface

uses Graphics, SysUtils, Classes;

function GetBaudSize(i: byte): longword;
function GetParityName(i: byte): string;
function GetDeviceName(i: byte): string;
function GetLineName(i: byte): string;
function GetIndexByLine(j: byte): byte;
function GetLineByIndex(j: byte): byte;
function GetLineByName(s: string): byte;
function GetNameByLine(j: byte): string;

procedure LoadCmbBauds(Strings: TStrings);
procedure LoadCmbParitys(Strings: TStrings);
procedure LoadCmbDevices(Strings: TStrings);
procedure LoadCmbLines(Strings: TStrings);

const

  bCANALS                       = 64;
  bGROUPS                       = 32;
  wPARAMS                       = 500;

  bMAXRELAXS                    = 40;

  bBREAKS                       = 6;
  bHEADER                       = 15;
  bREAL                         = 4;

  wFREEPAGE_SIZE                = 1040;

  wRECORDS                      = 500;
  bRECORD_BUFF                  = 8;
  bRECORD_SIZE                  = 6+4+1+bRECORD_BUFF;
  bRECORD_BLOCK                 = wFREEPAGE_SIZE div bRECORD_SIZE;
  bRECORD_PAGES                 = (wRECORDS div bRECORD_BLOCK)+1;

  GRAPH_PLUS  = ' да';
  GRAPH_MINUS = ' нет';
  GRAPH_PORT3 = ' порт 3';
  GRAPH_PORT4 = ' порт 4';

type
  tables = (table_canals, table_params, table_groups, table_phones, table_addresses, table_addresses2,
  table_graph_inquiry, table_graph_correct, table_graph_recalc, table_graph_transit,
  table_canals_names, table_groups_names
  );

  tariff = record
    bHour:      byte;
    bMinute:    byte;
    bTariff:    byte;
  end;

  zones = record
    bSize:      byte;
    mpTariffs:  array[1..bBREAKS] of tariff;
  end;

  digital = record
    ibPort:     byte;
    ibPhone:    byte;
    bDevice:    byte;
    bAddress:   byte;
    ibLine:     byte;
  end;

  param_map = record
    ibLine:     byte;
    stName:     string;
  end;

  device_ = record
    stName:     string;
  end;

  canal = record
    exKtrans:    extended;
    exKpulse:    extended;
    exKlosse:    extended;
    exKcount:    extended;
    exKlevel:    extended;
  end;

  params2 = record
    exKdivid:    extended;
  end;

  nodes = record
    ibCanal:    byte;
  end;

  groups = record
    bSize:      byte;
    mpnoNodes:  array[0..bCANALS] of nodes;
  end;
  
const
  BAUDS                         = 10;
  PARITYS                       = 5;
  DEVICES                       = 1+39;
  DEVICES_LINES                 = 1+28;
  NUMBERS                       = 13+1;
  NAMES                         = 32;

//  panCONNECT:           byte    = 0;
  panSYSTEM:            byte    = 1;
  panTIMEOUT:           byte    = 2;
  panTIMEDATE:          byte    = 3;
  panREPEAT:            byte    = 4;
  panPROGRESS:          byte    = 5;

  digNUMBER:            byte    = 0;
  digPORT:              byte    = 1;
  digPHONE:             byte    = 2;
  digDEVICE:            byte    = 3;
  digADDRESS:           byte    = 4;
  digLINE:              byte    = 5;

  digSHORT:             byte    = 6;

  digTRANS:             byte    = 7;
  digPULSE:             byte    = 8;
  digLOSSE:             byte    = 9;
  digCOUNT:             byte    = 10;
  digLEVEL:             byte    = 11;

  digDIVID:             byte    = 7;

  mpbDIGITALSSIZE:      array[0..11] of byte = (4,10,10,20,10,10,2,12,12,12,12,12);
  bTARIFFSSIZE:         byte    = 11;
  bGROUPSSIZE:          byte    = 16;
  bNODESSIZE:           byte    = 4;
  bPHONESIZE:           byte    = 16;
  bPARAMSIZE:           byte    = 20;
  bINDEXSIZE:           byte    = 4;
  bGRAPHSIZE:           byte    = 10;

  SETTING:    string  = 'Настройки';
  COM_PORT:   string  = 'COM_порт';
  MODEM:      string  = 'Модем';
  SOCKET:     string  = 'Сокет';
  PARAMS:     string  = 'Параметры';

  NUMBER:     string  = 'Порт';
  BAUD:       string  = 'Скорость';
  PARITY:     string  = 'Чётность';
  TIMEOUT:    string  = 'Таймаут';
  DIAL:       string  = 'Номер';
  DEVICE:     string  = 'Устройство';
  HOST:       string  = 'Хост';
  PORT:       string  = 'Порт';
  ADDRESS:    string  = 'Адрес';
  PACKET:     string  = 'Пакет';
  PASSWORD:   string  = 'Пароль';
  MODE:       string  = 'Режим';
  VERSION:    string  = 'Версия';

  stSETTINGS:           string  = '\Настройки';
  stREPORTS:            string  = '\Отчёты';
  stLOGS:               string  = '\Логи';
  LOGS_DIR:             string  = 'log';

var
  mpDigitals:           array[0..bCANALS] of digital;
  mpCanals:             array[0..bCANALS] of canal;

  mpParams1:            array[0..wPARAMS] of digital;
  mpParams2:            array[0..wPARAMS] of params2;

  mpgrGroups:           array[0..bGROUPS] of groups;
  mpbGroups:            array[0..bGROUPS,0..bCANALS] of byte;

implementation

const
  mpdwBauds:    array[0..BAUDS-1] of longword =
  (300,600,1200,2400,4800,9600,19200,38400,57600,115200);

  mpstParitys:  array[0..PARITYS-1] of string =
  ('none','even','odd','mark','space');

  mpDevices:    array[0..DEVICES-1] of device_ =
  (
    (stName: 'нет'            ),
    (stName: 'СЭТ-4ТМ'        ),
    (stName: 'Меркурий-230'   ),
    (stName: 'CC-301'         ),
    (stName: 'АВВ ЕвроАльфа'  ),
    (stName: 'СЭМ+2 Esc'      ),
    (stName: 'СЭМ+2 CRC'      ),
    (stName: 'ПРТ-1'          ),
    (stName: 'ПРТ-М230'       ),
    (stName: 'СТК3-xxQxxx'    ),
    (stName: 'СТК3-10Axxx'    ),
    (stName: 'СЭБ-2А.07'      ),
    (stName: 'Меркурий-230 +' ),
    (stName: 'ЦЭ6850М'        ),
    (stName: 'ЦЭ6823М'        ),
    (stName: 'ПРТ-C4'         ),
    (stName: 'ЦЭ6850М +'      ),
    (stName: 'ЦЭ6823М +'      ),
    (stName: 'Меркурий-200 +' ),
    (stName: 'ПИ-1.4'         ),
    (stName: 'ПСЧ-4ТА.04'     ),
    (stName: 'Elster A1140'   ),
    (stName: 'CE304'          ),
    (stName: 'РСВУ-1400'      ),
    (stName: 'CE102'          ),
    (stName: 'ПСЧ-3АРТ.07 v3' ),
    (stName: 'CE301'          ),
    (stName: 'МИРТЕК'         ),
    (stName: 'CE303'          ),
    (stName: 'МЭС-1'          ),
    (stName: 'МЭС-3'          ),
    (stName: 'СТК3 v48-49'    ),
    (stName: 'СТК3/1 v51-54'  ),
    (stName: 'СТК3 v16-18'    ),
    (stName: 'ESM'            ),
    (stName: 'СЕ102 NNCL2'    ),
    (stName: 'СЕ301 NNCL2'    ),
    (stName: 'СЕ303 NNCL2'    ),
    (stName: 'СЕ318'          ),
    (stName: 'СЕ318 S39'      )
  );

  mpParamsMap:    array[0..DEVICES_LINES-1] of param_map =
  (
    (ibLine: 0;  stName: 'нет'),
    (ibLine: 10; stName: 'P, Вт всего'),
    (ibLine: 11; stName: 'P, Вт фаза 1'),
    (ibLine: 12; stName: 'P, Вт фаза 2'),
    (ibLine: 13; stName: 'P, Вт фаза 3'),

    (ibLine: 20; stName: 'Q, ВАР всего'),
    (ibLine: 21; stName: 'Q, ВАР фаза 1'),
    (ibLine: 22; stName: 'Q, ВАР фаза 2'),
    (ibLine: 23; stName: 'Q, ВАР фаза 3'),

    (ibLine: 30; stName: 'S, ВА всего'),
    (ibLine: 31; stName: 'S, ВА фаза 1'),
    (ibLine: 32; stName: 'S, ВА фаза 2'),
    (ibLine: 33; stName: 'S, ВА фаза 3'),

    (ibLine: 40; stName: 'U, В всего'),
    (ibLine: 41; stName: 'U, В фаза 1'),
    (ibLine: 42; stName: 'U, В фаза 2'),
    (ibLine: 43; stName: 'U, В фаза 3'),

    (ibLine: 50; stName: 'I, мА всего'),
    (ibLine: 51; stName: 'I, мА фаза 1'),
    (ibLine: 52; stName: 'I, мА фаза 2'),
    (ibLine: 53; stName: 'I, мА фаза 3'),

    (ibLine: 60; stName: 'cos Ф всего'),
    (ibLine: 61; stName: 'cos Ф фаза 1'),
    (ibLine: 62; stName: 'cos Ф фаза 2'),
    (ibLine: 63; stName: 'cos Ф фаза 3'),

    (ibLine: 70; stName: 'f, Гц всего'),
    (ibLine: 71; stName: 'f, Гц фаза 1'),
    (ibLine: 72; stName: 'f, Гц фаза 2'),
    (ibLine: 73; stName: 'f, Гц фаза 3')
  );

function GetBaudSize(i: byte): longword;
begin
  if i >= BAUDS then
    Result := 0
  else
    Result := mpdwBauds[i];
end;

function GetParityName(i: byte): string;
begin
  if i >= PARITYS then
    Result := ' #' + IntToStr(i)
  else
    Result := mpstParitys[i];
end;

function GetDeviceName(i: byte): string;
begin
  if i >= DEVICES then
    Result := ' #' + IntToStr(i)
  else
    Result := mpDevices[i].stName;
end;

function GetLineName(i: byte): string;
begin
  if i >= DEVICES_LINES then
    Result := ' #' + IntToStr(i)
  else
    Result := mpParamsMap[i].stName;
end;

function GetIndexByLine(j: byte): byte;
var
  i: byte;
begin
  Result := 0;
  for i := 0 to DEVICES_LINES-1 do begin
    if (mpParamsMap[i].ibLine = j) then Result := i;
  end;
end;

function GetNameByLine(j: byte): string;
var
  i: byte;
begin
  Result := mpParamsMap[0].stName;
  for i := 0 to DEVICES_LINES-1 do begin
    if (mpParamsMap[i].ibLine = j) then Result := mpParamsMap[i].stName;
  end;
end;

function GetLineByIndex(j: byte): byte;
begin
  Result := mpParamsMap[j].ibLine;
end;

function GetLineByName(s: string): byte;
var
  i: byte;
begin
  Result := 0;
  for i := 0 to DEVICES_LINES-1 do begin
    if (mpParamsMap[i].stName = s) then
      begin Result := mpParamsMap[i].ibLine; exit; end;
  end;
end;

procedure LoadCmbBauds(Strings: TStrings);
var
  i:    word;
begin
  with Strings do begin
    Clear;
    for i := 0 to BAUDS-1 do Append(IntToStr(GetBaudSize(i)));
  end;
end;

procedure LoadCmbParitys(Strings: TStrings);
var
  i:    word;
begin
  with Strings do begin
    Clear;
    for i := 0 to PARITYS-1 do Append(GetParityName(i));
  end;
end;

procedure LoadCmbDevices(Strings: TStrings);
var
  i:    word;
begin
  with Strings do begin
    Clear;
    for i := 0 to DEVICES-1 do Append(' ' + GetDeviceName(i));
  end;
end;

procedure LoadCmbLines(Strings: TStrings);
var
  i:    word;
begin
  with Strings do begin
    Clear;
    for i := 0 to DEVICES_LINES-1 do Append(' ' + GetLineName(i));
  end;
end;

end.
