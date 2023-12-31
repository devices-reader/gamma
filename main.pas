unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  basic, ComCtrls, ToolWin, StdCtrls, IniFiles, ExtCtrls,
  Buttons, Mask, Grids, Menus, FileCtrl, OoMisc, AdPort, ImgList, CheckLst,
  AdTapi, AdTStat, kernel, timez, ScktComp, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdGlobal;

type
  TfrmMain = class(TfrmBasic)
    ComPort: TApdComPort;
    timTimeout: TTimer;
    timNow: TTimer;
    sd_RichToFile: TSaveDialog;
    stbMain: TStatusBar;
    panClient: TPanel;
    TapiDevice: TApdTapiDevice;
    TapiLog: TApdTapiLog;
    mnmMain: TMainMenu;
    N2: TMenuItem;
    mniClose: TMenuItem;
    N8: TMenuItem;
    mniStop: TMenuItem;
    N1: TMenuItem;
    mniPrev: TMenuItem;
    mniNext: TMenuItem;
    N4: TMenuItem;
    mniFirst: TMenuItem;
    mniLast: TMenuItem;
    N3: TMenuItem;
    mitVersion: TMenuItem;
    tlbBottom: TToolBar;
    tlbPrev: TToolButton;
    tlbNext: TToolButton;
    tlbA: TToolButton;
    tlbStop: TToolButton;
    tlbB: TToolButton;
    tlbClose: TToolButton;
    tlbC: TToolButton;
    imlNormal: TImageList;
    pgcMain: TPageControl;
    tbsFirst: TTabSheet;
    tbsLast: TTabSheet;
    panTop3: TPanel;
    panRight3: TPanel;
    tlbEscA: TToolButton;
    tlbD: TToolButton;
    tbsTariffs: TTabSheet;
    pgcTariffs: TPageControl;
    tbsPow: TTabSheet;
    stgAllTariffsPow: TStringGrid;
    tbsEng: TTabSheet;
    stgAllTariffsEng: TStringGrid;
    tbsPub: TTabSheet;
    stgAllTariffsPub: TStringGrid;
    stgTariffsDay: TStringGrid;
    btbMonth3Y1: TBitBtn;
    btbMonth4Y1: TBitBtn;
    btbMonth5Y1: TBitBtn;
    btbMonth6Y1: TBitBtn;
    btbMonth7Y1: TBitBtn;
    btbMonth8Y1: TBitBtn;
    btbMonth9Y1: TBitBtn;
    btbMonth10Y1: TBitBtn;
    btbMonth11Y1: TBitBtn;
    btbMonth12Y1: TBitBtn;
    btbQuarter2Y1: TBitBtn;
    btbQuarter3Y1: TBitBtn;
    btbQuarter4Y1: TBitBtn;
    btbQuarter1Y1: TBitBtn;
    btbYearY1: TBitBtn;
    btbMonth2Y1: TBitBtn;
    btbMonth1Y1: TBitBtn;
    btbGetAllTariffs: TBitBtn;
    btbSetAllTariffs: TBitBtn;
    btbClearTariffs: TBitBtn;
    tlbConsole: TToolButton;
    tbsDigitals: TTabSheet;
    panClient2: TPanel;
    lblDigitals: TLabel;
    stgDigitals: TStringGrid;
    panRight2: TPanel;
    cmbGridDevicesDig: TComboBox;
    sd_SaveGrid: TSaveDialog;
    od_CustomLoad: TOpenDialog;
    lblPubInfo: TLabel;
    lblPowInfo: TLabel;
    lblEngInfo: TLabel;
    btbImportTariffs: TBitBtn;
    btbExportTariffs: TBitBtn;
    N6: TMenuItem;
    mniRunFlow: TMenuItem;
    mniTestFlow: TMenuItem;
    mniCloseFlow: TMenuItem;
    rgrPublic: TRadioGroup;
    btbGetPublic: TBitBtn;
    btbSetPublic: TBitBtn;
    btbClearCanals: TBitBtn;
    btbExportCanals: TBitBtn;
    btbImportCanals: TBitBtn;
    btbGetDigitals: TBitBtn;
    btbSetDigitals: TBitBtn;
    miniDigitals: TMenuItem;
    mniTariffs: TMenuItem;
    rgrPacket: TRadioGroup;
    tbsGroups: TTabSheet;
    mniGroups: TMenuItem;
    panRight8: TPanel;
    btbClearGroups: TBitBtn;
    btbExportGroups: TBitBtn;
    btbImportGroups: TBitBtn;
    btbGetGroups: TBitBtn;
    btbSetGroups: TBitBtn;
    stgGroups: TStringGrid;
    lblDevice: TLabel;
    tbsPhones: TTabSheet;
    stgPhones: TStringGrid;
    panRight9: TPanel;
    btbClearPhones: TBitBtn;
    btbExportPhones: TBitBtn;
    btbImportPhones: TBitBtn;
    btbGetPhones: TBitBtn;
    btbSetPhones: TBitBtn;
    mniPhones: TMenuItem;
    panTAPI: TPanel;
    memDial: TMemo;
    tbsParams: TTabSheet;
    mniParams: TMenuItem;
    panRight7: TPanel;
    btbClearParams: TBitBtn;
    btbExportParams: TBitBtn;
    btbImportParams: TBitBtn;
    btbGetParams: TBitBtn;
    btbSetParams: TBitBtn;
    stgParams: TStringGrid;
    cmbGridDevicesPar: TComboBox;
    panBottom7: TPanel;
    btbResetDivid: TBitBtn;
    tbsRecords: TTabSheet;
    mniRecords: TMenuItem;
    panRight10: TPanel;
    btbClearRecords: TBitBtn;
    btbSaveRecords: TBitBtn;
    btbGetRecords: TBitBtn;
    Panel2: TPanel;
    redRecords: TRichEdit;
    rgrEvent: TRadioGroup;
    chbLevel: TCheckBox;
    lblAddress: TLabel;
    edtAddress: TEdit;
    updAddress: TUpDown;
    tbsAddresses: TTabSheet;
    mniAddresses: TMenuItem;
    tbsRelaxs: TTabSheet;
    panRight12: TPanel;
    btbRelaxsClear: TBitBtn;
    btbExportRelaxs: TBitBtn;
    btbImportRelaxs: TBitBtn;
    btbGetRelaxs: TBitBtn;
    btbSetRelaxs: TBitBtn;
    lbxRelaxs: TListBox;
    btbRelaxsAddHoliday: TBitBtn;
    btbRelaxsClearAllDays: TBitBtn;
    btbRelaxsAddWeekday: TBitBtn;
    clnRelaxs: TMonthCalendar;
    btbRelaxsClearDay: TBitBtn;
    lblRelaxs: TLabel;
    tbsCorrect2: TTabSheet;
    medSetTime1: TMaskEdit;
    btbSetTime1: TBitBtn;
    lblSetTime2: TLabel;
    btbGetTime: TBitBtn;
    memGetTime: TMemo;
    medSetTime2: TMaskEdit;
    btbSetTime2: TBitBtn;
    btbClearTime: TBitBtn;
    medPass2: TMaskEdit;
    lblSetTime1: TLabel;
    lblGetTime: TLabel;
    pgcMode: TPageControl;
    tbsPort: TTabSheet;
    tbsModem: TTabSheet;
    tbsSocket: TTabSheet;
    lblSelectedDevice: TLabel;
    btbSelectDevice: TBitBtn;
    btbShowConfigDialog: TBitBtn;
    btbDial: TBitBtn;
    btbCancelCall: TBitBtn;
    edtDial: TEdit;
    btbSocketOpen: TBitBtn;
    edtSocketHost: TEdit;
    btbSocketClose: TBitBtn;
    edtSocketPort: TEdit;
    lblComNumber: TLabel;
    lblBaud: TLabel;
    lblParity: TLabel;
    cmbComNumber: TComboBox;
    cmbBaud: TComboBox;
    cmbParity: TComboBox;
    lblTimeoutPort: TLabel;
    edtTimeoutPort: TEdit;
    updTimeoutPort: TUpDown;
    lblTimeoutSocket: TLabel;
    edtTimeoutSocket: TEdit;
    updTimeoutSocket: TUpDown;
    lblTimeoutModem: TLabel;
    edtTimeoutModem: TEdit;
    updTimeoutModem: TUpDown;
    lblSocketHost: TLabel;
    lblSocketPort: TLabel;
    redTerminal: TMemo;
    btbExportTerminal: TBitBtn;
    btbClearTerminal: TBitBtn;
    tbsGraphs: TTabSheet;
    pgcGraphs: TPageControl;
    tbsGraphInquiry: TTabSheet;
    tbsGraphCorrect: TTabSheet;
    tbsGraphRecalc: TTabSheet;
    panRight50: TPanel;
    btbClearGraphInquiry: TBitBtn;
    btbSaveGraphInquiry: TBitBtn;
    btbLoadGraphInquiry: TBitBtn;
    btbGetGraphInquiry: TBitBtn;
    btbSetGraphInquiry: TBitBtn;
    stgGraphInquiry: TStringGrid;
    stgGraphCorrect: TStringGrid;
    panRight51: TPanel;
    btbClearGraphCorrect: TBitBtn;
    btbSaveGraphCorrect: TBitBtn;
    btbLoadGraphCorrect: TBitBtn;
    btbGetGraphCorrect: TBitBtn;
    btbSetGraphCorrect: TBitBtn;
    panRight52: TPanel;
    btbClearGraphRecalc: TBitBtn;
    btbSaveGraphRecalc: TBitBtn;
    btbLoadGraphRecalc: TBitBtn;
    btbSetGraphRecalc: TBitBtn;
    panClient52: TPanel;
    panTop52: TPanel;
    rgrGraphRecalc: TRadioGroup;
    btbGetGraphRecalc: TBitBtn;
    stgGraphRecalc: TStringGrid;
    cmbGridLinesPar: TComboBox;
    chbResetDivid: TCheckBox;
    chbBulk: TCheckBox;
    tbsNames: TTabSheet;
    pgcNames: TPageControl;
    tbsObjectName: TTabSheet;
    tbsCanalsNames: TTabSheet;
    tbsGroupsNames: TTabSheet;
    stgCanalsNames: TStringGrid;
    panRight20: TPanel;
    btbClearCanalsNames: TBitBtn;
    btbExportCanalsNames: TBitBtn;
    btbImportCanalsNames: TBitBtn;
    btbGetCanalsNames: TBitBtn;
    btbSetCanalsNames: TBitBtn;
    stgGroupsNames: TStringGrid;
    panRight21: TPanel;
    btbClearGroupsNames: TBitBtn;
    btbExportGroupsNames: TBitBtn;
    btbImportGroupsNames: TBitBtn;
    btbGetGroupsNames: TBitBtn;
    btbSetGroupsNames: TBitBtn;
    edtObjectName: TEdit;
    btbGetObjectName: TBitBtn;
    btbSetObjectName: TBitBtn;
    btbClearObjectName: TBitBtn;
    IdTCPClient: TIdTCPClient;
    prbLoad: TProgressBar;
    mniRelaxs: TMenuItem;
    mniGraphs: TMenuItem;
    mniCorrect2: TMenuItem;
    mniNames: TMenuItem;
    chbCtrlZ: TCheckBox;
    tbsGraphTransit: TTabSheet;
    panRight53: TPanel;
    btbClearGraphTransit: TBitBtn;
    btbSaveGraphTransit: TBitBtn;
    btbLoadGraphTransit: TBitBtn;
    btbGetGraphTransit: TBitBtn;
    btbSetGraphTransit: TBitBtn;
    stgGraphTransit: TStringGrid;
    pgcAddresses: TPageControl;
    tbsAddresses1: TTabSheet;
    tbsAddresses2: TTabSheet;
    panRight11: TPanel;
    btbClearAddresses: TBitBtn;
    btbExportAddresses: TBitBtn;
    btbImportAddresses: TBitBtn;
    btbGetAddresses: TBitBtn;
    btbSetAddresses: TBitBtn;
    stgAddresses: TStringGrid;
    stgAddresses2: TStringGrid;
    panRight13: TPanel;
    btbClearAddresses2: TBitBtn;
    btbExportAddresses2: TBitBtn;
    btbImportAddresses2: TBitBtn;
    btbGetAddresses2: TBitBtn;
    btbSetAddresses2: TBitBtn;
    procedure ShowConnect;
    procedure SetBaud(dwBaud: longword);
    procedure SetComNumber(wComNumber: word);
    procedure cmbComNumberChange(Sender: TObject);
    procedure cmbBaudChange(Sender: TObject);
    procedure SetParity(ibParity: byte);
    function  GetParity: byte;
    function  GetParityStr: string;
    function  GetTimeout: word;
    procedure FormShow(Sender: TObject);
    procedure ComPortTriggerAvail(CP: TObject; Count: Word);
    procedure timTimeoutTimer(Sender: TObject);
    procedure timNowTimer(Sender: TObject);
    procedure ShowRepeat;
    procedure ClearGrid(Grid: TStringGrid; fNumbers: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cmbParityChange(Sender: TObject);
    procedure FocusTerminal;
    procedure ClearTerminal;
    procedure InsTerminal(stT: string; clOut: TColor);
    procedure AddTerminal(stT: string; clOut: TColor);
    procedure AddTerminalTime(stT: string; clOut: TColor);
    procedure ComTerminal(stT: string);
    procedure ClearDial;
    procedure AddDial(stT: string);
    procedure InsByte(bT: byte; clT: TColor);
    procedure SaveRich(Rich: TRichEdit; stName: string);
    procedure tlbStopClick(Sender: TObject);
//    procedure ComPortTriggerData(CP: TObject; TriggerHandle: Word);
    procedure ShowSelectedDevice;
    procedure TAPIoff;
    procedure TAPIon;
    procedure TapiDeviceTapiStatus(CP: TObject; First, Last: Boolean;
      Device, Message, Param1, Param2, Param3: Integer);
    procedure TapiDeviceTapiLog(CP: TObject; Log: TTapiLogCode);
    procedure TapiDeviceTapiPortOpen(Sender: TObject);
    procedure TapiDeviceTapiPortClose(Sender: TObject);
    procedure TapiDeviceTapiConnect(Sender: TObject);
    procedure TapiDeviceTapiFail(Sender: TObject);
    procedure tlbCloseClick(Sender: TObject);
    procedure tlbPrevClick(Sender: TObject);
    procedure tlbNextClick(Sender: TObject);
    procedure mniPrevClick(Sender: TObject);
    procedure mniNextClick(Sender: TObject);
    procedure ShowButtons;
    procedure SetActivePage(TabSheet: TTabSheet);
    procedure pgcMainChange(Sender: TObject);
    procedure mniFirstClick(Sender: TObject);
    procedure mniLastClick(Sender: TObject);
    procedure mniCloseClick(Sender: TObject);
    procedure mniStopClick(Sender: TObject);
    procedure tlbEscAClick(Sender: TObject);
    procedure stgTariffsDayGetEditMask(Sender: TObject; ACol, ARow: Integer; var Value: String);
    procedure BasicTariffs(stgTariffs: TStringGrid);
    procedure ClearTariffs(fAll: boolean);
    procedure ClearPublic;
    function  ShowEmptyTariff(stT: string): string;
    function  HideEmptyTariff(stT: string): string;
    function  TestTariff(StringGrid: TStringGrid; x: word): boolean;
    procedure CopyTariff(ibMin: byte; ibMax: byte);
    procedure Tariffs(stgTariffs: TStringGrid);
    procedure AllTariffs(stgAllTariffs: TStringGrid);
    procedure btbGetAllTariffsClick(Sender: TObject);
    procedure btbSetAllTariffsClick(Sender: TObject);
    procedure btbSetTariffClick(Sender: TObject);
    procedure btbClearTariffsClick(Sender: TObject);
    procedure btbMonth1Y1Click(Sender: TObject);
    procedure btbMonth2Y1Click(Sender: TObject);
    procedure btbMonth3Y1Click(Sender: TObject);
    procedure btbMonth4Y1Click(Sender: TObject);
    procedure btbMonth5Y1Click(Sender: TObject);
    procedure btbMonth6Y1Click(Sender: TObject);
    procedure btbMonth7Y1Click(Sender: TObject);
    procedure btbMonth8Y1Click(Sender: TObject);
    procedure btbMonth9Y1Click(Sender: TObject);
    procedure btbMonth10Y1Click(Sender: TObject);
    procedure btbMonth11Y1Click(Sender: TObject);
    procedure btbMonth12Y1Click(Sender: TObject);
    procedure btbQuarter1Y1Click(Sender: TObject);
    procedure btbQuarter2Y1Click(Sender: TObject);
    procedure btbQuarter3Y1Click(Sender: TObject);
    procedure btbQuarter4Y1Click(Sender: TObject);
    procedure btbYearY1Click(Sender: TObject);
    procedure btbGetPublicClick(Sender: TObject);
    procedure btbSetPublicClick(Sender: TObject);
    procedure tlbConsoleClick(Sender: TObject);
    procedure SaveTariff(StringGrid: TStringGrid; x,y: word);
    procedure rgrPublicClick(Sender: TObject);
    procedure stgDigitalsGetEditMask(Sender: TObject; ACol, ARow: Integer; var Value: String);
    procedure stgDigitalsSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure stgDigitalsKeyPress(Sender: TObject; var Key: Char);
    procedure stgDigitalsClick(Sender: TObject);
    procedure stgDigitalsDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure ClearDigitals;
    procedure ClearCanals;
    procedure ClearParams1;
    procedure ClearParams2;
    procedure ClearGroups;
    function GetInterval(i: byte): string;
    procedure ClearGraphInquiry;
    procedure ClearGraphCorrect;
    procedure ClearGraphRecalc;
    procedure ClearGraphTransit;
    procedure ClearPhones;
    procedure ClearAddresses;
    procedure ClearAddresses2;
    procedure ClearCanalsNames;
    procedure ClearGroupsNames;
    procedure MakeDigital(y: word);
    procedure MakeCanal(y: word);
    procedure MakeParams1(y: word);
    procedure MakeParams2(y: word);
    procedure MakeGroup(y: word);
    procedure DigitalsCmbDevices;
    procedure HideDigitalsCmb;
    procedure ParamsCmbDevices;
    procedure ParamsCmbLines;
    procedure HideParamsCmb;
    procedure DigitalsGridDrawCell(Grid: TStringGrid; Col, Row: Integer; Rect: TRect);
    procedure cmbGridDevicesDigChange(Sender: TObject);
    procedure cmbGridDevicesDigExit(Sender: TObject);
    procedure btbImportCanalsClick(Sender: TObject);
    procedure btbExportCanalsClick(Sender: TObject);
    procedure btbClearCanalsClick(Sender: TObject);
    procedure stgDigitalsSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: String);
    procedure btbSetDigitalsClick(Sender: TObject);
    procedure btbGetDigitalsClick(Sender: TObject);
    procedure SaveGrid(Grid: TStringGrid; stName,stPath: string; Table: tables);
    function  LoadRecord(stRecord: string; wPos: word): string;
    function  LoadRecordPar(stRecord: string; wPos: word): string;
    function  LoadRecordGrp(stRecord: string; wPos: word): string;
    function  LoadRecordPho(stRecord: string; wPos: word): string;
    function  LoadRecordGra(stRecord: string; wPos: word): string;
    function  ImportCanals(FileName: string): boolean;
    function  ImportParams(FileName: string): boolean;
    function  ImportGroups(FileName: string): boolean;
    function  ImportPhones(FileName: string): boolean;
    function  ImportAddresses(FileName: string): boolean;
    function  ImportAddresses2(FileName: string): boolean;
    function  ImportGraphInquiry(FileName: string): boolean;
    function  ImportGraphCorrect(FileName: string): boolean;
    function  ImportGraphRecalc(FileName: string): boolean;
    function  ImportGraphTransit(FileName: string): boolean;
    function  ImportCanalsNames(FileName: string): boolean;
    function  ImportGroupsNames(FileName: string): boolean;
    procedure btbExportTariffsClick(Sender: TObject);
    procedure SaveAllTariffsGrid(stgTariff: TStringGrid; stName: string);
    procedure SaveTariffGrid(stgTariff: TStringGrid; stName: string);
    procedure mniTestFlowClick(Sender: TObject);
    procedure mniRunFlowClick(Sender: TObject);
    procedure mniCloseFlowClick(Sender: TObject);
    procedure btbImportTariffsClick(Sender: TObject);
    function  LoadRecordTariff(stRecord: string; wPos: word): string;
    procedure LoadGridTariff(stgTariff: TStringGrid; stRecord: string; x: byte);
    function  ImportTariffs(FileName: string): boolean;
    procedure rgrTAPIClick(Sender: TObject);
    procedure btbSelectDeviceClick(Sender: TObject);
    procedure btbShowConfigDialogClick(Sender: TObject);
    procedure btbDialClick(Sender: TObject);
    procedure VisibleAll(bTag: byte; fVisible: boolean);
    procedure miniDigitalsClick(Sender: TObject);
    procedure mniTariffsClick(Sender: TObject);
    procedure mitVersionClick(Sender: TObject);
    procedure mniGroupsClick(Sender: TObject);
    procedure btbGetGroupsClick(Sender: TObject);
    procedure btbClearGroupsClick(Sender: TObject);
    procedure stgGroupsDblClick(Sender: TObject);
    procedure btbSetGroupsClick(Sender: TObject);
    procedure SaveGroups(y: word);
    procedure SavePhones(y: word);
    procedure SaveAddresses(y: word);
    procedure SaveAddresses2(y: word);
    procedure SaveCanalsNames(y: word);
    procedure SaveGroupsNames(y: word);
    procedure btbExportGroupsClick(Sender: TObject);
    procedure btbImportGroupsClick(Sender: TObject);
    procedure Capacity;
    procedure mniPhonesClick(Sender: TObject);
    procedure btbGetPhonesClick(Sender: TObject);
    procedure btbSetPhonesClick(Sender: TObject);
    procedure btbClearPhonesClick(Sender: TObject);
    procedure stgPhonesGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btbExportPhonesClick(Sender: TObject);
    procedure btbImportPhonesClick(Sender: TObject);
    procedure NormalMode;
    procedure mniParamsClick(Sender: TObject);
    procedure btbGetParamsClick(Sender: TObject);
    procedure btbSetParamsClick(Sender: TObject);
    procedure btbImportParamsClick(Sender: TObject);
    procedure btbExportParamsClick(Sender: TObject);
    procedure btbClearParamsClick(Sender: TObject);
    procedure stgParamsClick(Sender: TObject);
    procedure stgParamsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure stgParamsGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure stgParamsKeyPress(Sender: TObject; var Key: Char);
    procedure stgParamsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure stgParamsSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure cmbGridDevicesParChange(Sender: TObject);
    procedure cmbGridDevicesParExit(Sender: TObject);
    procedure btbResetDividClick(Sender: TObject);
    procedure mniRecordsClick(Sender: TObject);
    procedure btbGetRecordsClick(Sender: TObject);
    procedure btbSaveRecordsClick(Sender: TObject);
    procedure btbClearRecordsClick(Sender: TObject);
    procedure chbLevelClick(Sender: TObject);
    procedure btbCancelCallClick(Sender: TObject);
    procedure btbGetAddressesClick(Sender: TObject);
    procedure btbSetAddressesClick(Sender: TObject);
    procedure btbImportAddressesClick(Sender: TObject);
    procedure btbExportAddressesClick(Sender: TObject);
    procedure btbClearAddressesClick(Sender: TObject);
    procedure stgAddressesGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure mniAddressesClick(Sender: TObject);
    procedure ClearRelaxs;
    procedure ShowRelaxs;
    procedure AddRelax(bo: boolean);
    procedure btbRelaxsAddHolidayClick(Sender: TObject);
    procedure btbRelaxsClearAllDaysClick(Sender: TObject);
    procedure btbRelaxsAddWeekdayClick(Sender: TObject);
    procedure btbGetRelaxsClick(Sender: TObject);
    procedure btbRelaxsClearClick(Sender: TObject);
    procedure btbSetRelaxsClick(Sender: TObject);
    function RelaxDate: times;
    procedure btbRelaxsClearDayClick(Sender: TObject);
    procedure btbExportRelaxsClick(Sender: TObject);
    function ImportRelaxs(FileName: string): boolean;
    procedure btbImportRelaxsClick(Sender: TObject);
    procedure btbSetTime1Click(Sender: TObject);
    procedure btbGetTimeClick(Sender: TObject);
    procedure btbSetTime2Click(Sender: TObject);
    procedure btbClearTimeClick(Sender: TObject);
    procedure SaveMemo(Memo: TMemo; stName: string);
    procedure SaveLog(Memo: TMemo; stName: string);
    procedure IdTCPClientConnected(Sender: TObject);
    procedure IdTCPClientDisconnected(Sender: TObject);
    procedure IdTCPClientStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
    procedure IdTCPClientWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure IdTCPClientWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure IdTCPClientWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure pgcModeChange(Sender: TObject);
    procedure btbSocketOpenClick(Sender: TObject);
    procedure btbSocketCloseClick(Sender: TObject);
    procedure btbClearTerminalClick(Sender: TObject);
    procedure btbExportTerminalClick(Sender: TObject);
    procedure btbClearGraphInquiryClick(Sender: TObject);
    procedure btbClearGraphCorrectClick(Sender: TObject);
    procedure btbClearGraphRecalcClick(Sender: TObject);
    procedure btbGetGraphCorrectClick(Sender: TObject);
    procedure btbGetGraphRecalcClick(Sender: TObject);
    procedure btbGetGraphInquiryClick(Sender: TObject);
    procedure btbSaveGraphCorrectClick(Sender: TObject);
    procedure btbSaveGraphInquiryClick(Sender: TObject);
    procedure btbSaveGraphRecalcClick(Sender: TObject);
    procedure btbLoadGraphCorrectClick(Sender: TObject);
    procedure GraphDblClick(StringGrid: TStringGrid);
    procedure stgGraphInquiryDblClick(Sender: TObject);
    procedure stgGraphCorrectDblClick(Sender: TObject);
    procedure stgGraphRecalcDblClick(Sender: TObject);
    procedure btbLoadGraphInquiryClick(Sender: TObject);
    procedure btbLoadGraphRecalcClick(Sender: TObject);
    procedure btbSetGraphCorrectClick(Sender: TObject);
    procedure btbSetGraphRecalcClick(Sender: TObject);
    procedure btbSetGraphInquiryClick(Sender: TObject);
    procedure cmbGridLinesParChange(Sender: TObject);
    procedure cmbGridLinesParExit(Sender: TObject);
    procedure btbGetCanalsNamesClick(Sender: TObject);
    procedure btbSetCanalsNamesClick(Sender: TObject);
    procedure btbImportCanalsNamesClick(Sender: TObject);
    procedure btbExportCanalsNamesClick(Sender: TObject);
    procedure btbClearCanalsNamesClick(Sender: TObject);
    procedure btbGetGroupsNamesClick(Sender: TObject);
    procedure btbSetGroupsNamesClick(Sender: TObject);
    procedure btbClearGroupsNamesClick(Sender: TObject);
    procedure btbGetObjectNameClick(Sender: TObject);
    procedure btbSetObjectNameClick(Sender: TObject);
    procedure btbClearObjectNameClick(Sender: TObject);
    procedure btbExportGroupsNamesClick(Sender: TObject);
    procedure btbImportGroupsNamesClick(Sender: TObject);
    procedure mniRelaxsClick(Sender: TObject);
    procedure mniGraphsClick(Sender: TObject);
    procedure mniCorrect2Click(Sender: TObject);
    procedure mniNamesClick(Sender: TObject);
    procedure btbGetGraphTransitClick(Sender: TObject);
    procedure btbSetGraphTransitClick(Sender: TObject);
    procedure btbLoadGraphTransitClick(Sender: TObject);
    procedure btbSaveGraphTransitClick(Sender: TObject);
    procedure btbClearGraphTransitClick(Sender: TObject);
    procedure stgGraphTransitDblClick(Sender: TObject);
    procedure btbGetAddresses2Click(Sender: TObject);
    procedure btbSetAddresses2Click(Sender: TObject);
    procedure btbImportAddresses2Click(Sender: TObject);
    procedure btbExportAddresses2Click(Sender: TObject);
    procedure btbClearAddresses2Click(Sender: TObject);
    procedure IdTCPClientSocketAllocated(Sender: TObject);
    procedure IdTCPClientAfterBind(Sender: TObject);
    procedure IdTCPClientBeforeBind(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSocketInputThread = class(TThread)
  private
    sBuff:    string;
    sCurr:    string;
    procedure HandleInput;
  protected
    procedure Execute; override;
  public
    function Data: string;
  end;

var
  frmMain:              TfrmMain;
  SocketInputThread:    TSocketInputThread;

  FIni:                 TIniFile;
  stIni:                string;

  FOutput:              text;

  fAdmin:               boolean;

  stZone:               zones;
//  stRelaxs:             relaxs;

  iwAlfa:               word;

  cbMaxRepeat,
  cbRepeat:             byte;

implementation

uses support, sinput, soutput, terminal, console, load, _sreal, _relax;

{$R *.DFM}

procedure TSocketInputThread.HandleInput;
var
  cwIn, cwMax: word;
begin
  with frmMain do begin
    timTimeout.Enabled := False;
    timTimeout.Enabled := True;

    cwIn := Length(sBuff);
    sCurr := sCurr + sBuff;

    if system1 = system_esc then cwMax := queQueryEsc.cwIn else cwMax := queQueryCRC.cwIn;
    AddTerminalTime('// ������� ' + IntToStr(cwIn) + ' ���� (�������� ' + IntToStr(Length(sCurr)) + ' �� ' + IntToStr(cwMax) + ' ����)',clGray);

    if Length(sCurr) >= cwMax then begin
      PostInputSocket(sCurr);
      sCurr := '';
    end;
  end;
end;

procedure TSocketInputThread.Execute;
begin
  with frmMain do begin
    while not Terminated do begin
        if not frmMain.IdTCPClient.Connected then
          Terminate
        else
          try
            if not IdTCPClient.IOHandler.InputBufferIsEmpty then begin
              sBuff := IdTCPClient.IOHandler.InputBufferAsString(Indy8BitEncoding);
              Synchronize(HandleInput);
            end;
          except
        end;
    end;
  end;
end;

function TSocketInputThread.Data: string;
begin
  Result := sCurr;
end;

procedure TfrmMain.ShowConnect;
begin
//  with ComPort do
//    stbMain.Panels[panCONNECT].Text := ' COM' + IntToStr(ComNumber) + ': ' + IntToStr(Baud) + ', ' + GetParityStr;
end;

procedure TfrmMain.SetComNumber(wComNumber: word);
begin
  try
    with ComPort do ComNumber := wComNumber;
    ShowConnect;
  except
    ErrBox('������ ��� ��������� ������ �����: COM' + IntToStr(wComNumber));
  end;
end;

procedure TfrmMain.SetBaud(dwBaud: longword);
begin
  try
    with ComPort do begin
//      AutoOpen := False;

      Baud := dwBaud;
//      Open := True;
    end;

    ShowConnect;
  except
    ErrBox('������ ��� ��������� �������� ������: ' + IntToStr(dwBaud) + ' ���');
  end;
end;

procedure TfrmMain.SetParity(ibParity: byte);
begin
  try
    with ComPort do case ibParity of
      1:   Parity := pEven;
      2:   Parity := pOdd;
      3:   Parity := pMark;
      4:   Parity := pSpace;
      else Parity := pNone;
    end;

    ShowConnect;
  except
    ErrBox('������ ��� ���������� �������� ��������: ' + GetParityStr);
  end;
end;

function TfrmMain.GetParity: byte;
begin
  with ComPort do case Parity of
    pEven:  Result := 1;
    pOdd:   Result := 2;
    pMark:  Result := 3;
    pSpace: Result := 4;
    else    Result := 0;
  end;
end;

function TfrmMain.GetParityStr: string;
begin
  with ComPort do case Parity of
    pEven:  Result := 'even';
    pOdd:   Result := 'odd';
    pMark:  Result := 'mark';
    pSpace: Result := 'space';
    else    Result := 'none';
  end;
end;

function TfrmMain.GetTimeout: word;
begin
  if (pgcMode.ActivePage = tbsPort) then
    Result := updTimeoutPort.Position
  else if (pgcMode.ActivePage = tbsModem) then
    Result := updTimeoutModem.Position
  else begin
    Result := updTimeoutSocket.Position;
  end;
end;

procedure TfrmMain.cmbComNumberChange(Sender: TObject);
begin
  inherited;
  try
    with cmbComNumber do SetComNumber(ItemIndex+1);
  except
    ErrBox('��������� ������ ��� ��������� ������ ����� !');
  end;
end;

procedure TfrmMain.cmbBaudChange(Sender: TObject);
begin
  inherited;
  try
    with cmbBaud do SetBaud( GetBaudSize(ItemIndex) );
  except
    ErrBox('��������� ������ ��� ��������� �������� ������ !');
  end;
end;

procedure TfrmMain.cmbParityChange(Sender: TObject);
begin
  inherited;
  try
    with cmbParity do SetParity(ItemIndex);
  except
    ErrBox('��������� ������ ��� ��������� �������� �������� !');
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  inherited;
  LoadCmbBauds(cmbBaud.Items);
  LoadCmbParitys(cmbParity.Items);

  try
    stIni := ChangeFileExt(ParamStr(0),'.ini');
    FileSetAttr(stIni, FileGetAttr(stIni) and not faReadOnly);
  except
  end;

  try
    FIni := TIniFile.Create(ChangeFileExt(ParamStr(0),'.ini'));

    with FIni do begin
      SetComNumber(ReadInteger(COM_PORT, NUMBER, 1));
      SetBaud(ReadInteger(COM_PORT, BAUD, 9600));
      SetParity(ReadInteger(COM_PORT, PARITY, 0));
      updTimeoutPort.Position := ReadInteger(COM_PORT, TIMEOUT, 1000);

      edtDial.Text := ReadString(MODEM, DIAL, '');
      TapiDevice.SelectedDevice := ReadString(MODEM, DEVICE, '');
      updTimeoutModem.Position := ReadInteger(MODEM, TIMEOUT, 4000);
      ShowSelectedDevice;

      edtSocketHost.Text := ReadString(SOCKET, HOST, '');
      edtSocketPort.Text := ReadString(SOCKET, PORT, '');
      updTimeoutSocket.Position := ReadInteger(SOCKET, TIMEOUT, 5000);

      updAddress.Position := ReadInteger(SETTING, ADDRESS, 0);
      rgrPacket.ItemIndex := ReadInteger(SETTING, PACKET, 1);

      pgcMode.TabIndex := FIni.ReadInteger(SETTING, MODE, 0);
      pgcModeChange(nil);

      Stop;
      
    end;
  except
    ErrBox('������ ��� ������ �������� ��������� !');
  end;

  with ComPort do begin
    if (ComNumber < 1) or (ComNumber > 16) then begin
      ErrBox('��������� ����� �����: COM' + IntToStr(ComNumber));
      ComNumber := 1;
    end;
    cmbComNumber.ItemIndex := ComNumber-1;

    if cmbBaud.Items.IndexOf( IntToStr(Baud) ) = -1 then begin
      ErrBox('��������� �������� ������: ' + IntToStr(Baud)  + ' ���');
      Baud := 9600;
    end;
    cmbBaud.ItemIndex := cmbBaud.Items.IndexOf( IntToStr(Baud) );
  end;

  cmbParity.ItemIndex := GetParity;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  inherited;
  if (Word(GetKeyState(VK_SHIFT)) and $8000) <> 0 then fAdmin := True;

  if fAdmin then InfBox('��������� �������� � ������ ��������������');

  VisibleAll(1,fAdmin);

    with ComPort do begin
 {   try
      stT := ExtractFileDir(ParamStr(0)) + stLOGS;
      ForceDirectories(stT);

      LogName   := stT + '\' + ChangeFileExt(ParamStr(0),'.log');
      TraceName := stT + '\' + ChangeFileExt(ParamStr(0),'.trc');
    except
    end; }

    if fAdmin then begin
      Tracing := tlOn;
      Logging := tlOn;
    end
    else begin
      Tracing := tlOff;
      Logging := tlOff;
    end;
  end;

  with stgDigitals.Rows[0] do begin
    Strings[digNUMBER]  := ' � ';
    Strings[digPORT]    := ' ����';
    Strings[digPHONE]   := ' �������';
    Strings[digDEVICE]  := ' ����������';
    Strings[digADDRESS] := ' �����';
    Strings[digLINE]    := ' �����';

    Strings[digSHORT]   := '';

    Strings[digTRANS]   := ' � ������.';
    Strings[digPULSE]   := ' � ������.';
    Strings[digLOSSE]   := ' � ������,%';
    Strings[digCOUNT]   := ' ��������';
    Strings[digLEVEL]   := ' � �������.';
  end;

  with stgParams.Rows[0] do begin
    Strings[digNUMBER]  := ' � ';
    Strings[digPORT]    := ' ����';
    Strings[digPHONE]   := ' �������';
    Strings[digDEVICE]  := ' ����������';
    Strings[digADDRESS] := ' �����';
    Strings[digLINE]    := ' ���';

    Strings[digSHORT]   := '';

    Strings[digDIVID]   := ' � ������.';
  end;

  SetActivePage(tbsFirst);
  Capacity;

  WindowState := wsMaximized;

  pgcAddresses.ActivePage := tbsAddresses1;
  pgcGraphs.ActivePage := tbsGraphInquiry;
  pgcNames.ActivePage := tbsObjectName;
end;

procedure TfrmMain.Capacity;
var
  i:  word;
begin
  stgDigitals.RowCount := bCANALS+1;
  ClearDigitals;
  ClearCanals;

  stgParams.RowCount := wPARAMS+1;
  ClearParams1;
  ClearParams2;

  with stgGroups do begin
    RowCount := bGROUPS + 1;
    ColCount := bCANALS + 1;

    for i := 1 to bGROUPS do with Cols[0] do
      Strings[i] := ' ������: ' + IntToStr(i);

    for i := 1 to bCANALS do with Rows[0] do
      Strings[i] := ' ' + IntToStr(i);
  end;
  ClearGroups;

  with stgPhones do begin
    RowCount := bCANALS + 1;
    ColCount := 1 + 1;

    for i := 1 to bCANALS do with Cols[0] do
      Strings[i] := ' ' + IntToStr(i);

    Rows[0].Strings[1] := ' ��������';
  end;
  ClearPhones;

  with stgAddresses do begin
    RowCount := bCANALS + 1;
    ColCount := 1 + 2;

    for i := 1 to bCANALS do with Cols[0] do
      Strings[i] := ' ' + IntToStr(i);

    Rows[0].Strings[1] := ' ������';
    Rows[0].Strings[2] := ' �������� ������';
  end;
  ClearAddresses;

  with stgAddresses2 do begin
    RowCount := bCANALS + 1;
    ColCount := 1 + 2;

    for i := 1 to bCANALS do with Cols[0] do
      Strings[i] := ' ' + IntToStr(i);

    Rows[0].Strings[1] := ' ������';
    Rows[0].Strings[2] := ' ���������� ������';
  end;
  ClearAddresses2;

  ClearGraphInquiry;
  ClearGraphCorrect;
  ClearGraphRecalc;
  ClearGraphTransit;

  with stgCanalsNames do begin
    RowCount := bCANALS + 1;
    ColCount := 1 + 1;

    for i := 1 to bCANALS do with Cols[0] do
      Strings[i] := ' ' + IntToStr(i);

    Rows[0].Strings[1] := ' ������';
  end;
  ClearCanalsNames;

  with stgGroupsNames do begin
    RowCount := bGROUPS + 1;
    ColCount := 1 + 1;

    for i := 1 to bGROUPS do with Cols[0] do
      Strings[i] := ' ' + IntToStr(i);

    Rows[0].Strings[1] := ' ������';
  end;
  ClearGroupsNames;

  LoadCmbDevices(cmbGridDevicesDig.Items);
  cmbGridDevicesDig.Visible := False;

  LoadCmbDevices(cmbGridDevicesPar.Items);
  cmbGridDevicesPar.Visible := False;

  LoadCmbLines(cmbGridLinesPar.Items);
  cmbGridLinesPar.Visible := False;

  ClearTerminal;
  ClearPublic;
  ClearTariffs(True);

  Tariffs(stgTariffsDay);

  AllTariffs(stgAllTariffsPow);
  AllTariffs(stgAllTariffsEng);
  AllTariffs(stgAllTariffsPub);

  InitQuerysCRC;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  inherited;
  Stop;

  try
    with FIni do begin
      WriteInteger(COM_PORT, NUMBER, ComPort.ComNumber);
      WriteInteger(COM_PORT, BAUD, ComPort.Baud);
      WriteInteger(COM_PORT, PARITY, GetParity);
      WriteInteger(COM_PORT, TIMEOUT, updTimeoutPort.Position);

      WriteString(MODEM, DIAL, edtDial.Text);
      WriteString(MODEM, DEVICE, TapiDevice.SelectedDevice);
      WriteInteger(MODEM, TIMEOUT, updTimeoutModem.Position);

      WriteString(SOCKET, HOST, edtSocketHost.Text);
      WriteString(SOCKET, PORT, edtSocketPort.Text);
      WriteInteger(SOCKET, TIMEOUT, updTimeoutSocket.Position);
      WriteString(SOCKET, VERSION, '2');

      WriteInteger(SETTING, MODE, pgcMode.ActivePageIndex);
      WriteInteger(SETTING, ADDRESS, updAddress.Position);
      WriteInteger(SETTING, PACKET, rgrPacket.ItemIndex);
    end;
  except
    ErrBox('������ ��� ������ �������� ��������� !');
  end;
end;

procedure TfrmMain.ComPortTriggerAvail(CP: TObject; Count: Word);
begin
  inherited;
  if chbBulk.Checked then
    AddTerminal('// �������� ' + IntToStr(ComPort.InBuffUsed) + ' ����; ' + Time2Str ,clGray);

  timTimeout.Enabled := False;    // ���������� �������
  timTimeout.Enabled := True;

  with ComPort do begin
    if system1 = system_esc then begin
      if InBuffUsed >= queQueryEsc.cwIn then begin
        ComTerminal('// ���� �� ���������� ����: ' + IntToStr(InBuffUsed) + ' �� ' + IntToStr(queQueryEsc.cwIn));
        PostInputComPort;
      end;
    end
    else begin
      if InBuffUsed >= queQueryCRC.cwIn then begin
        ComTerminal('// ���� �� ���������� ����: ' + IntToStr(InBuffUsed) + ' �� ' + IntToStr(queQueryCRC.cwIn));
        PostInputComPort;
      end;
    end;
  end;
end;
{
procedure TfrmMain.ComPortTriggerData(CP: TObject; TriggerHandle: Word);
begin
  inherited;
  timTimeout.Enabled := False;

  ComTerminal('// ���� �� ��������');
  PostInputComPort;
end;
}
procedure TfrmMain.timTimeoutTimer(Sender: TObject);
begin
  inherited;
  timTimeout.Enabled := False;

  ComTerminal('// ���� �� ��������: ' + IntToStr(GetTimeout) + ' ��');
  
  if (pgcMode.ActivePage = tbsPort) or (pgcMode.ActivePage = tbsModem) then
    PostInputComPort
  else begin
    if SocketInputThread <> nil then PostInputSocket(SocketInputThread.Data);
  end;
end;

procedure TfrmMain.ClearDigitals;
var
  i:    word;
begin
  ClearGrid(stgDigitals,True);

  for i := 0 to bCANALS-1 do with mpDigitals[i] do begin
    ibPort   := 0;
    ibPhone  := 0;
    bDevice  := 0;
    bAddress := 0;
    ibLine   := 0;

    MakeDigital(i);
  end;
end;

procedure TfrmMain.ClearCanals;
var
  i:    word;
begin
  for i := 0 to bCANALS-1 do with mpCanals[i] do begin
    exKtrans := 1;
    exKpulse := 1;
    exKlosse := 0;
    exKcount := 0;
    exKlevel := 1;

    MakeCanal(i);
  end;
end;

procedure TfrmMain.ClearParams1;
var
  i:    word;
begin
  ClearGrid(stgParams,True);

  for i := 0 to wPARAMS-1 do with mpParams1[i] do begin
    ibPort   := 0;
    ibPhone  := 0;
    bDevice  := 0;
    bAddress := 0;
    ibLine   := 0;

    MakeParams1(i);
  end;
end;

procedure TfrmMain.ClearParams2;
var
  i:    word;
begin
  for i := 0 to wPARAMS-1 do with mpParams2[i] do begin
    exKdivid := 1;

    MakeParams2(i);
  end;
end;

procedure TfrmMain.ClearGroups;
var
  x,y:  word;
begin
  for y := 0 to bGROUPS-1 do begin
    for x := 0 to bCANALS-1 do mpbGroups[y,x] := 0;

    MakeGroup(y);
  end;
end;

procedure TfrmMain.ClearPhones;
var
  y:  word;
begin
  for y := 1 to bCANALS do with stgPhones.Cols[1] do
    Strings[y] := ' 0';
end;

procedure TfrmMain.ClearAddresses;
var
  y:  word;
begin
  for y := 1 to bCANALS do with stgAddresses.Rows[y] do begin
    Strings[1] := ' 0';
    Strings[2] := ' 0';
  end;
end;

procedure TfrmMain.ClearAddresses2;
var
  y:  word;
begin
  for y := 1 to bCANALS do with stgAddresses2.Rows[y] do begin
    Strings[1] := ' 0';
    Strings[2] := '';
  end;
end;

procedure TfrmMain.ClearCanalsNames;
var
  y:  word;
begin
  for y := 1 to bCANALS do with stgCanalsNames.Cols[1] do
    Strings[y] := ' ����� ' + IntToStr(y);
end;

procedure TfrmMain.ClearGroupsNames;
var
  y:  word;
begin
  for y := 1 to bGROUPS do with stgGroupsNames.Cols[1] do
    Strings[y] := ' ������ ' + IntToStr(y);
end;

procedure TfrmMain.MakeDigital(y: word);
begin
  with stgDigitals.Rows[y+1],mpDigitals[y] do begin

    Strings[digPORT]    := ' ' + IntToStr(ibPort);
    Strings[digPHONE]   := ' ' + IntToStr(ibPhone);
    Strings[digDEVICE]  := ' ' + GetDeviceName(bDevice);
    Strings[digADDRESS] := ' ' + IntToStr(bAddress);
    Strings[digLINE]    := ' ' + IntToStr(ibLine);
  end;
end;

procedure TfrmMain.MakeCanal(y: word);
begin
  with stgDigitals.Rows[y+1],mpCanals[y] do begin

    Strings[digTRANS] := ' ' + UnpackStr(FloatToStrF(exKtrans,ffFixed,18,3));
    Strings[digPULSE] := ' ' + UnpackStr(FloatToStrF(exKpulse,ffFixed,18,3));
    Strings[digLOSSE] := ' ' + UnpackStr(FloatToStrF(exKlosse,ffFixed,18,3));
    Strings[digCOUNT] := ' ' + UnpackStr(FloatToStrF(exKcount,ffFixed,18,3));

    if chbLevel.Checked then
      Strings[digLEVEL] := ' ' + UnpackStr(FloatToStrF(exKlevel,ffFixed,18,3))
    else
      Strings[digLEVEL] := ' ';    
  end;
end;

procedure TfrmMain.MakeParams1(y: word);
begin
  with stgParams.Rows[y+1],mpParams1[y] do begin

    Strings[digPORT]    := ' ' + IntToStr(ibPort);
    Strings[digPHONE]   := ' ' + IntToStr(ibPhone);
    Strings[digDEVICE]  := ' ' + GetDeviceName(bDevice);
    Strings[digADDRESS] := ' ' + IntToStr(bAddress);
    Strings[digLINE]    := ' ' + GetNameByLine(ibLine);
  end;
end;

procedure TfrmMain.MakeParams2(y: word);
begin
  with stgParams.Rows[y+1],mpParams2[y] do begin

    Strings[digDIVID] := ' ' + UnpackStr(FloatToStrF(exKdivid,ffFixed,18,3));
  end;
end;

procedure TfrmMain.MakeGroup(y: word);
var
  x:    word;
begin
  with stgGroups.Rows[y+1] do begin
    for x := 0 to bCANALS-1 do begin
      if mpbGroups[y,x] = 1 then
        Strings[x+1] := ' +' + IntToStr(x+1)
      else if mpbGroups[y,x] = 2 then
        Strings[x+1] := ' -' + IntToStr(x+1)
      else
        Strings[x+1] := '';
    end;
  end;
end;

procedure TfrmMain.DigitalsCmbDevices;
begin
  with stgDigitals,cmbGridDevicesDig do begin
    if ItemIndex >= 0 then begin
      Cells[Col,Row] := Items[ItemIndex];
      mpDigitals[Row-1].bDevice := ItemIndex;
    end;
  end;

  cmbGridDevicesDig.Visible := False;
  stgDigitals.SetFocus;
end;

procedure TfrmMain.ParamsCmbDevices;
begin
  with stgParams,cmbGridDevicesPar do begin
    if ItemIndex >= 0 then begin
      Cells[Col,Row] := Items[ItemIndex];
      mpParams1[Row-1].bDevice := ItemIndex;
    end;
  end;

  cmbGridDevicesPar.Visible := False;
  stgParams.SetFocus;
end;

procedure TfrmMain.ParamsCmbLines;
begin
  with stgParams,cmbGridLinesPar do begin
    if ItemIndex >= 0 then begin
      Cells[Col,Row] := Items[ItemIndex];
      mpParams1[Row-1].ibLine := GetLineByIndex(ItemIndex);
    end;
  end;

  cmbGridLinesPar.Visible := False;
  stgParams.SetFocus;
end;

procedure TfrmMain.timNowTimer(Sender: TObject);
begin
  inherited;
  stbMain.Panels[panTIMEDATE].Text := ' ' + FormatDateTime('hh:mm:ss dd.mm.yyyy',Now);
end;

procedure TfrmMain.ShowRepeat;
begin
  inherited;
  stbMain.Panels[panRepeat].Text := ' ������: ' + IntToStr(cbMaxRepeat);
end;

procedure TfrmMain.ClearGrid(Grid: TStringGrid; fNumbers: boolean);
var
  x,y:  word;
begin
  with Grid do begin
    for y := 1 to RowCount-1 do with Rows[y] do begin
      for x := 0 to ColCount-1 do Strings[x] := '';
      if fNumbers then Strings[0] := ' ' + IntToStr(y);
    end;
  end;
end;

procedure TfrmMain.FormResize(Sender: TObject);
var
  i,j:  word;
begin
  inherited;
  with prbLoad do begin
    Top := stbMain.Top;

    j := 0;
    for i := 0 to panPROGRESS-1 do j := j + stbMain.Panels[i].Width;

    Left := j;
    Width := stbMain.Width - j;
  end;
end;

procedure TfrmMain.FocusTerminal;
begin
  {if chbTerminal.Checked then} begin
    try
      with redTerminal do if CanFocus and Visible then SetFocus;
    except
    end;
  end;
end;

procedure TfrmMain.ClearTerminal;
begin
  redTerminal.Clear;
end;

procedure TfrmMain.InsTerminal(stT: string; clOut: TColor);
begin
  {if chbTerminal.Checked then} begin
    try
      FocusTerminal;
      with redTerminal do begin
//        SelAttributes.Color := clOut;
        SelText := stT;
      end;
    except
    end;
  end;
end;

procedure TfrmMain.AddTerminal(stT: string; clOut: TColor);
begin
  {if chbTerminal.Checked then} begin
    try
      FocusTerminal;
      with redTerminal do begin
//        SelAttributes.Color := clOut;
        Lines.Append(stT);
      end;
    except
    end;
  end;

//  if clOut = clGray then  AddInfo(stT);
end;


procedure TfrmMain.AddTerminalTime(stT: string; clOut: TColor);
begin
  AddTerminal(stT + '   // ' + Time2Str, clOut);
end;

procedure TfrmMain.ComTerminal(stT: string);
//var
//  Charset: TFontCharset;
begin
  {if chbTerminal.Checked then} begin
    try
      FocusTerminal;
      with redTerminal do begin
//        SelAttributes.Color := clGray;

//        Charset := SelAttributes.CharSet;
//        SelAttributes.CharSet := RUSSIAN_CHARSET;
        Lines.Append(stT);
//        SelAttributes.CharSet := Charset;
      end;
    except
    end;
  end;
end;

procedure TfrmMain.ClearDial;
begin
  memDial.Clear;
end;

procedure TfrmMain.AddDial(stT: string);
begin
  try
    memDial.Lines.Append(stT);
  except
  end
end;

procedure TfrmMain.InsByte(bT: byte; clT: TColor);
begin
  InsTerminal(IntToHex(bT,2) + ' ', clT);
end;

procedure TfrmMain.SaveRich(Rich: TRichEdit; stName: string);
begin
  with sd_RichToFile,Rich do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stREPORTS;

      SysUtils.ForceDirectories(InitialDir);
      FileName := stName + '.rtf';

      if Execute then Rich.Lines.SaveToFile(FileName);
    except
      ErrBox('������ ��� ���������� ������ !')
    end;
  end;
end;

procedure TfrmMain.tlbStopClick(Sender: TObject);
begin
  inherited;
  CtrlZ; Stop;
end;

procedure TfrmMain.ShowSelectedDevice;
begin
  lblSelectedDevice.Caption := TapiDevice.SelectedDevice;
end;

procedure TfrmMain.TAPIoff;
begin
  inherited;
  try
    with ComPort do begin
      TapiMode := tmOff;

      AutoOpen := False;
      Open := True;
    end;
    ShowSelectedDevice;
  except
    ErrBox('������ ��� �������� ����� COM' + IntToStr(ComPort.ComNumber));
  end;
end;

procedure TfrmMain.TAPIon;
begin
  inherited;
  with ComPort do begin
    TapiMode := tmOn;

    AutoOpen := False;
    Open := False;
  end;
  ShowSelectedDevice;
end;

procedure TfrmMain.TapiDeviceTapiStatus(CP: TObject; First,
  Last: Boolean; Device, Message, Param1, Param2, Param3: Integer);
begin
  inherited;
  AddTerminal('OnTapiStatus event',clGray);

  if First then
    AddTerminal('First event',clGray)
  else if Last then
    AddTerminal('Last event',clGray)
  else with TapiDevice do begin
    AddTerminal('�������: ' + TapiStatusMsg(Message,Param1,Param2) + ' ' + Number,clGray);
    AddDial('�������: ' + TapiStatusMsg(Message,Param1,Param2) + ' ' + Number);
  end;
end;

procedure TfrmMain.TapiDeviceTapiLog(CP: TObject; Log: TTapiLogCode);
begin
  inherited;
//  AddTerminal('OnTapiLog event',clGray);
end;

procedure TfrmMain.TapiDeviceTapiPortOpen(Sender: TObject);
begin
  inherited;
  AddTerminal('OnTapiPortOpen event',clGray);
  AddDial('���� ������');
end;

procedure TfrmMain.TapiDeviceTapiPortClose(Sender: TObject);
begin
  inherited;
  AddTerminal('OnTapiPortClose event',clGray);
  AddDial('���� ������');
end;

procedure TfrmMain.TapiDeviceTapiConnect(Sender: TObject);
begin
  inherited;
  AddTerminal('OnTapiConnect event',clGray);

  with TapiDevice do begin
    AddTerminal('����������� ���������� �� �������� ' + IntToStr(BPSRate),clGray);
    AddDial('����������� ���������� �� �������� ' + IntToStr(BPSRate));

    InfBox('����������� ���������� �� �������� ' + IntToStr(BPSRate) + ' ���');
  end;
end;

procedure TfrmMain.TapiDeviceTapiFail(Sender: TObject);
begin
  inherited;
  AddTerminal('OnTapiFail event',clGray);

  with TapiDevice do begin
    AddTerminal('������: ' + FailureCodeMsg(FailureCode),clGray);
    AddDial('������: ' + FailureCodeMsg(FailureCode));

    InfBox('������: ' + FailureCodeMsg(FailureCode));
  end;
end;

procedure TfrmMain.tlbCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMain.ShowButtons;
begin
  with pgcMain do begin
    tlbPrev.Enabled := (ActivePage.PageIndex > tbsFirst.PageIndex);
    mniPrev.Enabled := (ActivePage.PageIndex > tbsFirst.PageIndex);

    tlbNext.Enabled := (ActivePage.PageIndex < tbsLast.PageIndex);
    mniNext.Enabled := (ActivePage.PageIndex < tbsLast.PageIndex);
  end;
end;

procedure TfrmMain.SetActivePage(TabSheet: TTabSheet);
begin
  with pgcMain do ActivePage := TabSheet;
  ShowButtons;
end;

procedure TfrmMain.tlbPrevClick(Sender: TObject);
begin
  inherited;
  with pgcMain do begin
    if ActivePage.PageIndex > tbsFirst.PageIndex then
      SetActivePage(Pages[ActivePage.PageIndex - 1]);
  end;
end;

procedure TfrmMain.tlbNextClick(Sender: TObject);
begin
  inherited;
  with pgcMain do begin
    if ActivePage.PageIndex < tbsLast.PageIndex then
      SetActivePage(Pages[ActivePage.PageIndex + 1]);
  end;
end;

procedure TfrmMain.mniPrevClick(Sender: TObject);
begin
  inherited;
  tlbPrevClick(nil);
end;

procedure TfrmMain.mniNextClick(Sender: TObject);
begin
  inherited;
  tlbNextClick(nil);
end;

procedure TfrmMain.pgcMainChange(Sender: TObject);
begin
  inherited;
  ShowButtons;
end;

procedure TfrmMain.mniFirstClick(Sender: TObject);
begin
  inherited;
  SetActivePage(tbsFirst);
end;

procedure TfrmMain.mniLastClick(Sender: TObject);
begin
  inherited;
  SetActivePage(tbsLast);
end;

procedure TfrmMain.miniDigitalsClick(Sender: TObject);
begin
  inherited;
  SetActivePage(tbsDigitals);
end;

procedure TfrmMain.mniGroupsClick(Sender: TObject);
begin
  inherited;
  SetActivePage(tbsGroups);
end;

procedure TfrmMain.mniTariffsClick(Sender: TObject);
begin
  inherited;
  SetActivePage(tbsTariffs);
end;

procedure TfrmMain.mniCloseClick(Sender: TObject);
begin
  inherited;
  tlbCloseClick(nil);
end;

procedure TfrmMain.mniStopClick(Sender: TObject);
begin
  inherited;
  tlbStopClick(nil);
end;

procedure TfrmMain.tlbEscAClick(Sender: TObject);
begin
  inherited;
  EscSearch(actEscA);
end;

procedure TfrmMain.stgTariffsDayGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  inherited;
  Value := ' 99:99 - 9;1; ';
end;

procedure TfrmMain.Tariffs(stgTariffs: TStringGrid);
begin
  with stgTariffs do begin
    RowCount := bBREAKS + 1;
    Rows[0].Strings[1] := ' �����';
  end;
end;

procedure TfrmMain.AllTariffs(stgAllTariffs: TStringGrid);
var
  i:      word;
begin
  with stgAllTariffs do begin
    RowCount := bBREAKS + 1;

    for i := 1 to ColCount do
      Rows[0].Strings[i] := ' ����� ' + IntToStr(i);
  end;
end;

procedure TfrmMain.BasicTariffs(stgTariffs: TStringGrid);
var
  y:    word;
begin
  with stgTariffs,Cols[1] do begin
    for y := 1 to RowCount - 1 do
      Strings[y] := ' 00:00 - 0';

    Strings[1] := ' 06:00 - 1';
    Strings[2] := ' 08:00 - 2';
    Strings[3] := ' 10:00 - 3';
    Strings[4] := ' 18:00 - 2';
    Strings[5] := ' 20:00 - 4';
    Strings[6] := ' 21:30 - 1';
  end;
end;

procedure TfrmMain.ClearTariffs(fAll: boolean);
begin
  if fAll then begin
    ClearGrid(stgAllTariffsPow,True);
    ClearGrid(stgAllTariffsEng,True);
    ClearGrid(stgAllTariffsPub,True);

    BasicTariffs(stgTariffsDay);
  end
  else with pgcTariffs do begin
    if ActivePage = tbsPow then
      ClearGrid(stgAllTariffsPow,True)
    else
    if ActivePage = tbsEng then
      ClearGrid(stgAllTariffsEng,True)
    else
      ClearGrid(stgAllTariffsPub,True);
  end;
end;

{}function TfrmMain.TestTariff(StringGrid: TStringGrid; x: word): boolean;
var
  i,y:  word;
  wT:   word;
  stT:  string;
begin
  Result := False;

  wT := 0;
  with stZone,StringGrid do begin
    bSize := 0;

    y := 0;
    try
      for i := 1 to RowCount - 1 do begin
        y := i;
        stT := StringGrid.Cols[x].Strings[i];
        stT := ShowEmptyTariff(stT);

        with mpTariffs[i] do begin
          bHour   := StrToInt( Copy(stT,2,2) );
          bMinute := StrToInt( Copy(stT,5,2) );
          bTariff := StrToInt( Copy(stT,10,1) );

          if (bHour > 24) or ((bMinute mod 30) <> 0) or
             ((bTariff = 0) and ((bHour <> 0) or (bMinute <> 0))) or
             (bTariff > 4) then
            raise EConvertError.Create('������ ��� ������� ������� !');

          if (bHour*60 + bMinute <= wT) and
             not((bTariff = 0) and (bHour = 0) and (bMinute = 0)) then
            raise EConvertError.Create('������ �������� ������� ������ ���� �� ����������� ������� !');

          wT := bHour*30 + bMinute;

          Inc(bSize);
        end;
      end;
    except
      Row := y;
      WrnBox('�������� ������ ����� ����������� !');
      Exit;
    end;
  end;

  Result := True;
end;

{}procedure TfrmMain.CopyTariff(ibMin: byte; ibMax: byte);
var
  x,y:  word;
begin
  if not TestTariff(stgTariffsDay,1) then Exit;

  for x := ibMin to ibMax do begin
    for y := 1 to stgTariffsDay.RowCount - 1 do begin
      if pgcTariffs.ActivePage = tbsPow then
        stgAllTariffsPow.Cols[x].Strings[y] := HideEmptyTariff(stgTariffsDay.Cols[1].Strings[y])
      else
      if pgcTariffs.ActivePage = tbsEng then
        stgAllTariffsEng.Cols[x].Strings[y] := HideEmptyTariff(stgTariffsDay.Cols[1].Strings[y])
      else
        stgAllTariffsPub.Cols[x].Strings[y] := HideEmptyTariff(stgTariffsDay.Cols[1].Strings[y]);
    end;
  end;
end;

procedure TfrmMain.btbGetAllTariffsClick(Sender: TObject);
begin
  inherited;
  NormalMode;
  
  ClearTariffs(False);

  with pgcTariffs do begin
    if (ActivePage = tbsPow) or (ActivePage = tbsEng) then begin
      ActivePage := tbsPow;

      iwAlfa := 0;
      InitPushCRC;
      Push(iwAlfa);
      Push(0);
      InitLoad('������ ���������� ������� ��� ��������', 12-1, crcGetOldPowTariff);
    end
    else begin
      iwAlfa := 0;
      InitPushCRC;
      Push(iwAlfa);
      Push(0);
      InitLoad('������ ����������� ������� ��� �������� � �������', 12-1, crcGetOldPubTariff);
    end;
  end;
end;

{}procedure TfrmMain.SaveTariff(StringGrid: TStringGrid; x,y: word);
var
  i:  word;
begin
  with StringGrid do begin
    InitPushCRC;
    Push(iwAlfa);
    Push(y);

//    for x := 1 to 12 do begin
      Col := x+1;
      if not TestTariff(StringGrid, x+1) then Exit;

      with stZone do begin
        Push(bSize);

        for i := 1 to 6 do begin
          with stZone.mpTariffs[i] do begin
            Push(bHour);
            Push(bMinute);

            if (bHour > 0) or (bMinute > 0) then Dec(bTariff);
            Push(bTariff);
          end;
        end;
//      end;
    end;

    Col := 1;
    Row := 1;
  end;
end;

procedure TfrmMain.btbSetAllTariffsClick(Sender: TObject);
begin
  inherited;
  NormalMode;
  
  with pgcTariffs do begin
    if (ActivePage = tbsPow) or (ActivePage = tbsEng) then begin
      ActivePage := tbsPow;

      iwAlfa := 0;
      SaveTariff(stgAllTariffsPow,iwAlfa,0);
      InitLoad('������ ���������� ������� ��� ��������', 12-1, acSetAllOldPowTariffs);
    end
    else begin
      iwAlfa := 0;
      SaveTariff(stgAllTariffsPub,iwAlfa,0);
      InitLoad('������ ����������� ������� ��� �������� � �������', 12-1, acSetAllOldPubTariffs);
    end;
  end;
{
  with pgcTariffs do begin
    if ActivePage = tbsPow then begin
      iwAlfa := stgAllTariffsPow.Col - 1;

      if Application.MessageBox(
           PChar('�������� ������ ��� �������� ��� ������ ' + IntToStr(iwAlfa+1) + ' ?'),
           '������',mb_IconQuestion + mb_YesNo + mb_DefButton1) = idYes then begin
        SaveTariff(stgAllTariffsPow,iwAlfa,0);
        QueryCRC(acSetOldPowTariff);
      end;
    end
    else
    if ActivePage = tbsEng then begin
      iwAlfa := stgAllTariffsEng.Col - 1;

      if Application.MessageBox(
           PChar('�������� ������ ��� ������� ��� ������ ' + IntToStr(iwAlfa+1) + ' ?'),
           '������',mb_IconQuestion + mb_YesNo + mb_DefButton1) = idYes then begin
        SaveTariff(stgAllTariffsEng,iwAlfa,0);
        QueryCRC(acSetOldEngTariff);
      end;
    end
    else begin
      iwAlfa := stgAllTariffsPub.Col - 1;

      if Application.MessageBox(
           PChar('�������� ����������� ������ ��� ������ ' + IntToStr(iwAlfa+1) + ' ?'),
           '������',mb_IconQuestion + mb_YesNo + mb_DefButton1) = idYes then begin
        SaveTariff(stgAllTariffsPub,iwAlfa,0);
        QueryCRC(acSetOldPubTariff);
      end;
    end;
  end;
}
end;

procedure TfrmMain.btbSetTariffClick(Sender: TObject);
begin
  inherited;
end;

{}procedure TfrmMain.btbClearTariffsClick(Sender: TObject);
begin
  inherited;
  ClearTariffs(False);
end;

{}procedure TfrmMain.btbMonth1Y1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(1,1);
end;

{}procedure TfrmMain.btbMonth2Y1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(2,2);
end;

{}procedure TfrmMain.btbMonth3Y1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(3,3);
end;

{}procedure TfrmMain.btbMonth4Y1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(4,4);
end;

{}procedure TfrmMain.btbMonth5Y1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(5,5);
end;

{}procedure TfrmMain.btbMonth6Y1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(6,6);
end;

{}procedure TfrmMain.btbMonth7Y1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(7,7);
end;

{}procedure TfrmMain.btbMonth8Y1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(8,8);
end;

{}procedure TfrmMain.btbMonth9Y1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(9,9);
end;

{}procedure TfrmMain.btbMonth10Y1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(10,10);
end;

{}procedure TfrmMain.btbMonth11Y1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(11,11);
end;

{}procedure TfrmMain.btbMonth12Y1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(12,12);
end;

{}procedure TfrmMain.btbQuarter1Y1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(1,3);
end;

{}procedure TfrmMain.btbQuarter2Y1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(4,6);
end;

{}procedure TfrmMain.btbQuarter3Y1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(7,9);
end;

{}procedure TfrmMain.btbQuarter4Y1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(10,12);
end;

{}procedure TfrmMain.btbYearY1Click(Sender: TObject);
begin
  inherited;
  CopyTariff(1,12);
end;

procedure TfrmMain.btbGetPublicClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  ClearPublic;
  QueryCRC(crcGetPublic);
end;

procedure TfrmMain.btbSetPublicClick(Sender: TObject);
begin
  inherited;
  NormalMode;
  
  try
    InitPushCRC;
    if rgrPublic.ItemIndex = 0 then Push($00) else Push($FF);
  except
    ErrBox('���� ������� ��� �������� � ������� ����� ����������� !');
    Exit;
  end;

  QueryCRC(crcSetPublic);
end;

procedure TfrmMain.ClearPublic;
begin
  rgrPublic.ItemIndex := -1;

  stgAllTariffsPow.Visible := False;
  stgAllTariffsEng.Visible := False;
  stgAllTariffsPub.Visible := False;
end;

function TfrmMain.ShowEmptyTariff(stT: string): string;
begin
  if Trim(stT) = '' then Result := ' 00:00 - 0' else Result := stT;
end;

function TfrmMain.HideEmptyTariff(stT: string): string;
begin
  if Trim(stT) = '00:00 - 0' then Result := '' else Result := stT;
end;

procedure TfrmMain.tlbConsoleClick(Sender: TObject);
begin
  inherited;
  if not Assigned(frmConsole) then frmConsole := TfrmConsole.Create(Self);
  frmConsole.Show;
end;

{}procedure TfrmMain.rgrPublicClick(Sender: TObject);
begin
  inherited;
  with pgcTariffs do begin
    Visible := True;

    if rgrPublic.ItemIndex = 0 then begin
      stgAllTariffsPow.Visible := True;
      stgAllTariffsEng.Visible := True;
      stgAllTariffsPub.Visible := False;

      ActivePage := tbsPow;
    end
    else begin
      stgAllTariffsPow.Visible := False;
      stgAllTariffsEng.Visible := False;
      stgAllTariffsPub.Visible := True;

      ActivePage := tbsPub;
    end;
  end;
end;

{}procedure TfrmMain.stgDigitalsGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  inherited;
  with stgDigitals do begin
    if ACol = digPORT then Value := ' c;1; '
    else
    if ACol = digPHONE then Value := ' cc;1; '
    else
    if ACol = digADDRESS then Value := ' ccc;1; '
    else
    if ACol = digLINE then Value := ' cc;1; '

    else
    if ACol in [digTRANS,digPULSE,digLOSSE,digCOUNT,digLEVEL] then Value := ' cccccccccc;1; ';
  end;
end;

{}procedure TfrmMain.stgDigitalsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  R:    TRect;
begin
  inherited;
  if ((ACol = digDEVICE) and (ARow <> 0)) then  begin
    R := stgDigitals.CellRect(ACol, ARow);

    R.Left   := R.Left    + stgDigitals.Left;
    R.Right  := R.Right   + stgDigitals.Left;
    R.Top    := R.Top     + stgDigitals.Top;
    R.Bottom := R.Bottom  + stgDigitals.Top;

    cmbGridDevicesDig.Left   := R.Left + 1;
    cmbGridDevicesDig.Top    := R.Top + 1;
    cmbGridDevicesDig.Width  := (R.Right + 1) - R.Left;
    cmbGridDevicesDig.Height := (R.Bottom + 1) - R.Top;

    cmbGridDevicesDig.ItemIndex := mpDigitals[ARow-1].bDevice;
    cmbGridDevicesDig.Visible   := True;
    cmbGridDevicesDig.SetFocus;
  end;
{  else
  if ((ACol = digENABLED) and (ARow <> 0)) then  begin
    R := stgDigitals.CellRect(ACol, ARow);

    R.Left   := R.Left    + stgDigitals.Left;
    R.Right  := R.Right   + stgDigitals.Left;
    R.Top    := R.Top     + stgDigitals.Top;
    R.Bottom := R.Bottom  + stgDigitals.Top;

    cmbGridEnabled.Left   := R.Left + 1;
    cmbGridEnabled.Top    := R.Top + 1;
    cmbGridEnabled.Width  := (R.Right + 1) - R.Left;
    cmbGridEnabled.Height := (R.Bottom + 1) - R.Top;

    cmbGridEnabled.ItemIndex := mpDigitals[Row-1].bEnabled;
    cmbGridEnabled.Visible   := True;
    cmbGridEnabled.SetFocus;
  end;
}
  CanSelect := True;
end;

{}procedure TfrmMain.HideDigitalsCmb;
begin
  cmbGridDevicesDig.Visible := False;
//  cmbGridEnabled.Visible := False;
end;

procedure TfrmMain.HideParamsCmb;
begin
  cmbGridDevicesPar.Visible := False;
//  cmbGridEnabled.Visible := False;
end;

{}procedure TfrmMain.stgDigitalsKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  with stgDigitals do
    if Col in [digDEVICE] then Key := #0;
end;

{}procedure TfrmMain.stgDigitalsClick(Sender: TObject);
var
  fT:   boolean;
begin
  inherited;
  with stgDigitals do
    if (Col in [digDEVICE]) and (Row > 0) then
      stgDigitalsSelectCell(nil,Col,Row,fT);
end;

{}procedure TfrmMain.DigitalsGridDrawCell(Grid: TStringGrid; Col, Row: Integer; Rect: TRect);
begin
  if (Col > 0) and (Row > 0) then begin
    with mpDigitals[Row-1] do begin
      if bDevice = 0 then
        Grid.Canvas.Font.Color := clSilver
      else
        Canvas.Font.Color := clBlack;

      Grid.Canvas.TextOut(Rect.Left+2, Rect.Top+2, Grid.Cells[Col,Row]);
    end;
  end;
end;

procedure TfrmMain.stgDigitalsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  inherited;
//  DigitalsGridDrawCell(stgDigitals, ACol,ARow, Rect);
end;

procedure TfrmMain.cmbGridDevicesDigChange(Sender: TObject);
begin
  inherited;
  DigitalsCmbDevices;
end;

procedure TfrmMain.cmbGridDevicesDigExit(Sender: TObject);
begin
  inherited;
  DigitalsCmbDevices;
end;

function TfrmMain.LoadRecord(stRecord: string; wPos: word): string;
var
  i,j:   word;
  stT:   string;
begin
  j := 1;

  if wPos > 0 then
    for i := 0 to wPos-1 do j := j + mpbDIGITALSSIZE[i];

  if wPos = sizeof(mpbDIGITALSSIZE)-1 then
    stT := Copy(stRecord,j,Length(stRecord)-j)
  else
    stT := Copy(stRecord,j,mpbDIGITALSSIZE[wPos]);

  Result := UnpackStr(stT);
end;

function TfrmMain.LoadRecordPar(stRecord: string; wPos: word): string;
var
  i,j:   word;
  stT:   string;
begin
  j := 1;

  if wPos > 0 then
    for i := 0 to wPos-1 do if i = 0 then Inc(j,bINDEXSIZE) else Inc(j,bPARAMSIZE);

  if wPos = 0 then
    stT := Copy(stRecord,j,bINDEXSIZE)
  else
    stT := Copy(stRecord,j,bPARAMSIZE);

  Result := UnpackStr(stT);
end;

function TfrmMain.LoadRecordGrp(stRecord: string; wPos: word): string;
var
  i,j:   word;
  stT:   string;
begin
  j := 1;

  if wPos > 0 then
    for i := 0 to wPos-1 do if i = 0 then Inc(j,bGROUPSSIZE) else Inc(j,bNODESSIZE);

  if wPos = 0 then
    stT := Copy(stRecord,j,bGROUPSSIZE)
  else
    stT := Copy(stRecord,j,bNODESSIZE);

  Result := UnpackStr(stT);
end;

function TfrmMain.LoadRecordPho(stRecord: string; wPos: word): string;
var
  i,j:   word;
  stT:   string;
begin
  j := 1;

  if wPos > 0 then
    for i := 0 to wPos-1 do if i = 0 then Inc(j,bINDEXSIZE) else Inc(j,bPHONESIZE);

  if wPos = 0 then
    stT := Copy(stRecord,j,bINDEXSIZE)
  else
    stT := Copy(stRecord,j,bPHONESIZE);

  Result := UnpackStr(stT);
end;

function TfrmMain.LoadRecordGra(stRecord: string; wPos: word): string;
var
  i,j:   word;
  stT:   string;
begin
  j := 1;

  if wPos > 0 then
    for i := 0 to wPos-1 do if i = 0 then Inc(j,bGRAPHSIZE) else Inc(j,bGRAPHSIZE);

  if wPos = 0 then
    stT := Copy(stRecord,j,bGRAPHSIZE)
  else
    stT := Copy(stRecord,j,bGRAPHSIZE);

  Result := UnpackStr(stT);
end;

function TfrmMain.ImportCanals(FileName: string): boolean;
var
  stT:    string;
  i,j:    word;
begin
  Result := False;

  try
    AssignFile(FOutput, FileName);
    Reset(FOutput);

    i := 0;
    while not Eof(FOutput) do with mpDigitals[i],mpCanals[i] do begin
      Readln(FOutput,stT);

      if (UnPackStr(stT) = '') or (Pos('\\',stT) = 1) then continue;
      if i >= bCANALS then break;

      if StrToIntDef(LoadRecord(stT,0),0) = 0 then continue;

      ibPort   := StrToInt(LoadRecord(stT,1));
      ibPhone  := StrToInt(LoadRecord(stT,2));

      bDevice := 0;
      for j := 0 to DEVICES-1 do begin
        if LoadRecord(stT,3) = UnpackStr(GetDeviceName(j)) then
        begin bDevice := j; break; end;
      end;

      bAddress := StrToInt(LoadRecord(stT,4));
      ibLine   := StrToInt(LoadRecord(stT,5));

      exKtrans := Str2Float(LoadRecord(stT,7));
      exKpulse := Str2Float(LoadRecord(stT,8));
      exKlosse := Str2Float(LoadRecord(stT,9));
      exKcount := Str2Float(LoadRecord(stT,10));

      if chbLevel.Checked then
        exKlevel := Str2Float(LoadRecord(stT,11));

      MakeDigital(i);
      MakeCanal(i);

      Inc(i);
    end;

    try
      CloseFile(FOutput);
    except
    end;

    stgDigitals.TopRow := 1;
    Result := True;
  except
  end;
end;

function TfrmMain.ImportParams(FileName: string): boolean;
var
  stT:    string;
  i,j:    word;
begin
  Result := False;

  try
    AssignFile(FOutput, FileName);
    Reset(FOutput);

    i := 0;
    while not Eof(FOutput) do with mpParams1[i],mpParams2[i] do begin
      Readln(FOutput,stT);

      if (UnPackStr(stT) = '') or (Pos('\\',stT) = 1) then continue;
      if i >= wPARAMS then break;

      if StrToIntDef(LoadRecordPar(stT,0),0) = 0 then continue;

      ibPort   := StrToInt(LoadRecordPar(stT,1));
      ibPhone  := StrToInt(LoadRecordPar(stT,2));

      bDevice := 0;
      for j := 0 to DEVICES-1 do begin
        if LoadRecordPar(stT,3) = UnpackStr(GetDeviceName(j)) then
        begin bDevice := j; break; end;
      end;

      bAddress := StrToInt(LoadRecordPar(stT,4));
      ibLine   := GetLineByName(LoadRecordPar(stT,5));

      exKdivid := Str2Float(LoadRecordPar(stT,7));

      MakeParams1(i);
      MakeParams2(i);

      Inc(i);
    end;

    try
      CloseFile(FOutput);
    except
    end;

    stgParams.TopRow := 1;
    Result := True;
  except
  end;
end;

function TfrmMain.ImportGroups(FileName: string): boolean;
var
  stT:  string;
  i,j:  word;
  x:    integer;
begin
  Result := False;

  try
    AssignFile(FOutput, FileName);
    Reset(FOutput);

    i := 0;
    while not Eof(FOutput) do begin
      Readln(FOutput,stT);

      if (UnPackStr(stT) = '') or (Pos('\\',stT) = 1) then continue;
      if i >= bGROUPS then break;

      if LoadRecordGrp(stT,0) = '' then continue;

      for j := 0 to bCANALS-1 do begin
        x := StrToIntDef(LoadRecordGrp(stT,j+1),0);

        if x > 0 then mpbGroups[i,j] := 1
        else
        if x < 0 then mpbGroups[i,j] := 2
        else          mpbGroups[i,j] := 0;
      end;

      MakeGroup(i);

      Inc(i);
    end;

    try
      CloseFile(FOutput);
    except
    end;

    stgGroups.TopRow := 1;
    Result := True;
  except
  end;
end;

function TfrmMain.ImportPhones(FileName: string): boolean;
var
  stT:  string;
  i:    word;
begin
  Result := False;

  try
    AssignFile(FOutput, FileName);
    Reset(FOutput);

    i := 0;
    while not Eof(FOutput) do begin
      Readln(FOutput,stT);

      if (UnPackStr(stT) = '') or (Pos('\\',stT) = 1) then continue;
      if i >= bCANALS then break;

      if LoadRecordPho(stT,0) = '' then continue;

      stgPhones.Rows[i+1].Strings[1] := ' ' + LoadRecordPho(stT,1);

      Inc(i);
    end;

    try
      CloseFile(FOutput);
    except
    end;

    stgPhones.TopRow := 1;
    Result := True;
  except
  end;
end;

function TfrmMain.ImportAddresses(FileName: string): boolean;
var
  stT:  string;
  i:    word;
begin
  Result := False;

  try
    AssignFile(FOutput, FileName);
    Reset(FOutput);

    i := 0;
    while not Eof(FOutput) do begin
      Readln(FOutput,stT);

      if (UnPackStr(stT) = '') or (Pos('\\',stT) = 1) then continue;
      if i >= bCANALS then break;

      if LoadRecordPho(stT,0) = '' then continue;
      stgAddresses.Rows[i+1].Strings[1] := ' ' + LoadRecordPho(stT,1);
      stgAddresses.Rows[i+1].Strings[2] := ' ' + LoadRecordPho(stT,2);

      Inc(i);
    end;

    try
      CloseFile(FOutput);
    except
    end;

    stgAddresses.TopRow := 1;
    Result := True;
  except
  end;
end;

function TfrmMain.ImportAddresses2(FileName: string): boolean;
var
  stT:  string;
  i:    word;
begin
  Result := False;

  try
    AssignFile(FOutput, FileName);
    Reset(FOutput);

    i := 0;
    while not Eof(FOutput) do begin
      Readln(FOutput,stT);

      if (UnPackStr(stT) = '') or (Pos('\\',stT) = 1) then continue;
      if i >= bCANALS then break;

      if LoadRecordPho(stT,0) = '' then continue;
      stgAddresses2.Rows[i+1].Strings[1] := ' ' + LoadRecordPho(stT,1);
      stgAddresses2.Rows[i+1].Strings[2] := ' ' + LoadRecordPho(stT,2);

      Inc(i);
    end;

    try
      CloseFile(FOutput);
    except
    end;

    stgAddresses2.TopRow := 1;
    Result := True;
  except
  end;
end;

function TfrmMain.ImportGraphInquiry(FileName: string): boolean;
var
  stT:  string;
  i:    word;
begin
  Result := False;

  try
    AssignFile(FOutput, FileName);
    Reset(FOutput);

    i := 0;
    while not Eof(FOutput) do begin
      Readln(FOutput,stT);

      if (UnPackStr(stT) = '') or (Pos('\\',stT) = 1) then continue;
      if i >= 48 then break;

      if LoadRecordGra(stT,0) = '' then continue;
      stgGraphInquiry.Rows[i+1].Strings[1] := ' ' + LoadRecordGra(stT,1);
      stgGraphInquiry.Rows[i+1].Strings[2] := ' ' + LoadRecordGra(stT,2);
      stgGraphInquiry.Rows[i+1].Strings[3] := ' ' + LoadRecordGra(stT,3);
      stgGraphInquiry.Rows[i+1].Strings[4] := ' ' + LoadRecordGra(stT,4);

      Inc(i);
    end;

    try
      CloseFile(FOutput);
    except
    end;

    stgGraphInquiry.TopRow := 1;
    Result := True;
  except
  end;
end;

function TfrmMain.ImportGraphCorrect(FileName: string): boolean;
var
  stT:  string;
  i:    word;
begin
  Result := False;

  try
    AssignFile(FOutput, FileName);
    Reset(FOutput);

    i := 0;
    while not Eof(FOutput) do begin
      Readln(FOutput,stT);

      if (UnPackStr(stT) = '') or (Pos('\\',stT) = 1) then continue;
      if i >= 48 then break;

      if LoadRecordGra(stT,0) = '' then continue;
      stgGraphCorrect.Rows[i+1].Strings[1] := ' ' + LoadRecordGra(stT,1);

      Inc(i);
    end;

    try
      CloseFile(FOutput);
    except
    end;

    stgGraphCorrect.TopRow := 1;
    Result := True;
  except
  end;
end;

function TfrmMain.ImportGraphRecalc(FileName: string): boolean;
var
  stT:  string;
  i:    word;
  j:    integer;
begin
  Result := False;

  try
    AssignFile(FOutput, FileName);
    Reset(FOutput);

    i := 0;
    while not Eof(FOutput) do begin
      Readln(FOutput,stT);

      if (UnPackStr(stT) = '') or (Pos('\\',stT) = 1) then continue;
{
      if (Pos('&',stT) = 1) then begin
        j := StrToIntDef(Copy(stT,2,Length(stT)-1), -1);
        if j in [0,1] then rgrGraphRecalc.ItemIndex := j;
        continue;
      end;
}
      if i >= 48 then break;

      if LoadRecordGra(stT,0) = '' then continue;
      stgGraphRecalc.Rows[i+1].Strings[1] := ' ' + LoadRecordGra(stT,1);

      Inc(i);
    end;

    try
      CloseFile(FOutput);
    except
    end;

    stgGraphRecalc.TopRow := 1;
    Result := True;
  except
  end;
end;

function TfrmMain.ImportGraphTransit(FileName: string): boolean;
var
  stT:  string;
  i:    word;
begin
  Result := False;

  try
    AssignFile(FOutput, FileName);
    Reset(FOutput);

    i := 0;
    while not Eof(FOutput) do begin
      Readln(FOutput,stT);

      if (UnPackStr(stT) = '') or (Pos('\\',stT) = 1) then continue;
      if i >= 48 then break;

      if LoadRecordGra(stT,0) = '' then continue;
      stgGraphTransit.Rows[i+1].Strings[1] := ' ' + LoadRecordGra(stT,1);

      Inc(i);
    end;

    try
      CloseFile(FOutput);
    except
    end;

    stgGraphTransit.TopRow := 1;
    Result := True;
  except
  end;
end;

function TfrmMain.ImportCanalsNames(FileName: string): boolean;
var
  stT:  string;
  i:    word;
begin
  Result := False;

  try
    AssignFile(FOutput, FileName);
    Reset(FOutput);

    i := 0;
    while not Eof(FOutput) do begin
      Readln(FOutput,stT);

      if (UnPackStr(stT) = '') or (Pos('\\',stT) = 1) then continue;
      if i >= bCANALS then break;

      if LoadRecordPho(stT,0) = '' then continue;

      stgCanalsNames.Rows[i+1].Strings[1] := ' ' + LoadRecordPho(stT,1);

      Inc(i);
    end;

    try
      CloseFile(FOutput);
    except
    end;

    stgCanalsNames.TopRow := 1;
    Result := True;
  except
  end;
end;

function TfrmMain.ImportGroupsNames(FileName: string): boolean;
var
  stT:  string;
  i:    word;
begin
  Result := False;

  try
    AssignFile(FOutput, FileName);
    Reset(FOutput);

    i := 0;
    while not Eof(FOutput) do begin
      Readln(FOutput,stT);

      if (UnPackStr(stT) = '') or (Pos('\\',stT) = 1) then continue;
      if i >= bGROUPS then break;

      if LoadRecordPho(stT,0) = '' then continue;

      stgGroupsNames.Rows[i+1].Strings[1] := ' ' + LoadRecordPho(stT,1);

      Inc(i);
    end;

    try
      CloseFile(FOutput);
    except
    end;

    stgGroupsNames.TopRow := 1;
    Result := True;
  except
  end;
end;

procedure TfrmMain.btbImportCanalsClick(Sender: TObject);
begin
  inherited;
  with od_CustomLoad do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stSETTINGS;
      ForceDirectories(InitialDir);

      if Execute then begin
        if ImportCanals(FileName) then
          InfBox('������ ������� �������� �������');
      end;
    except
      ErrBox('������ ��� ������ ������ ������� !');
    end;
  end;
end;

procedure TfrmMain.SaveGrid(Grid: TStringGrid; stName,stPath: string; Table: tables);
var
  x,y,z:        word;
begin
  with sd_SaveGrid,Grid do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stPath;
      SysUtils.ForceDirectories(InitialDir);
      FileName := stName + '.txt';

      if Execute then begin
        AssignFile(FOutput, FileName);
        Rewrite(FOutput);

        Writeln(FOutput,'\\ ' + stName);
        Writeln(FOutput,'\\ ' + FormatDateTime('hh.nn.ss dd.mm.yyyy',Now));
{
        case Table of
          table_graphrecalc: begin Writeln(FOutput,'&'+IntToStr(rgrGraphRecalc.ItemIndex)); end;
        end;
}
        Writeln(FOutput,'');

        for y := 0 to RowCount-1 do begin
          for x := 0 to ColCount-1 do begin

            case Table of
              table_canals:
                if x >= sizeof(mpbDIGITALSSIZE) then z := ColWidths[x] div 6
                else z := mpbDIGITALSSIZE[x];

              table_params:
                if x >= 1 then z := bPARAMSIZE else z := bINDEXSIZE;

              table_groups:
                if x >= 1 then z := bNODESSIZE else z := bGROUPSSIZE;

              table_phones:
                if x >= 1 then z := bPHONESIZE else z := bINDEXSIZE;

              table_addresses:
                if x >= 1 then z := bPHONESIZE else z := bINDEXSIZE;

              table_addresses2:
                if x >= 1 then z := bPHONESIZE else z := bINDEXSIZE;

              table_graph_inquiry: z := bGRAPHSIZE;
              table_graph_correct: z := bGRAPHSIZE;
              table_graph_recalc:  z := bGRAPHSIZE;
              table_graph_transit: z := bGRAPHSIZE;

              else z := ColWidths[x] div 6;
            end;

            Write(FOutput,PackStrR(Cols[x].Strings[y], z));
          end;
          Writeln(FOutput);
        end;

        Writeln(FOutput,'');
        Writeln(FOutput,'\\ ����� �����');

        try
          CloseFile(FOutput);
        except
        end;

        InfBox('������� ��������� �������');
      end;
    except
      ErrBox('������ ��� ���������� ������� !')
    end;
  end;
end;

procedure TfrmMain.btbExportCanalsClick(Sender: TObject);
begin
  inherited;
  SaveGrid(stgDigitals, '������ �������', stSETTINGS, table_canals);
end;

procedure TfrmMain.btbClearCanalsClick(Sender: TObject);
begin
  inherited;
  ClearDigitals;
  ClearCanals;
end;

{}procedure TfrmMain.stgDigitalsSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  inherited;

  try
    if (UnpackStr(Value) <> '') and (ARow > 0) then begin
      with stgDigitals.Rows[ARow],mpDigitals[ARow-1],mpCanals[ARow-1] do begin

        if ACol = digPORT    then ibPort := StrToInt(UnpackStr(Strings[digPORT]))
        else
        if ACol = digPHONE   then ibPhone  := StrToInt(UnpackStr(Strings[digPHONE]))
        else
        if ACol = digADDRESS then bAddress := StrToInt(UnpackStr(Strings[digADDRESS]))
        else
        if ACol = digLINE    then ibLine := StrToInt(UnpackStr(Strings[digLINE]))

        else
        if ACol = digTRANS  then exKtrans  := StrToFloat(UnpackStr(Strings[digTRANS]))
        else
        if ACol = digPULSE  then exKpulse  := StrToFloat(UnpackStr(Strings[digPULSE]))
        else
        if ACol = digLOSSE  then exKlosse  := StrToFloat(UnpackStr(Strings[digLOSSE]))
        else
        if ACol = digCOUNT  then exKcount  := StrToFloat(UnpackStr(Strings[digCOUNT]))
        else
        if ACol = digLEVEL  then exKlevel  := StrToFloat(UnpackStr(Strings[digLEVEL]))
      end;
    end;
  except
    ErrBox('������ ��� ����� ������ !');
  end;

end;

procedure TfrmMain.btbSetDigitalsClick(Sender: TObject);
var
  i,j:    word;
  sreT: sreal;
begin
  inherited;
  NormalMode;

  InitPushCRC;

  for i := 0 to bCANALS do with mpCanals[i] do begin
    sreT := ToSReal( exKtrans );
    for j := 0 to bREAL - 1 do Push(sreT[j]);

    AddTerminal(PackStrR(IntToStr(i+1),4)+': '+GetExtendedStr(exKtrans),clGray);
  end;

  InitLoad('������ �������������', bCANALS*7, acSetTransEng);
end;

procedure TfrmMain.btbGetDigitalsClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  HideDigitalsCmb;

  ClearDigitals;
  ClearCanals;

  InitLoad('������ �������������', bCANALS*5-1, acGetTransEng);
end;

{}procedure TfrmMain.SaveTariffGrid(stgTariff: TStringGrid; stName: string);
var
  y:    word;
begin
  Writeln(FOutput,'');
  Writeln(FOutput,stName);

  with stgTariff do begin
    for y := 1 to bBREAKS do
      Write(FOutput,PackStrL(Cols[1].Strings[y], bTARIFFSSIZE));

    Writeln(FOutput);
  end;
end;

procedure TfrmMain.SaveAllTariffsGrid(stgTariff: TStringGrid; stName: string);
var
  x,y:  word;
begin
  Writeln(FOutput,'');
  Writeln(FOutput,stName);

  with stgTariff do begin
    for x := 1 to 12 do begin
      for y := 1 to bBREAKS do
        Write(FOutput,PackStrL(Cols[x].Strings[y], bTARIFFSSIZE));

      Writeln(FOutput,'  \\' + Cols[x].Strings[0]);
    end;
  end;
end;

procedure TfrmMain.btbExportTariffsClick(Sender: TObject);
var
  stName:       string;
begin
  inherited;
  with sd_SaveGrid do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stSETTINGS;
      stName := '������ �������';

      SysUtils.ForceDirectories(InitialDir);
      FileName := stName + '.txt';

      if Execute then begin
        AssignFile(FOutput, FileName);
        Rewrite(FOutput);

        Writeln(FOutput,'\\ ' + stName);
        Writeln(FOutput,'\\ ���� ��������: ' + FormatDateTime('hh.nn.ss dd.mm.yyyy',Now));
        Writeln(FOutput,'');

        SaveTariffGrid(stgTariffsDay, '\\ ������ �� �����');

        SaveAllTariffsGrid(stgAllTariffsPow, '\\ ������ ��� ��������');
        SaveAllTariffsGrid(stgAllTariffsEng, '\\ ������ ��� �������');
        SaveAllTariffsGrid(stgAllTariffsPub, '\\ ������ �����������');

        Writeln(FOutput,'');
        Writeln(FOutput,'\\ ����� �����');

        try
          CloseFile(FOutput);
        except
        end;

        InfBox('������ ������� �������� �������');
      end;
    except
      ErrBox('������ ��� ���������� ������ ������� !')
    end;
  end;
end;

{}procedure TfrmMain.mniRunFlowClick(Sender: TObject);
begin
  inherited;
  EscSearch(actRunFlow);
end;

{}procedure TfrmMain.mniTestFlowClick(Sender: TObject);
begin
  inherited;
  OutStr('Is transit ?',actTestFlow);
end;

{}procedure TfrmMain.mniCloseFlowClick(Sender: TObject);
begin
  inherited;
  OutStr('Close transit',actExitFlow);
end;

function TfrmMain.LoadRecordTariff(stRecord: string; wPos: word): string;
var
  i,j:   word;
  stT:   string;
begin
  j := 1;

  if wPos > 0 then
    for i := 0 to wPos-1 do j := j + bTARIFFSSIZE;

  stT := Copy(stRecord,j,bTARIFFSSIZE);
  Result := UnpackStr(stT);
end;

procedure TfrmMain.LoadGridTariff(stgTariff: TStringGrid; stRecord: string; x: byte);
var
  y:    word;
begin
  with stgTariff do begin
    for y := 1 to bBREAKS do
      Cols[x].Strings[y] := ' ' + LoadRecordTariff(stRecord,y-1);
  end;
end;

function TfrmMain.ImportTariffs(FileName: string): boolean;
var
  stT:    string;
  i:      word;
begin
  Result := False;

  try
    AssignFile(FOutput, FileName);
    Reset(FOutput);

    while not Eof(FOutput) do begin
      Readln(FOutput,stT);
      if ((UnPackStr(stT) = '') or (Pos('\\',stT) = 1)) then continue
      else break;
    end;
    LoadGridTariff(stgTariffsDay, stT, 1);

    for i := 1 to 12 do  begin
      while not Eof(FOutput) do begin
        Readln(FOutput,stT);
        if ((UnPackStr(stT) = '') or (Pos('\\',stT) = 1)) then continue
        else break;
      end;
      LoadGridTariff(stgAllTariffsPow, stT, i);
    end;

    for i := 1 to 12 do begin
    while not Eof(FOutput) do begin
      Readln(FOutput,stT);
      if ((UnPackStr(stT) = '') or (Pos('\\',stT) = 1)) then continue
      else break;
    end;
    LoadGridTariff(stgAllTariffsEng, stT, i); end;

    for i := 1 to 12 do begin
    while not Eof(FOutput) do begin
      Readln(FOutput,stT);
      if ((UnPackStr(stT) = '') or (Pos('\\',stT) = 1)) then continue
      else break;
    end;
    LoadGridTariff(stgAllTariffsPub, stT, i); end;

    try
      CloseFile(FOutput);
    except
    end;

    Result := True;
  except
  end;
end;

procedure TfrmMain.btbImportTariffsClick(Sender: TObject);
begin
  inherited;
  with od_CustomLoad do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stSETTINGS;
      SysUtils.ForceDirectories(InitialDir);

      if Execute then begin
        if ImportTariffs(FileName) then
          InfBox('������ ������� �������� �������');
      end;
    except
      ErrBox('������ ��� ������ ������ ������� !');
    end;
  end;
end;

procedure TfrmMain.rgrTAPIClick(Sender: TObject);
begin
  inherited;
end;

{}procedure TfrmMain.btbSelectDeviceClick(Sender: TObject);
begin
  inherited;
  try
    TapiDevice.SelectDevice;
    ClearDial;
  except
    on e: Exception do ErrBox('������ ��� ������ ������: ' + e.Message);
  end;

  ShowSelectedDevice;
end;

{}procedure TfrmMain.btbShowConfigDialogClick(Sender: TObject);
begin
  inherited;
  try
    TapiDevice.ShowConfigDialog;
  except
    on e: Exception do ErrBox('������ ��� ��������� ������: ' + e.Message);
  end;
end;

{}procedure TfrmMain.btbDialClick(Sender: TObject);
begin
  inherited;
  try
    TapiDevice.Dial(edtDial.Text);
  except
    on e: Exception do ErrBox('������ ��� ������������ ����������: ' + e.Message);
  end;
end;

procedure TfrmMain.btbCancelCallClick(Sender: TObject);
begin
  inherited;
  try
    TapiDevice.CancelCall;
    AddDial('cancel call...');
  except
    on e: Exception do ErrBox('������ ��� ������� �����: ' + e.Message);
  end;
end;

{}procedure TfrmMain.VisibleAll(bTag: byte; fVisible: boolean);
var
  i:    word;
begin
  begin
    for i := 0 to ComponentCount - 1 do begin
      if Components[i] is TWinControl then begin
        if (Components[i] as TWinControl).Tag = bTag then
          (Components[i] as TWinControl).Visible := fVisible;
      end;
    end
  end;
end;

procedure TfrmMain.mitVersionClick(Sender: TObject);
begin
  inherited;
  InfBox('������ �� 24 ������ 2022 ����');
end;

procedure TfrmMain.btbGetGroupsClick(Sender: TObject);
begin
  inherited;
  NormalMode;
  
  ClearGroups;

  iwAlfa := 0;

  InitPushCRC;
  Push(iwAlfa);
  InitLoad('������ �����', bGROUPS-1, acGetGroups);
end;

procedure TfrmMain.btbClearGroupsClick(Sender: TObject);
begin
  inherited;
  ClearGroups;
end;

procedure TfrmMain.stgGroupsDblClick(Sender: TObject);
begin
  inherited;
  with stgGroups do begin
    if (Col > 0) and (Row > 0) then begin
      mpbGroups[Row-1,Col-1] := (mpbGroups[Row-1,Col-1] + 1) mod 3;
      MakeGroup(Row-1);
    end;
  end;
end;

procedure TfrmMain.SaveGroups(y: word);
var
  x:  word;
begin
  with mpgrGroups[y] do begin
    bSize := 0;

    for x := 0 to bCANALS-1 do begin
      mpnoNodes[x].ibCanal := 0;

      if mpbGroups[iwAlfa,x] = 1 then begin
        mpnoNodes[ bSize ].ibCanal := x;
        Inc(bSize);
      end
      else if mpbGroups[iwAlfa,x] = 2 then begin
        mpnoNodes[ bSize ].ibCanal := x or $80;
        Inc(bSize);
      end
    end;

    InitPushCRC;
    Push(iwAlfa);

    Push(bSize);
    for x := 0 to bCANALS-1 do Push(mpnoNodes[x].ibCanal);
  end;
end;

procedure TfrmMain.SavePhones(y: word);
var
  x:    word;
  stT:  string;
begin
  with stgPhones do begin
    InitPushCRC;
    Push(2);
    Push(iwAlfa);

    stT := Trim(Rows[iwAlfa+1].Strings[1]);

    for x := 1 to NUMBERS do
      if x <= Length(stT) then Push(Ord(stT[x])) else Push(0);
  end;
end;

procedure TfrmMain.SaveAddresses(y: word);
var
  dwT:  longint;
  stT:  string;
begin
  with stgAddresses do begin
    InitPushCRC;
    Push(29);
    Push(iwAlfa);

    stT := Trim(Rows[iwAlfa+1].Strings[1]);
    dwT := StrToIntDef(stT,-1);
    if dwT = -1 then ErrBox('!') else PushLong(dwT);

    stT := Trim(Rows[iwAlfa+1].Strings[2]);
    dwT := StrToIntDef(stT,-1);
    if dwT = -1 then ErrBox('!') else PushLong(dwT);
  end;
end;

procedure TfrmMain.SaveAddresses2(y: word);
var
  dwT:  longint;
  x:    word;
  stT:  string;
begin
  with stgAddresses2 do begin
    InitPushCRC;
    Push(137);
    Push(iwAlfa);

    stT := Trim(Rows[iwAlfa+1].Strings[1]);
    dwT := StrToIntDef(stT,-1);
    if dwT = -1 then ErrBox('!') else PushLong(dwT);

    stT := Trim(Rows[iwAlfa+1].Strings[2]);
    for x := 1 to NUMBERS do
      if x <= Length(stT) then Push(Ord(stT[x])) else Push(0);
  end;
end;

procedure TfrmMain.SaveCanalsNames(y: word);
var
  x:    word;
  stT:  string;
begin
  with stgCanalsNames do begin
    InitPushCRC;
    Push(114);
    Push(iwAlfa);

    stT := Trim(Rows[iwAlfa+1].Strings[1]);

    for x := 1 to NAMES-1 do
      if x <= Length(stT) then Push(Ord(stT[x])) else Push(0);

    Push(0);
  end;
end;

procedure TfrmMain.SaveGroupsNames(y: word);
var
  x:    word;
  stT:  string;
begin
  with stgGroupsNames do begin
    InitPushCRC;
    Push(116);
    Push(iwAlfa);

    stT := Trim(Rows[iwAlfa+1].Strings[1]);

    for x := 1 to NAMES-1 do
      if x <= Length(stT) then Push(Ord(stT[x])) else Push(0);

    Push(0);
  end;
end;

procedure TfrmMain.btbSetGroupsClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  iwAlfa := 0;

  SaveGroups(iwAlfa);
  InitLoad('������ �����', bGROUPS-1, acSetGroups);
end;

procedure TfrmMain.btbExportGroupsClick(Sender: TObject);
begin
  inherited;
  SaveGrid(stgGroups, '������ �����', stSETTINGS, table_groups);
end;

procedure TfrmMain.btbImportGroupsClick(Sender: TObject);
begin
  inherited;
  with od_CustomLoad do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stSETTINGS;
      SysUtils.ForceDirectories(InitialDir);

      if Execute then begin
        if ImportGroups(FileName) then
          InfBox('������ ����� �������� �������');
      end;
    except
      ErrBox('������ ��� ������ ������ ����� !');
    end;
  end;
end;

procedure TfrmMain.mniPhonesClick(Sender: TObject);
begin
  inherited;
  SetActivePage(tbsPhones);
end;

procedure TfrmMain.btbGetPhonesClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  ClearPhones;

  iwAlfa := 0;

  InitPushCRC;
  Push(1);
  Push(iwAlfa);
  InitLoad('������ ���������', bCANALS-1, acGetPhones);
end;

procedure TfrmMain.btbSetPhonesClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  iwAlfa := 0;

  SavePhones(iwAlfa);
  InitLoad('������ ���������', bCANALS-1, acSetPhones);
end;

procedure TfrmMain.btbClearPhonesClick(Sender: TObject);
begin
  inherited;
  ClearPhones;
end;

procedure TfrmMain.stgPhonesGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  inherited;
  with stgPhones do Value := ' 9c99999999999;1; '
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if IdTCPClient.Connected = True then btbSocketCloseClick(nil);

  if TapiDevice.TapiState = tsConnected then begin
    WrnBox('����� ��������� � ��������� ����������.'+ #10#13 +
           '����� ������� �� ��������� ���������� ��������� ����� !');
    Abort;
  end;

  Stop;
  timNow.Enabled := False;

  btbClearTerminalClick(nil);
end;

procedure TfrmMain.btbExportPhonesClick(Sender: TObject);
begin
  inherited;
  SaveGrid(stgPhones, '������ ���������', stSETTINGS, table_phones);
end;

procedure TfrmMain.btbImportPhonesClick(Sender: TObject);
begin
  inherited;
  with od_CustomLoad do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stSETTINGS;
      SysUtils.ForceDirectories(InitialDir);

      if Execute then begin
        if ImportPhones(FileName) then
          InfBox('������ ��������� �������� �������');
      end;
    except
      ErrBox('������ ��� ������ ������ ��������� !');
    end;
  end;
end;

procedure TfrmMain.NormalMode;
begin
  if (chbCtrlZ.Checked) then begin
    CtrlZ; Delay(50);
  end;
end;

procedure TfrmMain.mniParamsClick(Sender: TObject);
begin
  inherited;
  SetActivePage(tbsParams);
end;

procedure TfrmMain.btbGetParamsClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  HideParamsCmb;

  ClearParams1;
  ClearParams2;

  iwAlfa := 0;
  InitPushCRC;
  Push(iwAlfa div $100);
  Push(iwAlfa mod $100);  
  InitLoad('������ ����������', wPARAMS*2-1, acGetDivid);
end;

procedure TfrmMain.btbSetParamsClick(Sender: TObject);
var
  j:    word;
  sreT: sreal;
begin
  inherited;
  NormalMode;

  iwAlfa := 0;
  InitPushCRC;
  Push(iwAlfa div $100);
  Push(iwAlfa mod $100);

  with mpParams2[iwAlfa] do begin
    sreT := ToSReal( exKdivid );
    for j := 0 to bREAL - 1 do Push(sreT[j]);

    AddTerminal(PackStrR(IntToStr(iwAlfa+1),4)+': '+GetExtendedStr(exKdivid),clGray);
  end;

  InitLoad('������ ����������', wPARAMS*2-1, acSetDivid);
end;

procedure TfrmMain.btbImportParamsClick(Sender: TObject);
begin
  inherited;
  with od_CustomLoad do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stSETTINGS;
      SysUtils.ForceDirectories(InitialDir);

      if Execute then begin
        if ImportParams(FileName) then
          InfBox('������ ���������� �������� �������');
      end;
    except
      ErrBox('������ ��� ������ ������ ���������� !');
    end;
  end;
end;

procedure TfrmMain.btbExportParamsClick(Sender: TObject);
begin
  inherited;
  SaveGrid(stgParams, '������ ����������', stSETTINGS, table_params);
end;

procedure TfrmMain.btbClearParamsClick(Sender: TObject);
begin
  inherited;
  ClearParams1;
  ClearParams2;
end;

procedure TfrmMain.stgParamsClick(Sender: TObject);
var
  fT:   boolean;
begin
  inherited;
  with stgDigitals do
    if (Col in [digDEVICE, digLINE]) and (Row > 0) then
      stgParamsSelectCell(nil,Col,Row,fT);
end;

procedure TfrmMain.stgParamsDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  inherited;
//  ParamsGridDrawCell(stgParams, ACol,ARow, Rect);
end;

procedure TfrmMain.stgParamsGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  inherited;

  with stgDigitals do begin
    if ACol = digPORT then Value := ' c;1; '
    else
    if ACol = digPHONE then Value := ' cc;1; '
    else
    if ACol = digADDRESS then Value := ' ccc;1; '
//    else
//    if ACol = digLINE then Value := ' cc;1; '

    else
    if ACol in [digDIVID] then Value := ' cccccccccc;1; ';
  end;

end;

procedure TfrmMain.stgParamsKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  with stgParams do
    if Col in [digDEVICE, digLINE] then Key := #0;
end;

procedure TfrmMain.stgParamsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  R:    TRect;
begin
  inherited;
  if ((ACol = digDEVICE) and (ARow <> 0)) then  begin
    R := stgParams.CellRect(ACol, ARow);

    R.Left   := R.Left    + stgParams.Left;
    R.Right  := R.Right   + stgParams.Left;
    R.Top    := R.Top     + stgParams.Top;
    R.Bottom := R.Bottom  + stgParams.Top;

    cmbGridDevicesPar.Left   := R.Left + 1;
    cmbGridDevicesPar.Top    := R.Top + 1;
    cmbGridDevicesPar.Width  := (R.Right + 1) - R.Left;
    cmbGridDevicesPar.Height := (R.Bottom + 1) - R.Top;

    cmbGridDevicesPar.ItemIndex := mpParams1[ARow-1].bDevice;
    cmbGridDevicesPar.Visible   := True;
    cmbGridDevicesPar.SetFocus;
  end;

  if ((ACol = digLINE) and (ARow <> 0)) then  begin
    R := stgParams.CellRect(ACol, ARow);

    R.Left   := R.Left    + stgParams.Left;
    R.Right  := R.Right   + stgParams.Left;
    R.Top    := R.Top     + stgParams.Top;
    R.Bottom := R.Bottom  + stgParams.Top;

    cmbGridLinesPar.Left   := R.Left + 1;
    cmbGridLinesPar.Top    := R.Top + 1;
    cmbGridLinesPar.Width  := (R.Right + 1) - R.Left;
    cmbGridLinesPar.Height := (R.Bottom + 1) - R.Top;

    cmbGridLinesPar.ItemIndex := GetIndexByLine(mpParams1[ARow-1].ibLine);
    cmbGridLinesPar.Visible   := True;
    cmbGridLinesPar.SetFocus;
  end;

  CanSelect := True;
end;

procedure TfrmMain.stgParamsSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  inherited;

  try
    if (UnpackStr(Value) <> '') and (ARow > 0) then begin
      with stgParams.Rows[ARow],mpParams1[ARow-1],mpParams2[ARow-1] do begin

        if ACol = digPORT    then ibPort := StrToInt(UnpackStr(Strings[digPORT]))
        else
        if ACol = digPHONE   then ibPhone  := StrToInt(UnpackStr(Strings[digPHONE]))
        else
        if ACol = digADDRESS then bAddress := StrToInt(UnpackStr(Strings[digADDRESS]))
//        else
//        if ACol = digLINE    then ibLine := StrToInt(UnpackStr(Strings[digLINE]))

        else
        if ACol = digDIVID  then exKdivid  := StrToFloat(UnpackStr(Strings[digDIVID]))
      end;
    end;
  except
    ErrBox('������ ��� ����� ������ !');
  end;

end;

procedure TfrmMain.cmbGridDevicesParChange(Sender: TObject);
begin
  inherited;
  ParamsCmbDevices;
end;

procedure TfrmMain.cmbGridDevicesParExit(Sender: TObject);
begin
  inherited;
  ParamsCmbDevices;
end;

procedure TfrmMain.btbResetDividClick(Sender: TObject);
begin
  inherited;
  if (Application.MessageBox(
      PChar('���������� � ������. � �������� �������� ? '),
      '��������',mb_IconExclamation + mb_YesNo + mb_DefButton2) <> idYes) then Exit;

  QueryCRC(acResetDivid);
end;

procedure TfrmMain.mniRecordsClick(Sender: TObject);
begin
  inherited;
  SetActivePage(tbsRecords);
end;

procedure TfrmMain.btbGetRecordsClick(Sender: TObject);
begin
  inherited;
  NormalMode;
  redRecords.Clear;

  if (rgrEvent.ItemIndex < 6) then begin
    cwRec := 0;
    iwAlfa := 0;

    InitPushCRC;
    Push(20);
    Push(rgrEvent.ItemIndex);
    Push(iwAlfa);
    InitLoad('������ �������', bRECORD_PAGES-1, acGetRecords);
  end
  else begin
    QueryCRC(acGetMemory0);
  end;
end;

procedure TfrmMain.btbSaveRecordsClick(Sender: TObject);
begin
  inherited;
  SaveRich(redRecords, '������� ('+rgrEvent.Items[rgrEvent.ItemIndex] +') ' + FormatDateTime('hh.nn.ss dd.mm.yyyy ',Now));
end;

procedure TfrmMain.btbClearRecordsClick(Sender: TObject);
begin
  inherited;
  redRecords.Clear;
end;

procedure TfrmMain.chbLevelClick(Sender: TObject);
var
  i:    word;
begin
  inherited;
  for i := 0 to bCANALS-1 do with mpCanals[i] do
    MakeCanal(i);
end;

procedure TfrmMain.btbGetAddressesClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  ClearAddresses;

  iwAlfa := 0;

  InitPushCRC;
  Push(28);
  Push(iwAlfa);
  InitLoad('������ ������� � �������', bCANALS-1, acGetAddresses);
end;

procedure TfrmMain.btbSetAddressesClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  iwAlfa := 0;

  SaveAddresses(iwAlfa);
  InitLoad('������ ������� � �������', bCANALS-1, acSetAddresses);
end;

procedure TfrmMain.btbImportAddressesClick(Sender: TObject);
begin
  inherited;
  with od_CustomLoad do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stSETTINGS;
      SysUtils.ForceDirectories(InitialDir);

      if Execute then begin
        if ImportAddresses(FileName) then
          InfBox('������ ������� � ������� �������� �������');
      end;
    except
      ErrBox('������ ��� ������ ������ ������� � ������� !');
    end;
  end;
end;

procedure TfrmMain.btbExportAddressesClick(Sender: TObject);
begin
  inherited;
  SaveGrid(stgAddresses, '������ ������� � �������� �������', stSETTINGS, table_addresses);
end;

procedure TfrmMain.btbClearAddressesClick(Sender: TObject);
begin
  inherited;
  ClearAddresses;
end;

procedure TfrmMain.stgAddressesGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  inherited;
  with stgAddresses do begin
    if ACol = 1 then Value := ' 99999999;1; ';
    if ACol = 2 then Value := ' AAAAAAAAAAAA;1; ';
  end
end;

procedure TfrmMain.mniAddressesClick(Sender: TObject);
begin
  inherited;
  SetActivePage(tbsAddresses);
end;

procedure TfrmMain.ShowRelaxs;
var
  s:  string;
  i:  word;
  r:  TRelax;
begin
  try
    with lbxRelaxs do begin
       lblRelaxs.Caption := '����� ����������: '+IntToStr(Count);       
       for i := 1 to Count do begin
         r := Items.Objects[i-1] as TRelax;
         s := IntToStrX(r.tiSelf.bDay,2)+'.'+IntToStrX(r.tiSelf.bMonth,2) + '  ';
         case r.tiSelf.bSecond of
           1: s := s + '��������'; 
           2: s := s + '������� ����';      
           else s := s + '?';      
         end;  
         Items.Strings[i-1] := s; 
       end
    end;
  except
    ErrBox('������ ��� ����������� ���������� !');
  end
end;

function TfrmMain.RelaxDate: times;
var
  Year,Month,Day: word;
begin
  DecodeDate(clnRelaxs.Date, Year,Month,Day);
  with Result do begin
    bSecond := 0;
    bMinute := 0;
    bHour   := 0;
    bDay    := Day;
    bMonth  := Month;
    bYear   := Year mod 100;
  end;
end;  

procedure TfrmMain.AddRelax(bo: boolean);
var
  tiT:  times;  
  i,j:  byte;
  r,t:  TRelax;
begin
  try
    if lbxRelaxs.Count >= bMAXRELAXS then begin WrnBox('������������ ���������� ���������� � ������: '+IntToStr(bMAXRELAXS)); exit; end;
    
    tiT := RelaxDate;
    if bo then tiT.bSecond := 1 else tiT.bSecond := 2;      

    for i := 1 to lbxRelaxs.Count do begin
      r := lbxRelaxs.Items.Objects[i-1] as TRelax;
      if (r.tiSelf.bDay = tiT.bDay) and (r.tiSelf.bMonth = tiT.bMonth) then begin WrnBox('����� �������� ��� ����� !'); exit; end;
    end;
      
    lbxRelaxs.AddItem('', TRelax.Create(tiT));

    for i := 1 to lbxRelaxs.Count do 
      for j := 1 to lbxRelaxs.Count do begin
        r := lbxRelaxs.Items.Objects[i-1] as TRelax;
        t := lbxRelaxs.Items.Objects[j-1] as TRelax;
        if r.tiSelf.bMonth*31 + r.tiSelf.bDay < t.tiSelf.bMonth*31 + t.tiSelf.bDay then begin
          lbxRelaxs.Items.Objects[i-1] := t;
          lbxRelaxs.Items.Objects[j-1] := r;
        end;
      end; 
    
    ShowRelaxs;
  except
    ErrBox('������ ��� ���������� ��������� !');
  end
end;

procedure TfrmMain.btbRelaxsAddHolidayClick(Sender: TObject);
begin
  inherited;
  AddRelax(True);
end;

procedure TfrmMain.btbRelaxsAddWeekdayClick(Sender: TObject);
begin
  inherited;
  AddRelax(False); 
end;

procedure TfrmMain.ClearRelaxs;
begin
  lbxRelaxs.Clear;  
  ShowRelaxs;
end;

procedure TfrmMain.btbRelaxsClearDayClick(Sender: TObject);
begin
  inherited;
  lbxRelaxs.DeleteSelected;
  ShowRelaxs;
end;

procedure TfrmMain.btbRelaxsClearAllDaysClick(Sender: TObject);
begin
  inherited;
  ClearRelaxs;
end;

procedure TfrmMain.btbGetRelaxsClick(Sender: TObject);
begin
  inherited;
  NormalMode;
  
  ClearRelaxs;
  InitPushCRC;
  Push(45);
  QueryCRC(acGetRelaxs);
end;

procedure TfrmMain.btbRelaxsClearClick(Sender: TObject);
begin
  inherited;
  ClearRelaxs;
end;

procedure TfrmMain.btbSetRelaxsClick(Sender: TObject);
var
  i:    byte;
  tiT:  times;
  r:    TRelax;
begin
  inherited;
  try
    NormalMode;

    with lbxRelaxs do begin
      InitPushCRC;
      Push(46);
      Push(Count);
      for i := 1 to Count do begin
        r := Items.Objects[i-1] as TRelax;
        tiT := r.tiSelf;
        Push(tiT.bSecond);
        Push(tiT.bMinute);
        Push(tiT.bHour);
        Push(tiT.bDay);
        Push(tiT.bMonth);
        Push(tiT.bYear);
      end;
      for i := Count+1 to bMAXRELAXS do begin
        Push(0);
        Push(0);
        Push(0);
        Push(0);
        Push(0);
        Push(0);
      end;
      QueryCRC(acSetRelaxs);  
    end;  
  except
    ErrBox('������ ��� ������ ���������� !');
  end
end;

procedure TfrmMain.btbExportRelaxsClick(Sender: TObject);
var
  i:  byte;
  tiT:  times;
  r:    TRelax;
begin
  inherited;
  with sd_SaveGrid,lbxRelaxs do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stSETTINGS;
      SysUtils.ForceDirectories(InitialDir);
      FileName := '������ ����������' + '.txt';

      if Execute then begin
        AssignFile(FOutput, FileName);
        Rewrite(FOutput);

        Writeln(FOutput,'\\ ' + '������ ����������');
        Writeln(FOutput,'\\ ' + FormatDateTime('hh.nn.ss dd.mm.yyyy',Now));

        Writeln(FOutput,'');

        for i := 1 to Count do begin
          r := Items.Objects[i-1] as TRelax;
          tiT := r.tiSelf;        
          Writeln(FOutput,IntToStr(tiT.bDay)+'.'+IntToStr(tiT.bMonth)+'.'+IntToStr(tiT.bSecond));
        end;

        Writeln(FOutput,'');
        Writeln(FOutput,'\\ ����� �����');

        try
          CloseFile(FOutput);
        except
        end;

        InfBox('������ ���������� �������� �������');
      end;
    except
      ErrBox('������ ��� ���������� ������ ���������� !')
    end;
  end;
end;

function TfrmMain.ImportRelaxs(FileName: string): boolean;
var
  s,z:    string;
  d,m,h:  shortint;
  i:      word;
  tiT:    times;
begin
  Result := False;

  try
    AssignFile(FOutput, FileName);
    Reset(FOutput);

    lbxRelaxs.Clear;
    
    i := 0;
    while not Eof(FOutput) do begin
      Readln(FOutput,s);

      if (UnPackStr(s) = '') or (Pos('\\',s) = 1) then continue;
      if i >= bMAXRELAXS then break;

      i := Pos('.',s);
      if i = 0 then continue;
      z := Copy(s,1,i-1);
      Delete(s,1,i);
      d := StrToIntDef(z,-1);
      if (d < 1) or (d > 31) then continue;
      
      i := Pos('.',s);
      if i = 0 then continue;
      z := Copy(s,1,i-1);
      Delete(s,1,i);
      m := StrToIntDef(z,-1);
      if (m < 1) or (m > 12) then continue;

      h := StrToIntDef(s,-1);      
      if not h in [1,2] then continue;
      
      with tiT do begin
        bSecond := h;
        bMinute := 0;
        bHour   := 0;
        bDay    := d;
        bMonth  := m;
        bYear   := 0;
      end;        
      lbxRelaxs.AddItem('', TRelax.Create(tiT));

      Inc(i);
    end;

    try
      CloseFile(FOutput);
    except
    end;

    ShowRelaxs;
    Result := True;
  except
  end;
end;

procedure TfrmMain.btbImportRelaxsClick(Sender: TObject);
begin
  inherited;
  with od_CustomLoad do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stSETTINGS;
      SysUtils.ForceDirectories(InitialDir);

      if Execute then begin
        if ImportRelaxs(FileName) then
          InfBox('������ ���������� �������� �������');
      end;
    except
      ErrBox('������ ��� ������ ������ ���������� !');
    end;
  end;
end;

procedure TfrmMain.btbGetTimeClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  QueryCRC(crcGetTime);
end;

procedure TfrmMain.btbClearTimeClick(Sender: TObject);
begin
  inherited;
  memGetTime.Clear;
end;

procedure TfrmMain.btbSetTime1Click(Sender: TObject);
var
  tiT:  times;
begin
  inherited;

  InitPushCRC;
  Push(11);

  tiT := Str2Times(medSetTime1.Text);
  with tiT do begin
    Push(bSecond);
    Push(bMinute);
    Push(bHour);
    Push(bDay);
    Push(bMonth);
    Push(bYear);
  end;

  QueryCRC(crcSetTime1);
end;

procedure TfrmMain.btbSetTime2Click(Sender: TObject);
const
  mpZ:  array[0..9] of byte = ($45, $F6, $57, $27, $E6, $16, $D6, $56, $E6, $47);
var
  tiT:  times;
  stT:  string;
  mpT:  array[0..9] of byte;
  i:    byte;
begin
  inherited;

  InitPushCRC;
  Push(56);

  tiT := Str2Times(medSetTime2.Text);
  with tiT do begin
    Push(bSecond);
    Push(bMinute);
    Push(bHour);
    Push(bDay);
    Push(bMonth);
    Push(bYear);
  end;

  stT := medPass2.Text;
  
  for i := 0 to 9 do mpT[i] := 0;

  for i := 0 to Length(stT) do begin
    if i > 9 then break;
    if Ord(stT[i+1]) = $20 then
      mpT[i] := 0
    else  
      mpT[i] := Ord(stT[i+1]) - $30;
  end; 
  
  for i := 0 to 9 do Push(mpT[i] xor mpZ[i]);

  QueryCRC(crcSetTime2);
end;

procedure TfrmMain.IdTCPClientAfterBind(Sender: TObject);
begin
  inherited;
  AddTerminalTime('IdTCPClient - AfterBind',clGray);
end;

procedure TfrmMain.IdTCPClientBeforeBind(Sender: TObject);
begin
  inherited;
  AddTerminalTime('IdTCPClient - BeforeBind',clGray);
end;

procedure TfrmMain.IdTCPClientConnected(Sender: TObject);
var
  s: string;
begin
  inherited;
  s := '����������� ���������� c �������: ' + IdTCPClient.Host + ':' + IntToStr(IdTCPClient.Port);

  AddTerminalTime(s,clGray);
  AddDial(s);
  InfBox(s);
end;

procedure TfrmMain.IdTCPClientDisconnected(Sender: TObject);
var
  s: string;
begin
  inherited;
  s := '������������';

  AddTerminalTime(s,clGray);
  AddDial(s);
end;

procedure TfrmMain.IdTCPClientSocketAllocated(Sender: TObject);
begin
  inherited;
  AddTerminalTime('IdTCPClient - SocketAllocated',clGray);
end;

procedure TfrmMain.IdTCPClientStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
var
  s: string;
begin
  inherited;
  s := '�������: ' + AStatusText;

  AddTerminalTime(s,clGray);
  AddDial(s);
end;

procedure TfrmMain.IdTCPClientWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
var
  s: string;
begin
  inherited;
  if AWorkMode = wmRead then
    s := '������: ' + IntToStr(AWorkCount) + ' ����'
  else
    s := '������: ' + IntToStr(AWorkCount) + ' ����';

  AddTerminalTime(s,clGray);
  AddDial(s);
end;

procedure TfrmMain.IdTCPClientWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
var
  s: string;
begin
  inherited;
  if AWorkMode = wmRead then
    s := '������ ������: �������� ' + IntToStr(AWorkCountMax) + ' ����'
  else
    s := '������ ������: �������� ' + IntToStr(AWorkCountMax) + ' ����';

  AddTerminalTime(s,clGray);
  AddDial(s);
end;

procedure TfrmMain.IdTCPClientWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
var
  s: string;
begin
  inherited;
  if AWorkMode = wmRead then
    s := '������ ���������'
  else
    s := '������ ���������';

  AddTerminalTime(s,clGray);
  AddDial(s);
end;

procedure TfrmMain.pgcModeChange(Sender: TObject);
begin
  inherited;
  if pgcMode.ActivePage = tbsPort then begin
    TAPIoff;
  end
  else if pgcMode.ActivePage = tbsModem then begin
    TAPIon;
  end
  else if pgcMode.ActivePage = tbsSocket then begin
  end
end;

procedure TfrmMain.btbSocketOpenClick(Sender: TObject);
var
  Port: word;
begin
  inherited;
  try
    Port := StrToIntDef(edtSocketPort.Text, 0);

    if (Port = 0) then
      ErrBox('���� ������ ����� �����������')
    else begin
      IdTCPClient.Host := edtSocketHost.Text;
      IdTCPClient.Port := Port;
      IdTCPClient.Connect;

      SocketInputThread := TSocketInputThread.Create(True);
      SocketInputThread.FreeOnTerminate := True;
      SocketInputThread.Resume;
    end;
  except
    on e: Exception do ErrBox('������ ��� �������� ������: ' + e.Message);
  end;
end;

//http://stackoverflow.com/questions/12507677/terminate-a-thread-and-disconnect-an-indy-client
procedure TfrmMain.btbSocketCloseClick(Sender: TObject);
begin
  inherited;
  try
    if SocketInputThread <> nil then SocketInputThread.Terminate;
    try
      if IdTCPClient.Connected then IdTCPClient.Disconnect;
    finally
      if SocketInputThread <> nil then
      begin
        SocketInputThread.WaitFor;
        SocketInputThread.Free;
        SocketInputThread := nil;
      end;
    end;
  except
    on e: Exception do AddTerminalTime('������ ��� �������� ������: ' + e.Message,clGray);
  end;
end;

procedure TfrmMain.SaveMemo(Memo: TMemo; stName: string);
begin
  with sd_RichToFile,Memo do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0));

      SysUtils.ForceDirectories(InitialDir);
      FileName := stName + '.txt';

      if Execute then Memo.Lines.SaveToFile(FileName);
    except
      ErrBox('������ ��� ���������� ������ !')
    end;
  end;
