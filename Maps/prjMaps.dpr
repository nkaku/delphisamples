program prjMaps;

uses
  System.StartUpCopy,
  FMX.Forms,
  fMain in 'fMain.pas' {frmMaps},
  SurfSpotMapView in 'MapViewSurfSpot\SurfSpotMapView.pas' {Form26};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TfrmMaps, frmMaps);
  Application.Run;
end.
