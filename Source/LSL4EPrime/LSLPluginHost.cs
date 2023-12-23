using LSL;
using System;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;

namespace LSL4EPrime
{
  [ComVisible(true)]
  [ClassInterface(ClassInterfaceType.None)]
  [Guid("9DEF58FE-1818-42B1-A0BD-6EB619BE56B5")]
  [ProgId("LSL4EPrime.LSLPluginHost")]
  public class LSLPluginHost : ILSLPluginHost
  {
    private liblsl.StreamInfo _eventStreamInfo;
    private liblsl.StreamOutlet _eventStreamOutlet;
    private int _eventCode;

    public LSLPluginHost()
    {
      try
      {
        Assembly executingAssembly = Assembly.GetExecutingAssembly();
        string str1 = executingAssembly.FullName.Split(',')[0];
        string str2 = executingAssembly.FullName.Split(',')[1].Split('=')[1];
        this._eventStreamInfo = new liblsl.StreamInfo(str1 + "_" + str2 + "_" + DateTimeOffset.Now.ToString("yyyy-MM-dd-HH-mm-ss") + "_Events", "Markers", channel_format: liblsl.channel_format_t.cf_string, source_id: Environment.MachineName);
        this._eventStreamInfo.desc().append_child_value("manufacturer", executingAssembly.GetCustomAttributes(typeof (AssemblyCompanyAttribute)).FirstOrDefault<Attribute>() is AssemblyCompanyAttribute companyAttribute ? companyAttribute.Company : (string) null);
        this._eventStreamInfo.desc().append_child_value("app", str1);
        liblsl.XMLElement xmlElement = this._eventStreamInfo.desc();
        xmlElement.append_child_value("version", str2);
        xmlElement = this._eventStreamInfo.desc();
        xmlElement.append_child_value("device ID", Environment.MachineName);
        xmlElement = this._eventStreamInfo.desc();
        xmlElement.append_child_value("os version", Environment.OSVersion.VersionString);
        this._eventStreamOutlet = new liblsl.StreamOutlet(this._eventStreamInfo);
      }
      catch
      {
      }
    }

    [ComVisible(true)]
    public void PushEventMessage(int eventCode)
    {
      try
      {
        if (!this._eventStreamOutlet.have_consumers())
          return;
        this._eventCode = eventCode;
        this._eventStreamOutlet.push_sample(new string[1]
        {
          eventCode.ToString()
        }, liblsl.local_clock());
      }
      catch
      {
      }
    }

    private void PushButtonEventMessage(int buttonCode)
    {
      try
      {
        int eventCode = this._eventCode;
        if (eventCode < 40000 || eventCode >= 60000)
          return;
        if (eventCode < 50000)
          eventCode += 10000;
        this.PushEventMessage(eventCode + 10000 + buttonCode);
      }
      catch
      {
      }
    }

    [ComVisible(true)]
    public void Initialize()
    {
      try
      {
        KeyboardHook.CreateHook(new KeyboardHook.KeyHandlerDelegate(this.KeyHandler));
      }
      catch
      {
      }
    }

    [ComVisible(true)]
    public void Dispose()
    {
      try
      {
        KeyboardHook.DestroyHook();
      }
      catch
      {
      }
    }

    internal void KeyHandler(IntPtr wParam, IntPtr lParam)
    {
      try
      {
        int buttonCode = 0;
        switch ((EVK) Marshal.ReadInt32(lParam))
        {
          case EVK.VK_1:
          case EVK.VK_NUMPAD1:
            buttonCode = 2;
            break;
          case EVK.VK_2:
          case EVK.VK_NUMPAD2:
            buttonCode = 3;
            break;
        }
        this.PushButtonEventMessage(buttonCode);
      }
      catch
      {
      }
    }
  }
}