end;

procedure TfrmMain.SaveLog(Memo: TMemo; stName: string);
var
  s: string;
begin
  with Memo do if Lines.Count > 0 then begin
    try
      s := ExtractFileDir(ParamStr(0)) + '\'+ LOGS_DIR + '\'+ FormatDateTime('dd_mm_yyyy',Now) + '\';
      SysUtils.ForceDirectories(s);
      
      Memo.Lines.Append('');
      Memo.Lines.Append('// '+mitVersion.Caption);
      
      Memo.Lines.SaveToFile(s + stName + '.log');
    except
      ErrBox('������ ��� ���������� ������ !')
    end;
  end;
end;

procedure TfrmMain.btbClearTerminalClick(Sender: TObject);
begin
  inherited;
  SaveLog(redTerminal, '�������� ' + DateTime2Str + ' ');
  ClearTerminal;
end;

procedure TfrmMain.btbExportTerminalClick(Sender: TObject);
begin
  inherited;
  SaveLog(redTerminal, '�������� ' + DateTime2Str + ' ');
  SaveMemo(redTerminal, '�������� ' + DateTime2Str + ' ');
end;

function TfrmMain.GetInterval(i: byte): string;
begin
  Result := IntToStr2(i div 2) + ':' + IntToStr2((i mod 2)*30);
