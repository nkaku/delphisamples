unit fMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Maps,
  System.Sensors, System.Sensors.Components, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Objects;

type
  TfrmMaps = class(TForm)
    mpvw1: TMapView;
    lctnsnsr1: TLocationSensor;
    btn1: TButton;
    img1: TImage;
    procedure btn1Click(Sender: TObject);
    procedure lctnsnsr1LocationChanged(Sender: TObject; const OldLocation,
        NewLocation: TLocationCoord2D);

  private
    { Private declarations }
  public
    { Public declarations }
    function GetNewMarker: TMapMarkerDescriptor;
  end;

var
  frmMaps: TfrmMaps;

implementation

{$R *.fmx}


procedure TfrmMaps.btn1Click(Sender: TObject);
var
  MD          : TMapMarkerDescriptor;
  R1,
  R2          : Integer;
  Location    : TMapCoordinate;
begin
  R1 := Random(9999999);
  R2 := Random(9999999);
  Location := TMapCoordinate.Create(19 + (R1/10000000),72 + (R2/10000000));

  MD := TMapMarkerDescriptor.Create(Location, 'Marker'+Random(99).ToString);
  MD.Icon := img1.Bitmap;
  img1.Visible := True;
  MD.Draggable := False;

  mpvw1.AddMarker(MD);

  mpvw1.Location := Location;
  mpvw1.Zoom := 8;
end;


end.
