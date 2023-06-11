unit get_memory1;

interface

//procedure BoxGetMemory1;
procedure ShowGetMemory1;

implementation

uses SysUtils, Classes, soutput, support, {progress, box,} kernel, terminal, crc;
{
const
  quGetMemory1: querys = (Action: acGetMemory1; cwOut: 7+2; cwIn: bHEADER+wPAGE_SIZE+2; bNumber: 249);
}
var
  pwModems,
  pwMessages,
  pwCorrect,
  pwSystem,
  pwSensors,
  pwEvents:     word;

  cdwModems,
  cdwMessages,
  cdwCorrect,
  cdwSystem,
  cdwSensors,
  cdwEvents:    longword;

  cdwSecond,
  cdwMinute1,
  cdwMinute3,
  cdwMinute30:  longword;
  cwDay,
  cwMonth,
  cwYear:       word;

  pwPowDayGrp2,
  pwCntMonCan2: word;

  cwRecord:     word;
  bRecordBlock,
  bRecordSize:  byte;
{
procedure QueryGetMemory1;
begin
  InitPushCRC;
  Push($FF);
  Push($FF);
  Query(quGetMemory1);
end;

procedure BoxGetMemory1;
begin
  QueryGetMemory1;
end;
}
procedure ShowGetMemory1;
var
  i:  byte;
  l:  TStringList;
begin
  Stop;
  InitPop(15);

  l := TStringList.Create;

  l.add('');
  l.add('');
  l.add('Распределение памяти');
  l.add('');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество повторов при сигнале ''Занято''');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество повторов при сравнении');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество повторов при стирании страницы');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество повторов при чтении страницы');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество повторов при записи страницы');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество ошибок при сравнении');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество ошибок при стирании страницы');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество ошибок при чтении страницы');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество ошибок при записи страницы');

  l.add('');
  for i := 1 to 4 do Pop;

  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес начала памяти');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес служебной области');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес метки запуска');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес начала импульсов по получасам');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес начала импульсов по суткам');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес начала импульсов по месяцам');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес начала максимумов мощности по суткам');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес начала максимумов мощности по месяцам');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес начала счётчиков по месяцам');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес конца памяти');

  l.add('');
  for i := 1 to 6 do Pop;

  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество срабатываний WDT');
  
  l.add('');
  l.add(PackStrR('0x' + IntToHex(PopInt,4),GetColWidth) + 'версия программы');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'заводской номер');
  l.add(PackStrR(IntToStr(Pop),GetColWidth) + 'логический номер');

  pwCorrect     := PopInt;
  pwSystem      := PopInt;
  pwSensors     := PopInt;
  pwEvents      := PopInt;

  cwRecord      := PopInt;
  bRecordBlock  := Pop;
  bRecordSize   := Pop;

  cdwCorrect    := PopLong;
  cdwSystem     := PopLong;
  cdwSensors    := PopLong;
  cdwEvents     := PopLong;

  cdwSecond     := PopLong;
  cdwMinute1    := PopLong;
  cdwMinute3    := PopLong;
  cdwMinute30   := PopLong;
  cwDay         := PopInt;
  cwMonth       := PopInt;
  cwYear        := PopInt;

  for i := 1 to 4 do Pop;

  pwModems      := PopInt;
  cdwModems     := PopLong;

  pwPowDayGrp2  := PopInt;
  pwCntMonCan2  := PopInt;

  pwMessages  := PopInt;
  cdwMessages := PopLong;

  l.add('');
  l.add(PackStrR(IntToStr(cwRecord),    GetColWidth) + 'журналы событий: количество записей общее');
  l.add(PackStrR(IntToStr(bRecordBlock),GetColWidth) + 'журналы событий: количество записей на страницу');
  l.add(PackStrR(IntToStr(bRecordSize), GetColWidth) + 'журналы событий: количество страниц (+1)');

  l.add('');
  l.add(PackStrR(IntToStr(pwCorrect),   GetColWidth) + 'адрес журнала коррекции времени');
  l.add(PackStrR(IntToStr(pwSystem),    GetColWidth) + 'адрес журнала состояния системы');
  l.add(PackStrR(IntToStr(pwSensors),   GetColWidth) + 'адрес журнала состояния счётчиков');
  l.add(PackStrR(IntToStr(pwEvents),    GetColWidth) + 'адрес журнала внешних событий');
  l.add(PackStrR(IntToStr(pwModems),    GetColWidth) + 'адрес журнала состояния модемов');
  l.add(PackStrR(IntToStr(pwMessages),  GetColWidth) + 'адрес журнала СМС-контроля');

  l.add('');
  l.add(PackStrR(IntToStr(cdwCorrect),  GetColWidth) + 'счетчик журнала коррекции времени');
  l.add(PackStrR(IntToStr(cdwSystem),   GetColWidth) + 'счетчик журнала состояния системы');
  l.add(PackStrR(IntToStr(cdwSensors),  GetColWidth) + 'счетчик журнала состояния счётчиков');
  l.add(PackStrR(IntToStr(cdwEvents),   GetColWidth) + 'счетчик журнала внешних событий');
  l.add(PackStrR(IntToStr(cdwModems),   GetColWidth) + 'счетчик журнала состояния модемов');
  l.add(PackStrR(IntToStr(cdwMessages), GetColWidth) + 'счетчик журнала СМС-контроля');

  l.add('');
  l.add(PackStrR(IntToStr(cdwSecond),   GetColWidth) + 'количество переходов: секунда');
  l.add(PackStrR(IntToStr(cdwMinute1),  GetColWidth) + 'количество переходов: 1 мин');
  l.add(PackStrR(IntToStr(cdwMinute3),  GetColWidth) + 'количество переходов: 3 мин');
  l.add(PackStrR(IntToStr(cdwMinute30), GetColWidth) + 'количество переходов: 30 мин');
  l.add(PackStrR(IntToStr(cwDay),       GetColWidth) + 'количество переходов: день');
  l.add(PackStrR(IntToStr(cwMonth),     GetColWidth) + 'количество переходов: месяц');
  l.add(PackStrR(IntToStr(cwYear),      GetColWidth) + 'количество переходов: год');

  l.add('');
  l.add(PackStrR(IntToStr(pwPowDayGrp2),GetColWidth) + 'адрес начала максимумов мощности по суткам (специальный)');
  l.add(PackStrR(IntToStr(pwCntMonCan2),GetColWidth) + 'адрес начала счётчиков по месяцам (специальный)');

  AddInfoAll(l);

  InfBox('Состояние пямяти прочитано успешно');
end;

end.