end;

procedure TfrmMain.ClearGraphInquiry;
var
  x,y:  byte;
begin
  with stgGraphInquiry do begin
    RowCount := 48 + 1;
    ColCount := 4 + 1;

    for x := 0 to 4 do
      for y := 0 to 48 do
        Cells[x,y] := '';

    for x := 1 to 4 do
      Cells[x,0] := ' ���� ' + IntToStr(x);

    for y := 0 to 48-1 do
      Cells[0,y+1] := ' ' + GetInterval(y);
  end;
end;

procedure TfrmMain.ClearGraphCorrect;
var
  y:  byte;
begin
  with stgGraphCorrect do begin
    RowCount := 48 + 1;
    ColCount := 1 + 1;

    for y := 0 to 48 do
      Cells[1,y] := '';

    for y := 0 to 48-1 do
      Cells[0,y+1] := ' ' + GetInterval(y);
  end;
end;

procedure TfrmMain.ClearGraphRecalc;
var
  y:  byte;
begin
  //rgrGraphRecalc.ItemIndex := -1;

  with stgGraphRecalc do begin
    RowCount := 48 + 1;
    ColCount := 1 + 1;

    for y := 0 to 48 do
      Cells[1,y] := '';

    for y := 0 to 48-1 do
      Cells[0,y+1] := ' ' + GetInterval(y);
  end;
