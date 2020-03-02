unit MainF;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, System.IOUtils, FMX.ScrollBox,
  FMX.Memo;

type
  TForm25 = class(TForm)
    btn1: TButton;
    edt1: TEdit;
    mmo1: TMemo;
    btn2: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
    SettingFile: TStringList;
    FileName: string;
  public
    { Public declarations }
    procedure LoadFile;
  end;

var
  Form25: TForm25;

implementation

{$R *.fmx}

procedure TForm25.FormDestroy(Sender: TObject);
begin
  if Assigned(SettingFile) then
    SettingFile.Free;
end;

procedure TForm25.LoadFile;
begin
  if Assigned(SettingFile) then
    SettingFile.LoadFromFile(FileName);
end;

procedure TForm25.FormCreate(Sender: TObject);
begin
  if not Assigned(SettingFile) then
    SettingFile := TStringList.Create;
  FileName := TPath.GetDocumentsPath + PathDelim + 'appsettings.ini';

end;

procedure TForm25.btn1Click(Sender: TObject);
begin
  SettingFile.Add(edt1.Text);
  SettingFile.SaveToFile(FileName);
end;

procedure TForm25.btn2Click(Sender: TObject);
begin
  if FileExists(FileName) and Assigned(SettingFile) then
    mmo1.Lines.Text := SettingFile.Text;
end;


end.
