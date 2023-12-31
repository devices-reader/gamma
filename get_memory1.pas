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
  l.add('������������� ������');
  l.add('');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� �������� ��� ������� ''������''');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� �������� ��� ���������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� �������� ��� �������� ��������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� �������� ��� ������ ��������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� �������� ��� ������ ��������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� ������ ��� ���������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� ������ ��� �������� ��������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� ������ ��� ������ ��������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� ������ ��� ������ ��������');

  l.add('');
  for i := 1 to 4 do Pop;

  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ������ ������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ��������� �������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ����� �������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ������ ��������� �� ���������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ������ ��������� �� ������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ������ ��������� �� �������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ������ ���������� �������� �� ������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ������ ���������� �������� �� �������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ������ ��������� �� �������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ����� ������');

  l.add('');
  for i := 1 to 6 do Pop;

  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� ������������ WDT');
  
  l.add('');
  l.add(PackStrR('0x' + IntToHex(PopInt,4),GetColWidth) + '������ ���������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '��������� �����');
  l.add(PackStrR(IntToStr(Pop),GetColWidth) + '���������� �����');

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
  l.add(PackStrR(IntToStr(cwRecord),    GetColWidth) + '������� �������: ���������� ������� �����');
  l.add(PackStrR(IntToStr(bRecordBlock),GetColWidth) + '������� �������: ���������� ������� �� ��������');
  l.add(PackStrR(IntToStr(bRecordSize), GetColWidth) + '������� �������: ���������� ������� (+1)');

  l.add('');
  l.add(PackStrR(IntToStr(pwCorrect),   GetColWidth) + '����� ������� ��������� �������');
  l.add(PackStrR(IntToStr(pwSystem),    GetColWidth) + '����� ������� ��������� �������');
  l.add(PackStrR(IntToStr(pwSensors),   GetColWidth) + '����� ������� ��������� ���������');
  l.add(PackStrR(IntToStr(pwEvents),    GetColWidth) + '����� ������� ������� �������');
  l.add(PackStrR(IntToStr(pwModems),    GetColWidth) + '����� ������� ��������� �������');
  l.add(PackStrR(IntToStr(pwMessages),  GetColWidth) + '����� ������� ���-��������');

  l.add('');
  l.add(PackStrR(IntToStr(cdwCorrect),  GetColWidth) + '������� ������� ��������� �������');
  l.add(PackStrR(IntToStr(cdwSystem),   GetColWidth) + '������� ������� ��������� �������');
  l.add(PackStrR(IntToStr(cdwSensors),  GetColWidth) + '������� ������� ��������� ���������');
  l.add(PackStrR(IntToStr(cdwEvents),   GetColWidth) + '������� ������� ������� �������');
  l.add(PackStrR(IntToStr(cdwModems),   GetColWidth) + '������� ������� ��������� �������');
  l.add(PackStrR(IntToStr(cdwMessages), GetColWidth) + '������� ������� ���-��������');

  l.add('');
  l.add(PackStrR(IntToStr(cdwSecond),   GetColWidth) + '���������� ���������: �������');
  l.add(PackStrR(IntToStr(cdwMinute1),  GetColWidth) + '���������� ���������: 1 ���');
  l.add(PackStrR(IntToStr(cdwMinute3),  GetColWidth) + '���������� ���������: 3 ���');
  l.add(PackStrR(IntToStr(cdwMinute30), GetColWidth) + '���������� ���������: 30 ���');
  l.add(PackStrR(IntToStr(cwDay),       GetColWidth) + '���������� ���������: ����');
  l.add(PackStrR(IntToStr(cwMonth),     GetColWidth) + '���������� ���������: �����');
  l.add(PackStrR(IntToStr(cwYear),      GetColWidth) + '���������� ���������: ���');

  l.add('');
  l.add(PackStrR(IntToStr(pwPowDayGrp2),GetColWidth) + '����� ������ ���������� �������� �� ������ (�����������)');
  l.add(PackStrR(IntToStr(pwCntMonCan2),GetColWidth) + '����� ������ ��������� �� ������� (�����������)');

  AddInfoAll(l);

  InfBox('��������� ������ ��������� �������');
end;

end.