end;

procedure TfrmMain.ClearGraphTransit;
var
  y:  byte;
begin
  with stgGraphTransit do begin
    RowCount := 48 + 1;
    ColCount := 1 + 1;

    for y := 0 to 48 do
      Cells[1,y] := '';

    for y := 0 to 48-1 do
      Cells[0,y+1] := ' ' + GetInterval(y);
  end;
end;

procedure TfrmMain.btbClearGraphInquiryClick(Sender: TObject);
begin
  inherited;
  ClearGraphInquiry;
end;

procedure TfrmMain.btbClearGraphCorrectClick(Sender: TObject);
begin
  inherited;
  ClearGraphCorrect;
end;

procedure TfrmMain.btbClearGraphRecalcClick(Sender: TObject);
begin
  inherited;
  ClearGraphRecalc;
end;

procedure TfrmMain.btbClearGraphTransitClick(Sender: TObject);
begin
  inherited;
  ClearGraphTransit;
end;

procedure TfrmMain.btbGetGraphInquiryClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  ClearGraphInquiry;

  iwAlfa := 0;

  InitPushCRC;
  Push(15);
  Push(iwAlfa);
  InitLoad('������ ������� ������ ���������', 4, acGetGraphInquiry);
end;

procedure TfrmMain.btbGetGraphCorrectClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  ClearGraphCorrect;

  InitPushCRC;
  Push(14);
  QueryCRC(acGetGraphCorrect);
