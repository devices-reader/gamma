unit get_memory0;

interface

//procedure BoxGetMemory0;
procedure ShowGetMemory0;

var
  cbWaitQuery,
  ibHouIndex,
  ibEngTariff,
  ibPowTariff,
  ibMnt,
  ibDay,
  ibMon:        byte;

  iwHou:        word;

implementation

uses SysUtils, soutput, support, {box,} get_memory1;
{
const
  quGetMemory0: querys = (Action: acGetMemory0; cwOut: 7; cwIn: 15+16+2; bNumber: 248);

procedure QueryGetMemory0;
begin
  Query(quGetMemory0);
end;

procedure BoxGetMemory0;
begin
  QueryGetMemory0;
end;
}
function GetStatus(w: word): string;
begin
  if w = 0 then Result := 'нет' else Result := 'да';
end;

procedure ShowGetMemory0;
var
  w:  word;
begin
  Stop;
  InitPopCRC;

  ibHouIndex  := Pop;
  ibEngTariff := Pop;
  ibPowTariff := Pop;

  ibMnt := Pop;
  iwHou := Pop*$100 + Pop;;
  ibDay := Pop;
  ibMon := Pop;

  cbWaitQuery := Pop;

  AddInfo('');
  AddInfo('');
  AddInfo('—осто€ние прибора');

  InitPop(15);

  AddInfo('');
  AddInfo(PackStrR(IntToStr(Pop),GetColWidth) + 'количество каналов');
  AddInfo(PackStrR(IntToStr(Pop),GetColWidth) + 'количество групп');
  AddInfo(PackStrR(IntToStr(Pop),GetColWidth) + 'количество тарифов');

  AddInfo('');
  AddInfo(PackStrR(IntToStr(ibMnt) + ' - ' + IntToStr(Pop),GetColWidth)          + 'индекс по трЄхминутным массиву');
  AddInfo(PackStrR(IntToStr(iwHou) + ' - ' + IntToStr(Pop*$100+Pop),GetColWidth) + 'индекс по получасовым массиву');
  AddInfo(PackStrR(IntToStr(ibDay) + ' - ' + IntToStr(Pop),GetColWidth)          + 'индекс по дневным массиву');
  AddInfo(PackStrR(IntToStr(ibMon) + ' - ' + IntToStr(Pop),GetColWidth)          + 'индекс по мес€чным массиву');

  AddInfo('');
  AddInfo(PackStrR(IntToStr(ibHouIndex),GetColWidth)  + 'индекс текущего получаса');
  AddInfo(PackStrR(IntToStr(ibEngTariff),GetColWidth) + 'индекс тарифа по энергии');
  AddInfo(PackStrR(IntToStr(ibPowTariff),GetColWidth) + 'индекс тарифа по мощности');

  AddInfo('');
  AddInfo(PackStrR(IntToStr(Pop),GetColWidth)         + 'вершина стека');
  AddInfo(PackStrR(IntToStr(cbWaitQuery),GetColWidth) + 'таймер опроса');

  InitPop(15+9);
  w := PopInt();
  
  AddInfo('');
  AddInfo('');
  AddInfo('—осто€ние пам€ти');
  AddInfo('');
  AddInfo(PackStrR('0x'+IntToHex(w,4),GetColWidth) + 'код состо€ни€');
  AddInfo(PackStrR(GetStatus(w and $0001),GetColWidth) + 'ошибки при сравнении');
  AddInfo(PackStrR(GetStatus(w and $0002),GetColWidth) + 'ошибки при стирании');
  AddInfo(PackStrR(GetStatus(w and $0004),GetColWidth) + 'ошибки при чтении');
  AddInfo(PackStrR(GetStatus(w and $0008),GetColWidth) + 'ошибки при записи');

  InitPushCRC;
  Push($FF);
  Push($FF);
  QueryCRC(acGetMemory1);
end;

end.
