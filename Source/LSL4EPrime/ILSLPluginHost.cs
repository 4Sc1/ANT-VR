using System.Runtime.InteropServices;

namespace LSL4EPrime
{
  [ComVisible(true)]
  [Guid("174640FE-BD76-4B36-A1F8-0C362A30568F")]
  [InterfaceType(ComInterfaceType.InterfaceIsDual)]
  public interface ILSLPluginHost
  {
    void PushEventMessage(int eventCode);

    void Initialize();

    void Dispose();
  }
}