end;

procedure TfrmMain.btbGetGraphRecalcClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  ClearGraphRecalc;

  InitPushCRC;
  Push(41);
  QueryCRC(acGetGraphRecalc);
end;

procedure TfrmMain.btbGetGraphTransitClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  ClearGraphTransit;

  InitPushCRC;
  Push(21);
  QueryCRC(acGetGraphTransit);
end;

procedure TfrmMain.btbSetGraphInquiryClick(Sender: TObject);
var
  x,y:  byte;
  s:    string;
begin
  inherited;
  NormalMode;

  for x := 1 to 4 do begin
    for y := 1 to 48 do begin
      s := stgGraphInquiry.Cells[x,y];
      if not ((s = GRAPH_PLUS) or (s = GRAPH_MINUS))
      then begin ErrBox('�� ����� ������� �������: ' + GetInterval(y-1)); exit; end;
    end;
  end;

  iwAlfa := 0;

  InitPushCRC;
  Push(73);
  Push(iwAlfa);

  for y := 1 to 48 do begin
    s := stgGraphInquiry.Cells[iwAlfa+1,y];
    if s = GRAPH_PLUS then Push(255)
    else Push(0);
  end;

  InitLoad('������ ������� ������ ���������', 4, acSetGraphInquiry);
end;

