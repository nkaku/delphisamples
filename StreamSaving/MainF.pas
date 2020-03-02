unit MainF;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, System.IOUtils;

type
  TForm25 = class(TForm)
    btn1: TButton;
    img1: TImage;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    nhtcl1: TNetHTTPClient;
    nhtrq1: TNetHTTPRequest;
    procedure btn1Click(Sender: TObject);
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

function GetDocumentsPath: string;
begin
  {$IFDEF MSWINDOWS}
  Result := GetCurrentDir + PathDelim;
  {$ENDIF}

  {$IFDEF ANDROID}
  Result := TPath.GetDocumentsPath + PathDelim;
  {$ENDIF}

  {$IFDEF IOS}
  // have to fill this in
  {$ENDIF}
end;


procedure TForm25.btn1Click(Sender: TObject);
  function StringToHex16(str: string): string;
  var
    i: integer;
    s: string;
  begin
    s := '';

    for i := 1 to length(str) do
      s := s + inttohex(integer(str[i]), 4);

    result := s;
  end;

var
  X       : TMultiPartFormData;
  MS      : TMemoryStream;
  P       : PBitmapCodecSaveParams;
begin
  X := TMultipartFormData.Create;
  P := New(PBitmapCodecSaveParams);
  P^.Quality := 100;

  { using files }
  img1.Bitmap.SaveToFile(GetDocumentsPath + 'viafile.bmp', P);
  X.AddFile('UploadData', GetDocumentsPath + 'viafile.bmp');

  { using streams --------- begin }
  MS := TMemoryStream.Create;
  img1.Bitmap.SaveToStream(MS);
  lbl1.Text := MS.Size.ToString;
  lbl2.Text := (img1.Bitmap.Size.cx * img1.Bitmap.Size.cy).ToString;

  X.AddStream('UploadData', MS, 'viastream.jpg');

  { using streams --------- end }

  nhtrq1.Post('http://192.168.1.10:8080/api/upload', X);

  if Assigned(MS) then
    MS.Free;

  X.Free;
  FreeMem(P);
end;

end.
