unit MainF;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, System.IOUtils,
  LbCipher, LbClass, FMX.Edit;

type
  TForm25 = class(TForm)
    nhtcl1: TNetHTTPClient;
    nhtrq1: TNetHTTPRequest;
    btn1: TButton;
    edt1: TEdit;
    lb3ds1: TLb3DES;
    edt2: TEdit;
    btn2: TButton;
    edt3: TEdit;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form25: TForm25;

implementation

uses
  System.Net.Mime;

{$R *.fmx}

procedure TForm25.btn1Click(Sender: TObject);
begin
  edt2.Text := lb3ds1.EncryptString(edt1.Text);
end;

procedure TForm25.btn2Click(Sender: TObject);
begin
  edt3.Text := nhtrq1.Get('http://localhost:8080/api/login/'+edt2.Text).ContentAsString;
end;


end.