procedure TfrmMain.btbSetGraphCorrectClick(Sender: TObject);
var
  y:  byte;
  s:  string;
begin
  inherited;
  NormalMode;

  InitPushCRC;
  Push(72);

  for y := 1 to 48 do begin
    s := stgGraphCorrect.Cells[1,y];
    if s = GRAPH_PLUS then Push(255)
    else if s = GRAPH_MINUS then Push(0)
    else begin ErrBox('�� ����� ������� �������: ' + GetInterval(y-1)); exit; end;
  end;

  QueryCRC(acSetGraphCorrect);
end;

procedure TfrmMain.btbSetGraphRecalcClick(Sender: TObject);
var
  y:  byte;
  s:  string;
begin
  inherited;
  NormalMode;

  InitPushCRC;
  Push(75);

  Push($55);
{
  with rgrGraphRecalc do begin
    if ItemIndex = 0 then Push(0)
    else if ItemIndex = 1 then Push(255)
    else begin ErrBox('������� ���������� ������ �� ������'); exit; end;
  end;
}
  for y := 1 to 48 do begin
    s := stgGraphRecalc.Cells[1,y];
    if s = GRAPH_PLUS then Push(255)
    else if s = GRAPH_MINUS then Push(0)
    else begin ErrBox('�� ����� ������� �������: ' + GetInterval(y-1)); exit; end;
  end;

  QueryCRC(acSetGraphRecalc);
