unit android.JNI.UseAsJAR;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes;


type
  JUseAsJARClass =  interface(JObjectClass)
  ['{58159490-F0A1-4CBE-85CD-824CB5B9FE00}']
    function echoPlease(S: JString): JString; cdecl;
  end;

  [JavaSignature('Work/VIMOVYAA/PeterWilliams/Test/JNI/UseAsJAR')]
  JUseAsJAR = interface(JObject)
    ['{B62D20F3-23F8-4EA7-B011-6B7C8DBA3D85}']
  end;

  TJUseAsJAR = class(TJavaGenericImport<JUseAsJARClass, JUseAsJAR>) end;

implementation

end.
