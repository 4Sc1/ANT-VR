using System;
using System.Diagnostics;
using System.Runtime.InteropServices;

/// Source: Code Project
/// Author: George Mamaladze
/// Year: 2004
/// Link: https://www.codeproject.com/Articles/7294/Processing-Global-Mouse-and-Keyboard-Hooks-in-C
/// License: https://www.codeproject.com/info/cpol10.aspx
/// Remark: Original code has been changed.
namespace LSL4EPrime
{
  internal static class KeyboardHook
  {
    private static IntPtr HHK = IntPtr.Zero;
    private static KeyboardHook.HookDelegate HD;
    private static KeyboardHook.KeyHandlerDelegate KH;

    [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    private static extern IntPtr SetWindowsHookEx(
      int idHook,
      KeyboardHook.HookDelegate lpfn,
      IntPtr hMod,
      uint dwThreadId);

    [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    [return: MarshalAs(UnmanagedType.Bool)]
    private static extern bool UnhookWindowsHookEx(IntPtr hhk);

    [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    private static extern IntPtr CallNextHookEx(
      IntPtr hhk,
      int nCode,
      IntPtr wParam,
      IntPtr lParam);

    [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    private static extern IntPtr GetModuleHandle(string lpModuleName);

    [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    internal static extern short GetKeyState(int vKey);

    internal static void CreateHook(KeyboardHook.KeyHandlerDelegate kh)
    {
      ProcessModule mainModule = Process.GetCurrentProcess().MainModule;
      KeyboardHook.HD = new KeyboardHook.HookDelegate(KeyboardHook.HookFunc);
      KeyboardHook.KH = kh;
      KeyboardHook.HHK = KeyboardHook.SetWindowsHookEx(13, KeyboardHook.HD, KeyboardHook.GetModuleHandle(mainModule.ModuleName), 0U);
    }

    internal static bool DestroyHook() => KeyboardHook.UnhookWindowsHookEx(KeyboardHook.HHK);

    private static IntPtr HookFunc(int nCode, IntPtr wParam, IntPtr lParam)
    {
      int int32 = wParam.ToInt32();
      if (nCode >= 0 && (int32 == 256 || int32 == 260))
        KeyboardHook.KH(wParam, lParam);
      return KeyboardHook.CallNextHookEx(KeyboardHook.HHK, nCode, wParam, lParam);
    }

    private delegate IntPtr HookDelegate(int nCode, IntPtr wParam, IntPtr lParam);

    internal delegate void KeyHandlerDelegate(IntPtr wParam, IntPtr lParam);
  }
}