end;

procedure TfrmMain.btbSetGraphTransitClick(Sender: TObject);
var
  y:  byte;
  s:  string;
begin
  inherited;
  NormalMode;

  InitPushCRC;
  Push(92);

  for y := 1 to 48 do begin
    s := stgGraphTransit.Cells[1,y];
    if s = GRAPH_PORT3
      then Push(3-1)
    else if s = GRAPH_PORT4
      then Push(4-1)
    else if s = GRAPH_MINUS
      then Push(0)
    else
      begin ErrBox('�� ����� ������� �������: ' + GetInterval(y-1)); exit; end;
  end;

  QueryCRC(acSetGraphTransit);
end;

procedure TfrmMain.btbSaveGraphInquiryClick(Sender: TObject);
begin
  inherited;
  SaveGrid(stgGraphInquiry, '������ ������ ���������', stSETTINGS, table_graph_inquiry);
end;

procedure TfrmMain.btbSaveGraphCorrectClick(Sender: TObject);
begin
  inherited;
  SaveGrid(stgGraphCorrect, '������ ��������� �������', stSETTINGS, table_graph_correct);
end;

procedure TfrmMain.btbSaveGraphRecalcClick(Sender: TObject);
begin
  inherited;
  SaveGrid(stgGraphRecalc, '������ ����������� ������', stSETTINGS, table_graph_recalc);
end;

procedure TfrmMain.btbSaveGraphTransitClick(Sender: TObject);
begin
  inherited;
  SaveGrid(stgGraphTransit, '������ ��������������� ��������', stSETTINGS, table_graph_transit);
end;

procedure TfrmMain.btbLoadGraphInquiryClick(Sender: TObject);
begin
  inherited;
  with od_CustomLoad do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stSETTINGS;
      SysUtils.ForceDirectories(InitialDir);

      if Execute then begin
        if ImportGraphInquiry(FileName) then
          InfBox('������ ������ ��������� �������� �������');
      end;
    except
      ErrBox('������ ��� ������ ������� ������ ��������� !');
    end;
  end;
end;

procedure TfrmMain.btbLoadGraphCorrectClick(Sender: TObject);
begin
  inherited;
  with od_CustomLoad do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stSETTINGS;
      SysUtils.ForceDirectories(InitialDir);

      if Execute then begin
        if ImportGraphCorrect(FileName) then
          InfBox('������ ��������� ������� �������� �������');
      end;
    except
      ErrBox('������ ��� ������ ������� ������� ��������� !');
    end;
  end;
end;

procedure TfrmMain.btbLoadGraphRecalcClick(Sender: TObject);
begin
  inherited;
  with od_CustomLoad do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stSETTINGS;
      SysUtils.ForceDirectories(InitialDir);

      if Execute then begin
        if ImportGraphRecalc(FileName) then
          InfBox('������ ����������� ������ �������� �������');
      end;
    except
      ErrBox('������ ��� ������ ������� ����������� ������ !');
    end;
  end;
end;

procedure TfrmMain.btbLoadGraphTransitClick(Sender: TObject);
begin
  inherited;
  with od_CustomLoad do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stSETTINGS;
      SysUtils.ForceDirectories(InitialDir);

      if Execute then begin
        if ImportGraphTransit(FileName) then
          InfBox('������ �������� �������� �������');
      end;
    except
      ErrBox('������ ��� ������ ������� �������� !');
    end;
  end;
end;

procedure TfrmMain.GraphDblClick(StringGrid: TStringGrid);
begin
  inherited;
  with StringGrid do begin
    if (Col > 0) and (Row > 0) then begin
      if Cells[Col,Row] = GRAPH_MINUS then
        Cells[Col,Row] := GRAPH_PLUS
      else
        Cells[Col,Row] := GRAPH_MINUS;
    end;
  end;
end;

procedure TfrmMain.stgGraphInquiryDblClick(Sender: TObject);
begin
  inherited;
  GraphDblClick(stgGraphInquiry);
end;

procedure TfrmMain.stgGraphCorrectDblClick(Sender: TObject);
begin
  inherited;
  GraphDblClick(stgGraphCorrect);
end;

procedure TfrmMain.stgGraphRecalcDblClick(Sender: TObject);
begin
  inherited;
  GraphDblClick(stgGraphRecalc);
end;

procedure TfrmMain.stgGraphTransitDblClick(Sender: TObject);
begin
  inherited;
  with stgGraphTransit do begin
    if (Col > 0) and (Row > 0) then begin
      if Cells[Col,Row] = GRAPH_MINUS then
        Cells[Col,Row] := GRAPH_PORT3
      else if Cells[Col,Row] = GRAPH_PORT3 then
        Cells[Col,Row] := GRAPH_PORT4
      else
        Cells[Col,Row] := GRAPH_MINUS;
    end;
  end;
end;

procedure TfrmMain.cmbGridLinesParChange(Sender: TObject);
begin
  inherited;
  ParamsCmbLines;
end;

procedure TfrmMain.cmbGridLinesParExit(Sender: TObject);
begin
  inherited;
  ParamsCmbLines;
end;

procedure TfrmMain.btbGetCanalsNamesClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  ClearCanalsNames;

  iwAlfa := 0;

  InitPushCRC;
  Push(113);
  Push(iwAlfa);
  InitLoad('������ �������� �������', bCANALS-1, acGetCanalsNames);
end;

procedure TfrmMain.btbSetCanalsNamesClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  iwAlfa := 0;

  SaveCanalsNames(iwAlfa);
  InitLoad('������ �������� �������', bCANALS-1, acSetCanalsNames);
end;

procedure TfrmMain.btbImportCanalsNamesClick(Sender: TObject);
begin
  inherited;
  with od_CustomLoad do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stSETTINGS;
      SysUtils.ForceDirectories(InitialDir);

      if Execute then begin
        if ImportCanalsNames(FileName) then
          InfBox('������ �������� ������� �������� �������');
      end;
    except
      ErrBox('������ ��� ������ ������ �������� ������� !');
    end;
  end;
end;

procedure TfrmMain.btbExportCanalsNamesClick(Sender: TObject);
begin
  inherited;
  SaveGrid(stgCanalsNames, '������ �������� �������', stSETTINGS, table_canals_names);
end;

procedure TfrmMain.btbClearCanalsNamesClick(Sender: TObject);
begin
  inherited;
  ClearCanalsNames;
end;

procedure TfrmMain.btbGetGroupsNamesClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  ClearGroupsNames;

  iwAlfa := 0;

  InitPushCRC;
  Push(115);
  Push(iwAlfa);
  InitLoad('������ �������� �����', bGROUPS-1, acGetGroupsNames);
end;

procedure TfrmMain.btbSetGroupsNamesClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  iwAlfa := 0;

  SaveGroupsNames(iwAlfa);
  InitLoad('������ �������� �����', bGROUPS-1, acSetGroupsNames);
end;

procedure TfrmMain.btbClearGroupsNamesClick(Sender: TObject);
begin
  inherited;
  ClearGroupsNames;
end;

procedure TfrmMain.btbGetObjectNameClick(Sender: TObject);
begin
  inherited;
  NormalMode;

  InitPushCRC;
  Push(111);
  QueryCRC(acGetObjectName);
end;

procedure TfrmMain.btbSetObjectNameClick(Sender: TObject);
var
  stT:  string;
  x:    byte;
begin
  inherited;
  InitPushCRC;
  Push(112);

  stT := Trim(edtObjectName.Text);

  for x := 1 to NAMES do
    if x <= Length(stT) then Push(Ord(stT[x])) else Push(0);

  QueryCRC(acSetObjectName);
end;

procedure TfrmMain.btbClearObjectNameClick(Sender: TObject);
begin
  inherited;
  edtObjectName.Text := '';
end;

procedure TfrmMain.btbExportGroupsNamesClick(Sender: TObject);
begin
  inherited;
  SaveGrid(stgGroupsNames, '������ �������� �����', stSETTINGS, table_groups_names);
end;

procedure TfrmMain.btbImportGroupsNamesClick(Sender: TObject);
begin
  inherited;
  with od_CustomLoad do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stSETTINGS;
      SysUtils.ForceDirectories(InitialDir);

      if Execute then begin
        if ImportGroupsNames(FileName) then
          InfBox('������ �������� ����� �������� �������');
      end;
    except
      ErrBox('������ ��� ������ ������ �������� ����� !');
    end;
  end;
end;

procedure TfrmMain.mniRelaxsClick(Sender: TObject);
begin
  inherited;
  SetActivePage(tbsRelaxs);
end;

procedure TfrmMain.mniGraphsClick(Sender: TObject);
begin
  inherited;
  SetActivePage(tbsGraphs);
end;

procedure TfrmMain.mniCorrect2Click(Sender: TObject);
begin
  inherited;
  SetActivePage(tbsCorrect2);
end;

procedure TfrmMain.mniNamesClick(Sender: TObject);
begin
  inherited;
  SetActivePage(tbsNames);
end;

procedure TfrmMain.btbGetAddresses2Click(Sender: TObject);
begin
  inherited;
  NormalMode;

  ClearAddresses2;

  iwAlfa := 0;

  InitPushCRC;
  Push(136);
  Push(iwAlfa);
  InitLoad('������ ������� � �������', bCANALS-1, acGetAddresses2);
end;

procedure TfrmMain.btbSetAddresses2Click(Sender: TObject);
begin
  inherited;
  NormalMode;

  iwAlfa := 0;

  SaveAddresses2(iwAlfa);
  InitLoad('������ ������� � �������', bCANALS-1, acSetAddresses2);
end;

procedure TfrmMain.btbImportAddresses2Click(Sender: TObject);
begin
  inherited;
  with od_CustomLoad do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0)) + stSETTINGS;
      SysUtils.ForceDirectories(InitialDir);

      if Execute then begin
        if ImportAddresses2(FileName) then
          InfBox('������ ������� � ������� �������� �������');
      end;
    except
      ErrBox('������ ��� ������ ������ ������� � ������� !');
    end;
  end;
end;

procedure TfrmMain.btbExportAddresses2Click(Sender: TObject);
begin
  inherited;
  SaveGrid(stgAddresses2, '������ ������� � ���������� �������', stSETTINGS, table_addresses2);
end;

procedure TfrmMain.btbClearAddresses2Click(Sender: TObject);
begin
  inherited;
  ClearAddresses2;
end;

end.





























